Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15A12C55E
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980100; cv=none; b=BH3U9xoJDismJ/T3or9vvLJ9vOin7nYAm+9PmvwBzTZzbjo5rH2CZIE8qDDgN/voZ3+Jk4TqBVf+tlV0yVSXIwkCl8qE02o8I58DTtfF9P7km0qC3wIGrTD7DxBDWCzDaQdF+KzcaxmdsXmbeBjREOgMbbcSzilIUOXu9QVCEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980100; c=relaxed/simple;
	bh=OzRe2yHZs0a74MshSEo9mIf/0rRxFdOV2DrjzW0o/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax8ULmZMKQMKF8ueNyBlRwXUvEhEH3Fle8vjAuf05tgHyKiSIccGgAuKT0WuCrn6MDSjIlBN2PkqtihESg/aS6eRJUMkg7FW4Moy5rqyzbHhfZa/rbur+N3viXcD+A+crXedB+8cNyJGas0sRHz/NGIYG7Qi3OlPF4hMyPW/zAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF0Ayutd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF0Ayutd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D4FC433C7;
	Mon, 26 Feb 2024 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708980100;
	bh=OzRe2yHZs0a74MshSEo9mIf/0rRxFdOV2DrjzW0o/UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IF0Ayutd073NehZrT8+UCJdb02MgqWIhFBxVeOKEtk1HDFPxgnhcHG1EAuzbtJTPN
	 Z7QA6flw2yNvEE8JhHMjJTqCrF103QnRE8da1D8iKHYRIA3++WWBG2Mvat0+bN0RIS
	 1ZAS37CCRbigJzBMUX6zCA0c+DZKqWnol7pwLNcFmrvL5Byh+uh6LdNFgJ67iOtbEy
	 BcZosa4ICsZvS8yLZiD0EleTN8Qzt3JXyScahVj3wpwaP1Ax2apWpjs1QmJFfDw0Z1
	 a1pIigY581kDfJ6Tc66psEXfaA7R1hVC8+AuRWU7LPJCrCCLGTIhKQZiS6fX5CQC/W
	 P3oZvhwyINJFA==
Date: Mon, 26 Feb 2024 21:41:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: ahci module throws "Internal error: synchronous external abort:
 0000000096000210 [#1] SMP"
Message-ID: <Zdz3f4KgAaPKp7m_@fedora>
References: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>

Hello Ruben,

On Mon, Feb 26, 2024 at 07:54:43PM +0100, Ruben Van Boxem wrote:
> Hi,
> 
> this is my first time reporting a kernel issue, so please forgive any
> breaches of custom.
> 
> I'm running a FriendlyARM NanoPi M4 with their PCIe SATA addon card:
> 00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
> 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9215 PCIe
> 2.0 x1 4-port SATA 6 Gb/s Controller (rev 11)
> 
> I've been succesfully using kernels up to 6.2.7 without much issues,
> enabling only the staging media chip drivers so I can use that
> hardware.
> Recently I've been wanting to update to version 6.6, but the SATA card
> isn't working and I can't access my attached disks.
> The last version I tried is 6.6.18 (kernel configuration is attached,
> updated from my working 6.2.7 configuration).
> I think the relevant part of the dmesg log (retrieved through
> journalctl, hence the extra's) is this, starting from where the pci
> controller is first mentioned:
> ---
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: host
> bridge /pcie@f8000000 ranges:
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie:
> MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie:
> IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: no
> vpcie12v regulator found
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: no
> vpcie3v3 regulator found
> apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
> end0: renamed from eth0
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: chip id 101
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: features 0x2f
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM4354A2
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM4356A2
> (001.003.015) build 0000
> apr 02 08:25:51 arch-htpc kernel: rockchip-pcie f8000000.pcie: PCI
> host bridge to bus 0000:00
> apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
> /lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM4356A2.friendlyarm,nanopi-m4.hcd
> failed with error -20
> apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource [bus 00-1f]
> apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource
> [mem 0xfa000000-0xfbdfffff]
> apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
> /lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM4356A2.hcd failed with
> error -20
> apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:00: root bus resource
> [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
> /lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM.friendlyarm,nanopi-m4.hcd
> failed with error -20
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: [1d87:0100] type
> 01 class 0x060400
> apr 02 08:25:51 arch-htpc kernel: bluetooth hci0: loading
> /lib/firmware/6.6.18-1-rockchip-ARCH/brcm/BCM.hcd failed with error
> -20
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: supports D1
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: PME# supported
> from D0 D1 D3hot
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: firmware Patch
> file not found, tried:
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM:
> 'brcm/BCM4356A2.friendlyarm,nanopi-m4.hcd'
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: 'brcm/BCM4356A2.hcd'
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM:
> 'brcm/BCM.friendlyarm,nanopi-m4.hcd'
> apr 02 08:25:51 arch-htpc kernel: Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: bridge
> configuration invalid ([bus 00-00]), reconfiguring
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: [1b4b:9215] type
> 00 class 0x010601
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x10: initial
> BAR value 0x00008000 invalid
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x10: [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x14: initial
> BAR value 0x00008040 invalid
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x14: [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x18: initial
> BAR value 0x00008100 invalid
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x18: [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x1c: initial
> BAR value 0x00008140 invalid
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x1c: [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x20: [io
> 0x800000-0x80001f]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x24: [mem
> 0x00900000-0x009007ff]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: reg 0x30: [mem
> 0xd0000000-0xd000ffff pref]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: Max Payload Size
> set to 256 (was 128, max 512)
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: Enabling fixed DMA
> alias to 00.1
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: PME# supported from D3hot
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: 2.000 Gb/s
> available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at
> 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
> apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
> end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> apr 02 08:25:51 arch-htpc kernel: pci_bus 0000:01: busn_res: [bus
> 01-1f] end is updated to 01
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: BAR 14: assigned
> [mem 0xfa000000-0xfa0fffff]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 6: assigned
> [mem 0xfa000000-0xfa00ffff pref]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 5: assigned
> [mem 0xfa010000-0xfa0107ff]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 4: no space
> for [io  size 0x0020]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 4: failed to
> assign [io  size 0x0020]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 0: no space
> for [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 0: failed to
> assign [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 2: no space
> for [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 2: failed to
> assign [io  size 0x0008]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 1: no space
> for [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 1: failed to
> assign [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 3: no space
> for [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:01:00.0: BAR 3: failed to
> assign [io  size 0x0004]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0: PCI bridge to [bus 01]
> apr 02 08:25:51 arch-htpc kernel: pci 0000:00:00.0:   bridge window
> [mem 0xfa000000-0xfa0fffff]
> apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: enabling
> device (0000 -> 0002)
> apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: PME:
> Signaling with IRQ 96
> apr 02 08:25:51 arch-htpc kernel: pcieport 0000:00:00.0: AER: enabled
> with IRQ 96
> apr 02 08:25:51 arch-htpc kernel: ahci 0000:01:00.0: version 3.0
> apr 02 08:25:51 arch-htpc kernel: Internal error: synchronous external
> abort: 0000000096000210 [#1] SMP
> apr 02 08:25:51 arch-htpc kernel: Modules linked in: realtek
> rk808_regulator rtc_rk808 clk_rk808 hci_uart btqca btbcm btintel
> snd_soc_simple_card snd_soc_simple_card_utils bluetooth des_generic
> snd_soc_rockchip_i2s snd_soc_hdmi_codec rk_crypto libdes dw_wdt
> hantro_vpu rockchip_vdec(C) v4l2_vp9 rockchip_iep v4l2_h264
> rockchip_rga videobuf2_dma_contig videobuf2_dma_sg v4l2_mem2mem
> videobuf2_memops rk8xx_i2c nvmem_rockchip_efuse videobuf2_v4l2
> ecdh_generic rk8xx_core videodev ecc dwmac_rk videobuf2_common mc
> cfg80211 stmmac_platform stmmac rfkill rockchip_thermal pcs_xpcs
> phylink joydev ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT
> xt_comment xt_limit xt_addrtype xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables
> iptable_filter bpfilter crypto_user fuse loop nfnetlink dw_hdmi_cec
> dw_hdmi_i2s_audio gpio_keys panfrost drm_shmem_helper gpu_sched
> rockchipdrm drm_dma_helper analogix_dp dw_mipi_dsi dw_hdmi
> drm_display_helper drm_kms_helper drm cec rc_core
> apr 02 08:25:51 arch-htpc kernel: CPU: 1 PID: 58 Comm: kworker/u12:2
> Tainted: G         C         6.6.18-1-rockchip-ARCH #1
> apr 02 08:25:51 arch-htpc kernel: Hardware name: FriendlyElec NanoPi M4 (DT)
> apr 02 08:25:51 arch-htpc kernel: Workqueue: events_unbound
> deferred_probe_work_func
> apr 02 08:25:51 arch-htpc kernel: pstate: 30000005 (nzCV daif -PAN
> -UAO -TCO -DIT -SSBS BTYPE=--)
> apr 02 08:25:51 arch-htpc kernel: pc : ahci_enable_ahci+0x14/0x94
> apr 02 08:25:51 arch-htpc kernel: lr : ahci_save_initial_config+0x30/0x448
> apr 02 08:25:51 arch-htpc kernel: sp : ffff8000820ab740
> apr 02 08:25:51 arch-htpc kernel: x29: ffff8000820ab740 x28:
> 0000000000000000 x27: ffff800081b52ab8
> apr 02 08:25:51 arch-htpc kernel: x26: 0000000000000000 x25:
> ffff8000820ab858 x24: ffff0000043f30c0
> apr 02 08:25:51 arch-htpc kernel: x23: 0000000000000005 x22:
> ffff000004a94880 x21: ffff000004a94880
> apr 02 08:25:51 arch-htpc kernel: x20: ffff800082410004 x19:
> ffff800082410000 x18: fffffffffffce818
> apr 02 08:25:51 arch-htpc kernel: x17: 000000009dc8d4da x16:
> 0000000000000000 x15: ffff0000007479a0
> apr 02 08:25:51 arch-htpc kernel: x14: ffff800080000000 x13:
> ffff800082416000 x12: ffff800081734cf8
> apr 02 08:25:51 arch-htpc kernel: x11: ffff800081734d20 x10:
> ffff800081ab6cf8 x9 : 0000000000000001
> apr 02 08:25:51 arch-htpc kernel: x8 : 0101010101010101 x7 :
> 7f7f7f7f7f7f7f7f x6 : fefeff646c756d5e
> apr 02 08:25:51 arch-htpc kernel: x5 : 8080800000000000 x4 :
> 0000000000000000 x3 : 0000000000000000
> apr 02 08:25:51 arch-htpc kernel: x2 : 0000000000000000 x1 :
> ffff000004a94880 x0 : ffff800082410000
> apr 02 08:25:51 arch-htpc kernel: Call trace:
> apr 02 08:25:51 arch-htpc kernel:  ahci_enable_ahci+0x14/0x94
> apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
> end0: PHY [stmmac-0:01] driver [RTL8211E Gigabit Ethernet] (irq=91)
> apr 02 08:25:51 arch-htpc kernel:  ahci_save_initial_config+0x30/0x448
> apr 02 08:25:51 arch-htpc kernel:  ahci_init_one+0x2dc/0xc68
> apr 02 08:25:51 arch-htpc kernel:  local_pci_probe+0x40/0xa4
> apr 02 08:25:51 arch-htpc kernel:  pci_device_probe+0xac/0x1ec
> apr 02 08:25:51 arch-htpc kernel:  really_probe+0x184/0x3c8
> apr 02 08:25:51 arch-htpc kernel:  __driver_probe_device+0x7c/0x16c
> apr 02 08:25:51 arch-htpc kernel:  driver_probe_device+0x3c/0x110
> apr 02 08:25:51 arch-htpc kernel:  __device_attach_driver+0xbc/0x158
> apr 02 08:25:51 arch-htpc kernel:  bus_for_each_drv+0x84/0xe0
> apr 02 08:25:51 arch-htpc kernel:  __device_attach+0x9c/0x1ac
> apr 02 08:25:51 arch-htpc kernel:  device_attach+0x14/0x20
> apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_device+0x64/0xd4
> apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_devices+0x38/0x84
> apr 02 08:25:51 arch-htpc kernel:  pci_bus_add_devices+0x64/0x84
> apr 02 08:25:51 arch-htpc kernel:  pci_host_probe+0x44/0xbc
> apr 02 08:25:51 arch-htpc kernel:  rockchip_pcie_probe+0x3e4/0x54c
> apr 02 08:25:51 arch-htpc kernel:  platform_probe+0x68/0xc0
> apr 02 08:25:51 arch-htpc kernel:  really_probe+0x184/0x3c8
> apr 02 08:25:51 arch-htpc kernel:  __driver_probe_device+0x7c/0x16c
> apr 02 08:25:51 arch-htpc kernel:  driver_probe_device+0x3c/0x110
> apr 02 08:25:51 arch-htpc kernel:  __device_attach_driver+0xbc/0x158
> apr 02 08:25:51 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
> end0: No Safety Features support found
> apr 02 08:25:52 arch-htpc kernel: dwmmc_rockchip fe310000.mmc:
> Successfully tuned phase to 189
> apr 02 08:25:52 arch-htpc kernel:  bus_for_each_drv+0x84/0xe0
> apr 02 08:25:52 arch-htpc kernel: rk_gmac-dwmac fe300000.ethernet
> end0: PTP not supported by HW
> apr 02 08:25:52 arch-htpc kernel:  __device_attach+0x9c/0x1ac
> apr 02 08:25:52 arch-htpc kernel:  device_initial_probe+0x14/0x20
> apr 02 08:25:52 arch-htpc kernel:  bus_probe_device+0xac/0xb0
> apr 02 08:25:52 arch-htpc kernel:  deferred_probe_work_func+0xb4/0x108
> apr 02 08:25:52 arch-htpc kernel:  process_one_work+0x14c/0x2c8
> apr 02 08:25:52 arch-htpc kernel:  worker_thread+0x22c/0x4bc
> apr 02 08:25:52 arch-htpc kernel:  kthread+0xd8/0xdc
> apr 02 08:25:52 arch-htpc kernel:  ret_from_fork+0x10/0x20
> apr 02 08:25:52 arch-htpc kernel: Code: a9bd7bfd 910003fd a90153f3
> 91001014 (b9400293)
> apr 02 08:25:52 arch-htpc kernel: ---[ end trace 0000000000000000 ]---
> ---
> The log on kernel 6.2.7 (where this PCIe SATA card works just fine) is
> identical (as far as things like these are identical between kernel
> versions) up to the internal error.
> This log is 100% reproducible.
> I looked through the recent changes to the ahci module in the kernel
> tree, but couldn't find anything related to my hardware and the
> mentioned functions.
> I can provide further details, logs, and output of both kernel
> versions if necessary. I'm also capable of compiling the kernel with
> any patches you may want to see tested (as long as they don't carry
> too much risk of borking my system).
> 
> Thanks for any input or help resolving this issue.

I would recommend you to test with the latest kernel, v6.8-rc6.

I don't know which device tree you are using, but very often custom
add on cards/HATs require specific device tree overlays to enable
certain regulators etc.

I suspect that this is something not related to AHCI, but rather
some regulator or similar that is not enabled.

How does your kernel command line look on both kernels?

Perhaps try to supply:
" clk_ignore_unused pd_ignore_unused regulator_ignore_unused"
on the kernel command line.

(regulator_ignore_unused requires v6.8-rc1 or newer.)


Kind regards,
Niklas
