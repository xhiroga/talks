## Try It First

Visit [SuperSplat](https://superspl.at/) and explore the different splats that are available.

---
references:
- [Comparison of 3D Generation Techniques (Photogrammetry & NeRF & 3D Gaussian Splatting)](https://qiita.com/yukis0111/items/87359b30ddef2856d3fa)
---

## History of 3D Reconstruction

| Era | Technique | Key Milestones |
| --- | --- | --- |
| 1860s | Photogrammetry | The first photogrammetry research was reported in Germany in 1867, and photo-based surveying began to be used for mapping |
| 2000s | SfM / MVS | Structure-from-Motion and Multi-View Stereo methods emerge to estimate camera poses and generate point clouds from digital photos |
| 2020 | NeRF | Mildenhall et al. publish NeRF, drawing attention to high-quality novel view synthesis with neural radiance fields |
| 2023 | 3D Gaussian Splatting | Kerbl et al. present 3D Gaussian Splatting, enabling real-time rendering |

---
references:
- https://zenn.dev/lilealab/books/how-to-photogrammety/viewer/introduction
- https://www.docswell.com/s/lileaLab/KW132X-231004
- https://www.isprs.org/society/history/grimm-the-origin-of-the-term-photogrammetry.pdf
- https://chatgpt.com/c/68d73c2e-a1ec-8330-bebe-bed45b87fa9a
---

## Photogrammetry

A method for extracting geometric properties of objects from photographs—especially recovering 3D data from images.

- Photogrammetry
  - photo (photograph)
  - gram (drawing, record)
  - metry (measurement)

Generating mesh data from photos is often referred to as photogrammetry.

---
references:
- [SfM MVS Technical Foundations](https://chatgpt.com/c/68d9b223-9588-8325-aa86-52a18c028cf0)
- https://chatgpt.com/c/68d9b5e0-4634-8320-b0c6-f90ce14abb75
notes:
- De facto implementations include [COLMAP](https://github.com/colmap/colmap) and [OpenMVS](https://github.com/cdcseacave/openMVS)
---

## SfM / MVS

<p/>

- Techniques for generating point clouds from photos: SfM (Structure from Motion) and MVS (Multi-View Stereo)
- SfM estimates camera poses and sparse point clouds, while MVS produces dense point clouds followed by optional meshing
- The pipeline looks like the diagram below

<a href="https://www.ist.hokudai.ac.jp/labo/dgp/research/sfm_mvs/research_sfm_mvs.html" target="_blank"><img class="h-40 place-self-center" src="/hokudai-dgp-research_sfm_mvs-image001.webp"></a>[^hokudai]

[^hokudai]: [Hokkaido University Digital Geometry Processing Laboratory, "Enhancing the Quality of SfM-MVS."](https://www.ist.hokudai.ac.jp/labo/dgp/research/sfm_mvs/research_sfm_mvs.html.)

---

<a href="https://www.youtube.com/watch?v=XBAkhyJE-k8" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/XBAkhyJE-k8/maxresdefault.jpg"></a>[^OpenMVS]

[^OpenMVS]: [OpenMVS, "Chamois Statue by OpenMVS on Sketchfab"](https://sketchfab.com/models/3aedcdd22c31447199c18dd9aec5d952), demonstrated by the speaker

---
references:
- https://aicam.jp/tech/sfmmvs
- https://www.jstage.jst.go.jp/article/jsprs/60/3/60_95/_pdf/-char/ja
- https://sokugikyo.or.jp/wp-content/uploads/2024/04/119-2.pdf
---

## NeRF (2020–)

<p/>

- Pronounced "nerf"
- Learns radiance and density fields in space with neural networks to achieve high-quality novel view synthesis
- Output is neural network weights (e.g., `.safetensors`) rather than meshes or point clouds

---
layout: two-cols-header
references:
- [3D Gaussian Splatting for Real-Time Radiance Field Rendering](https://notebooklm.google.com/notebook/284128fd-8c71-4970-a0e9-014ded5b6bca)
- [Hugging Face, "Gaussian Splatting"](https://huggingface.co/blog/gaussian-splatting)
- [Overview of 3D Gaussian Splatting](https://note.com/npaka/n/ncd4b84c1e2eb)
- 3D Gaussian Splatting: Survey, Technologies, Challenges, and Opportunities - Yanqi, 2024 ([NotebookLM](https://notebooklm.google.com/notebook/8466d1fb-fbbc-4bbf-a095-63f5188f1e04))
- DROID-SLAM (Zachary, 2022)
- SplaTAM (Keetha, 2023)
- GS-SLAM (Chi, 2024)
---

## Gaussian Splatting (2023–)

Originally a point-cloud representation and rendering technique.

::left::

### Gaussian (ガウシアン)

<p/>

- Gaussian refers to the normal distribution.
- Instead of dense point clouds or meshes, each sparse point stores scale, color, and opacity as a 3D Gaussian distribution

::right::

### Splatting (スプラッティング)

One approach for rendering 3D graphics data into 2D.

- Ray tracing: Shoot rays from the camera into the scene and render the first intersected surface
- Splatting: Project each point onto the screen
- Triangle rasterization: Fill the nearest triangles; suitable for meshes

The reconstructed data is commonly called a “splat.”

---
notes:
- Evidence that the Potree demo renders splats can be found [here](https://www.cg.tuwien.ac.at/research/publications/2016/SCHUETZ-2016-POT/SCHUETZ-2016-POT-thesis.pdf)
---

## Understand Point Splatting Visually

Use simple point splatting (without Gaussians) to grasp the idea. Browse [Potree #Examples](https://github.com/potree/potree#examples).

- Example 1: [Heidentor](https://potree.org/potree/examples/vr_heidentor.html)
- Example 2: [Lion](https://potree.org/potree/examples/vr_lion.html)
- Example 3: [Toolbar](https://potree.org/potree/examples/toolbar.html)

---

<a href="https://www.youtube.com/watch?v=PWtkCRQaahY" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/PWtkCRQaahY/maxresdefault.jpg"></a>[^potree]

[^potree]: [Potree, "Heidentor"](https://potree.org/potree/examples/vr_heidentor.html), demonstrated by the speaker

---
references:
- [What Is High-Fidelity 3D Gaussian Splatting? Differences from Conventional 3D Models | SEKIDO](https://sekido-rc.com/blog/2025/01/16/enterprise_0025/)
---

## How Gaussian Splatting Works

Gaussian Splatting uses the per-point opacity and scale to let each point cover a wide area.

Open the [mkkellogg/GaussianSplats3D](https://github.com/mkkellogg/GaussianSplats3D) demo and press **P** to toggle between 3D Gaussian splatting and point-cloud rendering modes.

---

<a href="https://www.youtube.com/watch?v=88X2gp_Kf_A" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/88X2gp_Kf_A/maxresdefault.jpg"></a>[^markkellogg]

[^markkellogg]: [Mark Kellogg, "3D Gaussian Splatting with Three.js"](https://projects.markkellogg.org/threejs/demo_gaussian_splats_3d.php), demonstrated by the speaker

---
references:
- https://www.docswell.com/s/HoloLab/K9VWRX-holotech24_b2#p7
- https://begin3d.com/sej_rs-ps-3dgs001_index
---

## When to Use Photogrammetry, NeRF, or Gaussian Splatting

<p/>

<div class="text-xs">

|  | Pros | Cons |
| --- | --- | --- |
| Photogrammetry | <ul><li>Faithfully reproduces matte materials</li><li>High geometric accuracy</li></ul> | <ul><li>Struggles with transparent and specular surfaces</li><li>Manual optimization is labor-intensive</li></ul> |
| NeRF | <ul><li>Excels at novel view interpolation and high-frequency textures</li></ul> | <ul><li>Difficult to run in real time or handle transparency</li><li>Post-processing is complex</li></ul> |
| 3D Gaussian Splatting | <ul><li>Handles transparency and reflections well</li><li>Great at representing fine details like foliage</li><li>Strong for real-time rendering</li><li>Pipeline can be highly automated</li></ul> | <ul><li>Weaker for matte materials and unseen viewpoints</li><li>Lower geometric fidelity</li></ul> |

</div>
