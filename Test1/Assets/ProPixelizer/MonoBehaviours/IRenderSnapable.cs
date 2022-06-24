// Copyright Elliot Bentine, 2018-
using UnityEngine;

namespace Pixel3D
{
    /// <summary>
    /// An interface for objects that can be snapped into position/orientation for rendering.
    /// </summary>
    public interface IRenderSnapable
    {
        /// <summary>
        /// Save the current transform.
        /// </summary>
        void SaveTransform();

        /// <summary>
        /// Restore a previously save transform.
        /// </summary>
        void RestoreTransform();

        /// <summary>
        /// Snap object rotations
        /// </summary>
        void SnapAngles();
    }
}
