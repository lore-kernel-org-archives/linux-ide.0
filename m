Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFF1E866
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973699; cv=none; b=OUaezQ5oI6hC7xpA1BRmqXvD4L05IUzuShhzheuZRjs5ze1TQfeia6yAef6jOHvkn8JZJKvBAgdw9tQO/VSRGDFJ/TT3Wma3TBitIYA2q/LvzgLoJHu99QFzorCmcDJGFwsO2PUSq07Ky0aZI6nO5FHDDsq5x4r/N+Z30E0jyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973699; c=relaxed/simple;
	bh=/+zIFgMuzL/xZ5SY+wKHdbdRlvQGC7ZUcuq3A6VRUPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sofUt0aWugpAZEd9uFUDhEtwcrW3LfO5if/iG4LHQyi72PLoJPxHgcHd5TpuPGhxFQu80iEZ1Nu4KA65QJCeXFQuBmliNC/x/m3U0AkuZu0dSpA96SKLsgvv34ZVsrJm61fGLyL3mCNRWx0zY+0Dq5wqlWoGTlNCf9ihuRExfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkaJnBkA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkaJnBkA"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c132695f1bso2162776b6e.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 10:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708973696; x=1709578496; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hG+1f6LvQ7hEN7T/p2k8W0htrAUmkV9ERY5TEkXgpj8=;
        b=VkaJnBkAtSKDzq3MEv4FCOw5NHIgFO10KigCBRPpLjFaqJoI8x3ZU/QJTQ2NzK8HV5
         DPYpKpf61fSGBDFfg7o5g/K4vunojEgYX44p8NnA1Pve9L0RbfxZ2eQCMhQriSNQnh3O
         9/XH+gW0N4aRcyKcGx7yNB1A//KhNyhSlOlwFYVTuJrP5ehloYTwbAjcLB8R2E29y0Lz
         qHje6bUcTGBzN2OZ+ewjf91xJUDGt33sW0P1yNX+KGNXeSeiCaH1+f9fymAVut4dH4Fs
         vfQ20lCK6ag4K1iOyJ8+fS3Uqnx5I7wBJNNByswZRq7DMAvDXgm4vWCOUGsJsBP2qgrG
         +ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973696; x=1709578496;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG+1f6LvQ7hEN7T/p2k8W0htrAUmkV9ERY5TEkXgpj8=;
        b=uO0YyOCnw51nlxwqRlEBFDbWA1E6iUuKeL6/JiMHgKLjtIL8S9jRUc83N52iT57zH5
         7KyQVMzPWSpv+J0zzdfoPVFv38/4L0TrUUtwZW2rAtaITHl2PBbniYV3yEDBYz4Z+xiD
         WDVSMSihqAcLmUJoDtLfamvNrwije+sFomXBrSFi9q1cgLOTDuFvcsPY4q03TeeW2DFo
         4V/uJOIp7Z2Q2Y6tnhgZWZwKgGY4rN8oGd2WMUc3ulr7alzj+UA45Q0dQUwYglZADxo7
         dDzpX5xhcGxUPdK7iKccG6hL0K3Yh1E0AylzfDMRUSex+uwetYRSm3sqIdqW0RibWGpr
         M2iA==
X-Forwarded-Encrypted: i=1; AJvYcCVq5cGUFDxeN5xZXSj1+ZOOUXgBDab27qrTOtL50G308OIrKuc3CwhackK8tk5uSySQTWzBxI76JgGYwNNyCUBLBfT4EhX2w8Fd
X-Gm-Message-State: AOJu0Yy4u6l79LHb63gmY/gDfOqEi9BVY4pt2nvxzRxUDJ7kznzNjeQ+
	RJXVI1pPB0AgxS6Zd8pAwou9B9KaBDimp6zThL7ojW9WUUUZqu10IAJCA9toj1obZzO2FDfKwY6
	KmZH1cgO08wPtIrW129QcdvvqodM=
X-Google-Smtp-Source: AGHT+IHRODeu4CLUrVqQoOZ+kMxXpF6TMSjYqQ21Iir7nfDvPPBh2BNB7SWa9QecyEM53BwEJporKVKqTjS+CT8eRzY=
X-Received: by 2002:a05:6358:620e:b0:17b:6e2c:524a with SMTP id
 a14-20020a056358620e00b0017b6e2c524amr8845219rwh.27.1708973696109; Mon, 26
 Feb 2024 10:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Date: Mon, 26 Feb 2024 19:54:43 +0100
Message-ID: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>
Subject: ahci module throws "Internal error: synchronous external abort:
 0000000096000210 [#1] SMP"
To: dlemoal@kernel.org, linux-ide@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000017376c06124d72b6"

--00000000000017376c06124d72b6
Content-Type: text/plain; charset="UTF-8"

Hi,

this is my first time reporting a kernel issue, so please forgive any
breaches of custom.

I'm running a FriendlyARM NanoPi M4 with their PCIe SATA addon card:
00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9215 PCIe
2.0 x1 4-port SATA 6 Gb/s Controller (rev 11)

I've been succesfully using kernels up to 6.2.7 without much issues,
enabling only the staging media chip drivers so I can use that
hardware.
Recently I've been wanting to update to version 6.6, but the SATA card
isn't working and I can't access my attached disks.
The last version I tried is 6.6.18 (kernel configuration is attached,
updated from my working 6.2.7 configuration).
I think the relevant part of the dmesg log (retrieved through
journalctl, hence the extra's) is this, starting from where the pci
controller is first mentioned:
---
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: host
bridge /pcie@f8000000 ranges:
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie:
MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie:
IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: no
vpcie12v regulator found
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: no
vpcie3v3 regulator found
apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
end0: renamed from eth0
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: chip id 101
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: features 0x2f
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM4354A2
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM4356A2
(001.003.015) build 0000
apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: PCI
host bridge to bus 0000:00
apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
/lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM4356A2.friendlyarm,nanopi-m4.hcd
failed with error -20
apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource [bus 00-1f]
apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource
[mem 0xfa000000-0xfbdfffff]
apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
/lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM4356A2.hcd failed with
error -20
apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource
[io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
/lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM.friendlyarm,nanopi-m4.hcd
failed with error -20
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: [1d87:0100] type
01 class 0x060400
apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
/lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM.hcd failed with error
-20
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: supports D1
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: PME# supported
from D0 D1 D3hot
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: firmware Patch
file not found, tried:
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM:
'brcm/BCM4356A2.friendlyarm,nanopi-m4.hcd'
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: 'brcm/BCM4356A2.hcd'
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM:
'brcm/BCM.friendlyarm,nanopi-m4.hcd'
apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: bridge
configuration invalid ([bus 00-00]), reconfiguring
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: [1b4b:9215] type
00 class 0x010601
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x10: initial
BAR value 0x00008000 invalid
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x10: [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x14: initial
BAR value 0x00008040 invalid
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x14: [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x18: initial
BAR value 0x00008100 invalid
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x18: [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x1c: initial
BAR value 0x00008140 invalid
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x1c: [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x20: [io
0x800000-0x80001f]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x24: [mem
0x00900000-0x009007ff]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x30: [mem
0xd0000000-0xd000ffff pref]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: Max Payload Size
set to 256 (was 128, max 512)
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: Enabling fixed DMA
alias to 00.1
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: PME# supported from D3hot
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: 2.000 Gb/s
available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at
0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
end0: Register MEM_TYPE_PAGE_POOL RxQ-0
apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:01: busn_res: [bus
01-1f] end is updated to 01
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: BAR 14: assigned
[mem 0xfa000000-0xfa0fffff]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 6: assigned
[mem 0xfa000000-0xfa00ffff pref]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 5: assigned
[mem 0xfa010000-0xfa0107ff]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 4: no space
for [io  size 0x0020]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 4: failed to
assign [io  size 0x0020]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 0: no space
for [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 0: failed to
assign [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 2: no space
for [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 2: failed to
assign [io  size 0x0008]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 1: no space
for [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 1: failed to
assign [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 3: no space
for [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 3: failed to
assign [io  size 0x0004]
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: PCI bridge to [bus 01]
apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0:   bridge window
[mem 0xfa000000-0xfa0fffff]
apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: enabling
device (0000 -> 0002)
apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: PME:
Signaling with IRQ 96
apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: AER: enabled
with IRQ 96
apr 02 08:25:51 arch-htpc kernel: ahci 0000:01:00.0: version 3.0
apr 02 08:25:51 arch-htpc kernel: Internal error: synchronous external
abort: 0000000096000210 [#1] SMP
apr 02 08:25:51 arch-htpc kernel: Modules linked in: realtek
rk808_regulator rtc_rk808 clk_rk808 hci_uart btqca btbcm btintel
snd_soc_simple_card snd_soc_simple_card_utils bluetooth des_generic
snd_soc_rockchip_i2s snd_soc_hdmi_codec rk_crypto libdes dw_wdt
hantro_vpu rockchip_vdec(C) v4l2_vp9 rockchip_iep v4l2_h264
rockchip_rga videobuf2_dma_contig videobuf2_dma_sg v4l2_mem2mem
videobuf2_memops rk8xx_i2c nvmem_rockchip_efuse videobuf2_v4l2
ecdh_generic rk8xx_core videodev ecc dwmac_rk videobuf2_common mc
cfg80211 stmmac_platform stmmac rfkill rockchip_thermal pcs_xpcs
phylink joydev ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT
xt_comment xt_limit xt_addrtype xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables
iptable_filter bpfilter crypto_user fuse loop nfnetlink dw_hdmi_cec
dw_hdmi_i2s_audio gpio_keys panfrost drm_shmem_helper gpu_sched
rockchipdrm drm_dma_helper analogix_dp dw_mipi_dsi dw_hdmi
drm_display_helper drm_kms_helper drm cec rc_core
apr 02 08:25:51 arch-htpc kernel: CPU: 1 PID: 58 Comm: kworker/u12:2
Tainted: G         C         6.6.18-1-rockchip-ARCH #1
apr 02 08:25:51 arch-htpc kernel: Hardware name: FriendlyElec NanoPi M4 (DT)
apr 02 08:25:51 arch-htpc kernel: Workqueue: events_unbound
deferred_probe_work_func
apr 02 08:25:51 arch-htpc kernel: pstate: 30000005 (nzCV daif -PAN
-UAO -TCO -DIT -SSBS BTYPE=--)
apr 02 08:25:51 arch-htpc kernel: pc : ahci_enable_ahci+0x14/0x94
apr 02 08:25:51 arch-htpc kernel: lr : ahci_save_initial_config+0x30/0x448
apr 02 08:25:51 arch-htpc kernel: sp : ffff8000820ab740
apr 02 08:25:51 arch-htpc kernel: x29: ffff8000820ab740 x28:
0000000000000000 x27: ffff800081b52ab8
apr 02 08:25:51 arch-htpc kernel: x26: 0000000000000000 x25:
ffff8000820ab858 x24: ffff0000043f30c0
apr 02 08:25:51 arch-htpc kernel: x23: 0000000000000005 x22:
ffff000004a94880 x21: ffff000004a94880
apr 02 08:25:51 arch-htpc kernel: x20: ffff800082410004 x19:
ffff800082410000 x18: fffffffffffce818
apr 02 08:25:51 arch-htpc kernel: x17: 000000009dc8d4da x16:
0000000000000000 x15: ffff0000007479a0
apr 02 08:25:51 arch-htpc kernel: x14: ffff800080000000 x13:
ffff800082416000 x12: ffff800081734cf8
apr 02 08:25:51 arch-htpc kernel: x11: ffff800081734d20 x10:
ffff800081ab6cf8 x9 : 0000000000000001
apr 02 08:25:51 arch-htpc kernel: x8 : 0101010101010101 x7 :
7f7f7f7f7f7f7f7f x6 : fefeff646c756d5e
apr 02 08:25:51 arch-htpc kernel: x5 : 8080800000000000 x4 :
0000000000000000 x3 : 0000000000000000
apr 02 08:25:51 arch-htpc kernel: x2 : 0000000000000000 x1 :
ffff000004a94880 x0 : ffff800082410000
apr 02 08:25:51 arch-htpc kernel: Call trace:
apr 02 08:25:51 arch-htpc kernel:  ahci_enable_ahci+0x14/0x94
apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
end0: PHY [stmmac-0:01] driver [RTL8211E Gigabit Ethernet] (irq=91)
apr 02 08:25:51 arch-htpc kernel:  ahci_save_initial_config+0x30/0x448
apr 02 08:25:51 arch-htpc kernel:  ahci_init_one+0x2dc/0xc68
apr 02 08:25:51 arch-htpc kernel:  local_pci_probe+0x40/0xa4
apr 02 08:25:51 arch-htpc kernel:  pci_device_probe+0xac/0x1ec
apr 02 08:25:51 arch-htpc kernel:  really_probe+0x184/0x3c8
apr 02 08:25:51 arch-htpc kernel:  __driver_probe_device+0x7c/0x16c
apr 02 08:25:51 arch-htpc kernel:  driver_probe_device+0x3c/0x110
apr 02 08:25:51 arch-htpc kernel:  __device_attach_driver+0xbc/0x158
apr 02 08:25:51 arch-htpc kernel:  bus_for_each_drv+0x84/0xe0
apr 02 08:25:51 arch-htpc kernel:  __device_attach+0x9c/0x1ac
apr 02 08:25:51 arch-htpc kernel:  device_attach+0x14/0x20
apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_device+0x64/0xd4
apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_devices+0x38/0x84
apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_devices+0x64/0x84
apr 02 08:25:51 arch-htpc kernel:  pci_host_probe+0x44/0xbc
apr 02 08:25:51 arch-htpc kernel:  rockchip_pcie_probe+0x3e4/0x54c
apr 02 08:25:51 arch-htpc kernel:  platform_probe+0x68/0xc0
apr 02 08:25:51 arch-htpc kernel:  really_probe+0x184/0x3c8
apr 02 08:25:51 arch-htpc kernel:  __driver_probe_device+0x7c/0x16c
apr 02 08:25:51 arch-htpc kernel:  driver_probe_device+0x3c/0x110
apr 02 08:25:51 arch-htpc kernel:  __device_attach_driver+0xbc/0x158
apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
end0: No Safety Features support found
apr 02 08:25:52 arch-htpc kernel: dwmmc_rockchip fe310000.mmc:
Successfully tuned phase to 189
apr 02 08:25:52 arch-htpc kernel:  bus_for_each_drv+0x84/0xe0
apr 02 08:25:52 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
end0: PTP not supported by HW
apr 02 08:25:52 arch-htpc kernel:  __device_attach+0x9c/0x1ac
apr 02 08:25:52 arch-htpc kernel:  device_initial_probe+0x14/0x20
apr 02 08:25:52 arch-htpc kernel:  bus_probe_device+0xac/0xb0
apr 02 08:25:52 arch-htpc kernel:  deferred_probe_work_func+0xb4/0x108
apr 02 08:25:52 arch-htpc kernel:  process_one_work+0x14c/0x2c8
apr 02 08:25:52 arch-htpc kernel:  worker_thread+0x22c/0x4bc
apr 02 08:25:52 arch-htpc kernel:  kthread+0xd8/0xdc
apr 02 08:25:52 arch-htpc kernel:  ret_from_fork+0x10/0x20
apr 02 08:25:52 arch-htpc kernel: Code: a9bd7bfd 910003fd a90153f3
91001014 (b9400293)
apr 02 08:25:52 arch-htpc kernel: ---[ end trace 0000000000000000 ]---
---
The log on kernel 6.2.7 (where this PCIe SATA card works just fine) is
identical (as far as things like these are identical between kernel
versions) up to the internal error.
This log is 100% reproducible.
I looked through the recent changes to the ahci module in the kernel
tree, but couldn't find anything related to my hardware and the
mentioned functions.
I can provide further details, logs, and output of both kernel
versions if necessary. I'm also capable of compiling the kernel with
any patches you may want to see tested (as long as they don't carry
too much risk of borking my system).

Thanks for any input or help resolving this issue.

Ruben

--00000000000017376c06124d72b6
Content-Type: application/gzip; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_lt3apnxh0>
X-Attachment-Id: f_lt3apnxh0

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
--00000000000017376c06124d72b6--
