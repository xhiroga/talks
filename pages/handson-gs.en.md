## Let's Build a Splat First

Install [Scaniverse](https://scaniverse.com/) on your smartphone and try scanning a small object.

<img class="h-80 place-self-center" src="https://img.youtube.com/vi/8tyxiiu5EC8/maxresdefault.jpg">[^sawara]

[^sawara]: [Scaniverse (demo by the speaker)](https://www.youtube.com/watch?v=8tyxiiu5EC8)

---

## Export Your Splat

You can export splats created in Scaniverse as PLY or SPZ files.

<img class="h-80 place-self-center" src="https://img.youtube.com/vi/cMenWEiXUdw/maxresdefault.jpg">[^sawara]

[^sawara]: [Scaniverse (demo by the speaker)](https://www.youtube.com/watch?v=cMenWEiXUdw)

---

## Share What You Made

Point-cloud data such as PLY files can be published on SuperSplat.

Until you check "List," only people with the link can view it. You can review your own splats from [Manage](https://superspl.at/manage).

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/Qzc6cUJFCZ8/maxresdefault.jpg">[^sawara]

[^sawara]: [SuperSplat (demo by the speaker)](https://www.youtube.com/watch?v=Qzc6cUJFCZ8)

---
layout: two-cols-header
---

## Software for Creating Gaussian Splatting Content

<p/>

::left::

### OSS

- **[nerfstudio](https://github.com/nerfstudio-project/nerfstudio)**: Supports a variety of image-to-3D reconstruction methods including NeRF and 3D Gaussian Splatting
- [gsplat](https://github.com/nerfstudio-project/gsplat): Core 3DGS implementation for nerfstudio; available on PyPI (`pip install gsplat`)
- [Inria 3DGS](https://github.com/graphdeco-inria/gaussian-splatting): Official implementation of the original “3D Gaussian Splatting for Real-Time Radiance Field Rendering” paper

::right::

### Commercial Software

- **postshot**: Windows application with 3DGS support. Free trial available; exporting PLY and other formats requires a paid plan.
- **Scaniverse**: 3D scanning app by Niantic of Pokémon GO fame. Supports both photogrammetry and 3D Gaussian Splatting.
- **LumaAI**: Captures on iOS/Android and processes in the cloud to generate 3DGS in about 20–30 minutes. Exports PLY, OBJ/USDZ, and other splat-friendly formats.

---
references:
- https://chatgpt.com/c/68d9c3b5-af40-8329-a987-e4a1ac69f7c4
- https://zenn.dev/tmb0703/articles/e2e7a48bc5bb2c
---

## Output Formats for Gaussian Splatting

As of September 2025, there is no industry-standard format dedicated to Gaussian Splatting.

<div class="text-xs">

| | Key Characteristics | Size / Quality | Primary Use Cases & Tools |
| --- | --- | --- | --- |
| PLY | Originally for point clouds | Uncompressed | Common default in tools like nerfstudio |
| SPLAT | Originated from the official Inria implementation | Smaller than PLY and lossless | GraphDeco Viewer, etc. |
| NPZ | NumPy-compressed format output by Compact 3DGS | Higher compression than PLY with near-lossless quality | Compact-3DGS, etc. |
| SOG | WebP textures plus `meta.json` | 15–20× smaller than PLY with lossy compression | PlayCanvas, etc. |
| SPZ | Gzip-based binary proposed by Niantic | Around 10× smaller than PLY with production-ready quality | Scaniverse, etc. |

</div>

---
references:
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/creating/recommended-tools/
- https://evergine.com/gaussian-splatting-add-on/
- https://github.com/maincold2/Compact-3DGS
---

## Workflow for Producing Gaussian Splatting Content

Ryū (@lilea) has a great guide: [🌈 Gaussian Splatting Utilization](https://zenn.dev/lilealab/books/how-to-photogrammety/viewer/3dgs). Highly recommended.

---
layout: two-cols-header
references:
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/creating/taking-photos/
---

## Capturing Photos/Videos (Small Objects)

<p/>

::left::

### Tips

- Minimize camera shake whenever possible
- Control exposure and lighting
- Keep the background simple
- Move the camera instead of using a turntable (unless you intend to remove the entire background)

::right::

Example footage (feel free to use it!)

<a href="https://www.youtube.com/watch?v=-VFPWplI8Tg" target="_blank"><img class="place-self-center" src="https://img.youtube.com/vi/-VFPWplI8Tg/maxresdefault.jpg"></a>

---

## Capturing Photos/Videos (Locations)

[Photogrammetry](https://www.docswell.com/s/lileaLab/KW132X-231004#p13) from [Ryū lilea’s](https://lilea.net/lab) workshop materials is extremely informative.

(Thank you for sharing!)

---

## Building 3DGS with nerfstudio

<p/>

1. Clone nerfstudio from GitHub (use the xhiroga fork)
2. Install COLMAP
3. Run a command such as `scripts/splatfacto.sh $VIDEO_FILE`

<!--
Could not get COLMAP running on Google Colab, so this workflow was shelved...
1. Open [Create 3DGS with nerfstudio.ipynb](https://colab.research.google.com/drive/1Q-AVVcBZ0bwGVXRqAkGGAAc6UlmJTJEF?usp=sharing)
2. File > Save a copy in Drive
3. Follow the instructions in the notebook
-->

Processing time and file-size reference

- Example: 12-second HD video → 34 minutes total (10 minutes for COLMAP, 24 minutes for splat generation) → 35 MB PLY file

---
references:
- https://lilea.net/lab/how-to-use-postshot/
---

## Creating Splats with postshot Alone

Drag and drop videos or multiple images to easily reconstruct a 3D scene.

Note that exporting is limited in the free tier.

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/4UCbM_U9fXQ/maxresdefault.jpg">[^sawara]

[^sawara]: [postshot (demo by the speaker)](https://www.youtube.com/watch?v=4UCbM_U9fXQ)

---
references:
- https://www.jawset.com/docs/d/Postshot+User+Guide/Importing+Images
- https://lilea.net/lab/how-to-use-postshot/
- https://zenn.dev/hololab/articles/realitycapture-to-colmap
- https://begin3d.com/sej_rs-ps-3dgs001_index
- https://www.youtube.com/watch?v=yENSTr1d57s&feature=youtu.be
---

## Building Splats with RealityScan and postshot

RealityScan 2.0 does not yet support Gaussian Splatting, but exporting in COLMAP format prepares the data for splat creation. That way you can start from stable LiDAR captures.

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/44GFmICpvb4/maxresdefault.jpg">[^sawara]

[^sawara]: [RealityScan & postshot (demo by the speaker)](https://www.youtube.com/watch?v=44GFmICpvb4)

---
layout: two-cols-header
---

## Viewing Splats in the Browser

You can quickly preview splats generated with nerfstudio or postshot directly in a browser.

::left::

### Steps

<p/>

1. Open the [PlayCanvas Model Viewer](https://playcanvas.com/viewer)
2. Drag and drop your `.ply` or `.sog` files

::right::

<img class="place-self-center" src="https://img.youtube.com/vi/Q0FQkWU8aoE/maxresdefault.jpg">

[1]: [PlayCanvas Model Viewer (demo by the speaker)](https://www.youtube.com/watch?v=Q0FQkWU8aoE)
