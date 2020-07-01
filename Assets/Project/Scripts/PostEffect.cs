using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffect : MonoBehaviour
{
    [SerializeField] private Material[] _materials = null;

    private Material _currentMaterial = null;
    private int _index = 0;
    private bool _enableEffect = true;

    private void Awake()
    {
        _currentMaterial = _materials[0];
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.N))
        {
            Next();
        }

        if (Input.GetKeyDown(KeyCode.T))
        {
            ToggleEffect();
        }
    }

    private void OnGUI()
    {
        if (GUI.Button(new Rect(10, 10, 150, 30), "Next (N)"))
        {
            Next();
        }

        if (GUI.Button(new Rect(10, 50, 150, 30), "Disable (T)"))
        {
            ToggleEffect();
        }
    }

    private void Next()
    {
        _index = (_index + 1) % _materials.Length;
        _currentMaterial = _materials[_index];
    }

    private void EnableEffect(bool enable)
    {
        _enableEffect = enable;
    }

    private void ToggleEffect()
    {
        EnableEffect(!_enableEffect);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_enableEffect)
        {
            Graphics.Blit(source, destination, _currentMaterial);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
