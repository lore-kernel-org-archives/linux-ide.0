Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41013BADF;
	Tue, 13 Aug 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542903; cv=none; b=mMjqk654Rsz01xDINZDIwfwN02daEfgdPzCq2hCLygFXW9A6+HEeCbkCj8m0JL4mSaRjiCRGqGUHL3K+3NT7fVXLXZ0XRGuYyL3VxQSdYnvWH9vLp03UX05FQUq8osYocTcHZpYep13ds/lXhFDZ8FMC6OwzSMP77qWBV6VkjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542903; c=relaxed/simple;
	bh=7l+R8PBekC49cLcJ8mv50KReFwkjpS74fcamZc8jzK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUZ0CqACm4UXiNgjkYF1487d8BIP1qPrz/wjTlr+OrdqnQoJRRHWMSF5uf7JlF4HI5tVU16H2NAvsrnStAvYXFHxldYHDCFf8cgbb+KAPznO7NYfFn4H5GS/624Zy53qnN6/F3e14jHwG7FRm761L6P81lOBxtODp+dl7UdsV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGK5rbHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGK5rbHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79807C4AF0B;
	Tue, 13 Aug 2024 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542902;
	bh=7l+R8PBekC49cLcJ8mv50KReFwkjpS74fcamZc8jzK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGK5rbHy+ktIKjf/5j3XaFRQTcCZbK+rJk2FnI+PU2nwVV/q87yDVjy0sNlATRczA
	 qpKJOybwr1q1oWNkDvHnlSX2K6+O0sZgtkkLje2QPwRAWikVTFBj8iRwsHAl88BUlo
	 suJ05F9annyPGljCL2ul0nYXzwqRG6/XvsYgA0pmr+ys3s+lIhorsUJ3II76xDmxgE
	 zL/u5g+RYqCE7/b7TzBpf8XSVAwRio+TD8nJNLQk2wpySjfVMwGYzB09hm8ftIpuOv
	 5DXw0rm5za11TSjzEOiY5cK2Xxgil6XgaIcJWBUtWxo2fspNhxzKWeP2o8C4SMbd5T
	 6b7VNLtr2nE9g==
Date: Tue, 13 Aug 2024 11:54:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?utf-8?B?S29sYmrDuHJu?= Barmen <linux-ppc@kolla.no>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	=?utf-8?B?Sm9uw6HFoQ==?= Vidra <vidra@ufal.mff.cuni.cz>,
	Christoph Hellwig <hch@lst.de>, linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
Message-ID: <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no>
 <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz>

Hello Jonáš, Kolbjørn,

thank you for the report.

On Tue, Aug 13, 2024 at 07:49:34AM +0200, Jonáš Vidra wrote:
> On Tue 13. Aug 2024 0:32:37 CEST, Kolbjørn Barmen wrote:
> > Ever since 6.10, my macmini G4 behaved unstable when dealing with lots of
> > I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
> > source tarball, building large software packages (or kernel) etc.
> > 
> > After a bit of testing, and patient kernel rebuilding (while crashing) I
> > found the cuplit to be this commit/change
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=09fe2bfa6b83f865126ce3964744863f69a4a030
> 
> I've been able to reproduce this pata_macio bug on a desktop PowerMac G4
> with the 6.10.3 kernel version. Reverting the linked change
> ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K") makes
> the errors go away.

Michael, as the author of the this commit, could you please look into
this issue?

We could revert your patch, which appears to work for some users,
but that would again break setups with PAGE_SIZE == 64K.
(I assume that Jonáš and Kolbjørn are not building with PAGE_SIZE == 64K.)



> 
> ------------[ cut here ]------------
> kernel BUG at drivers/ata/pata_macio.c:544!

https://github.com/torvalds/linux/blob/v6.11-rc3/drivers/ata/pata_macio.c#L544

It seems that the
while (sg_len) loop does not play nice with the new .max_segment_size.


> Oops: Exception in kernel mode, sig: 5 [#1]
> BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 DEBUG_PAGEALLOC PowerMac
> Modules linked in: ipv6 binfmt_misc b43 mac80211 radeon libarc4 cfg80211
> snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa rfkill snd_aoa_i2sbus hwmon
> drm_suballoc_helper snd_aoa_soundbus i2c_algo_bit snd_pcm backlight
> drm_ttm_helper ttm xhci_pci pmac_zilog therm_windtunnel xhci_hcd
> drm_display_helper firewire_ohci snd_timer snd firewire_core serial_base ssb
> soundcore crc_itu_t
> CPU: 1 PID: 1870 Comm: kworker/u10:4 Tainted: G                T
> 6.10.3-gentoo #1
> Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> Workqueue: btrfs-worker btrfs_work_helper
> NIP:  c0719670 LR: c0719678 CTR: 00000001
> REGS: f2db9bf0 TRAP: 0700   Tainted: G                T   (6.10.3-gentoo)
> MSR:  00021032 <ME,IR,DR,RI>  CR: 44008408  XER: 20000000
> 
> GPR00: c06fc28c f2db9cb0 c10d8020 c12d28cc 00000000 00000000 00000000
> c109cff4 GPR08: 69fd0000 00000100 00010000 00000000 00000000 00000000
> c007801c c40c1980 GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000100 00000122 c11377c8 GPR24: 000000ff 00000008 0000ff00 00000000
> c14200a8 00000101 00000000 c109d000 NIP [c0719670]
> pata_macio_qc_prep+0xf4/0x190
> LR [c0719678] pata_macio_qc_prep+0xfc/0x190
> Call Trace:
> [f2db9cb0] [c1421660] 0xc1421660 (unreliable)
> [f2db9ce0] [c06fc28c] ata_qc_issue+0x14c/0x2d4
> [f2db9d00] [c0707c5c] __ata_scsi_queuecmd+0x200/0x53c
> [f2db9d20] [c0707fe8] ata_scsi_queuecmd+0x50/0xe0
> [f2db9d40] [c06e2644] scsi_queue_rq+0x788/0xb1c
> [f2db9d80] [c0492464] __blk_mq_issue_directly+0x58/0xf4
> [f2db9db0] [c0497828] blk_mq_plug_issue_direct+0x8c/0x1b4
> [f2db9de0] [c0498074] blk_mq_flush_plug_list.part.0+0x584/0x5e0
> [f2db9e30] [c0485a40] __blk_flush_plug+0xf8/0x194
> [f2db9e70] [c0485f88] __submit_bio+0x1b8/0x2e0
> [f2db9ec0] [c04862e0] submit_bio_noacct_nocheck+0x230/0x304
> [f2db9f00] [c03aaf30] btrfs_work_helper+0x200/0x338
> [f2db9f40] [c006cae0] process_one_work+0x1a8/0x338
> [f2db9f70] [c006d79c] worker_thread+0x364/0x4c0
> [f2db9fc0] [c007811c] kthread+0x100/0x104
> [f2db9ff0] [c001b304] start_kernel_thread+0x10/0x14
> Code: 38ff0004 b37f0002 7d20ff2c 3bff0010 7d003d2c 7d084a14 93dffff8
> b3dffffe b3dffffc 41820010 3bbd0001 4200ffc0 <0fe00000> 4bdcbb01 813c0044
> 3b180001 ---[ end trace 0000000000000000 ]---
> 
> note: kworker/u10:4[1870] exited with irqs disabled
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1870 at kernel/exit.c:825 do_exit+0x854/0x9ec
> Modules linked in: ipv6 binfmt_misc b43 mac80211 radeon libarc4 cfg80211
> snd_aoa_codec_tas snd_aoa_fabric_layout snd_aoa rfkill snd_aoa_i2sbus hwmon
> drm_suballoc_helper snd_aoa_soundbus i2c_algo_bit snd_pcm backlight
> drm_ttm_helper ttm xhci_pci pmac_zilog therm_windtunnel xhci_hcd
> drm_display_helper firewire_ohci snd_timer snd firewire_core serial_base ssb
> soundcore crc_itu_t
> CPU: 1 PID: 1870 Comm: kworker/u10:4 Tainted: G      D         T
> 6.10.3-gentoo #1
> Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
> Workqueue: btrfs-worker btrfs_work_helper
> NIP:  c004f09c LR: c004e8a4 CTR: 00000000
> REGS: f2db9a80 TRAP: 0700   Tainted: G      D         T   (6.10.3-gentoo)
> MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 88db92e2  XER: 00000000
> 
> GPR00: c004f2c4 f2db9b40 c10d8020 00000000 00002710 00000000 00000000
> 00000000 GPR08: 00000000 f2db9e88 00000004 00000000 28db92e2 00000000
> c007801c c40c1980 GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000100 00000122 c11377c8 GPR24: 000000ff c0db0000 00001032 c0a21000
> c138d520 00000005 c10d8020 c1447220 NIP [c004f09c] do_exit+0x854/0x9ec
> LR [c004e8a4] do_exit+0x5c/0x9ec
> Call Trace:
> [f2db9b40] [c00b0c38] _printk+0x78/0xc4 (unreliable)
> [f2db9b90] [c004f2c4] make_task_dead+0x90/0x174
> [f2db9bb0] [c0010b9c] die+0x324/0x32c
> [f2db9be0] [c0004828] ProgramCheck_virt+0x108/0x158
> --- interrupt: 700 at pata_macio_qc_prep+0xf4/0x190
> NIP:  c0719670 LR: c0719678 CTR: 00000001
> REGS: f2db9bf0 TRAP: 0700   Tainted: G      D         T   (6.10.3-gentoo)
> MSR:  00021032 <ME,IR,DR,RI>  CR: 44008408  XER: 20000000
> 
> GPR00: c06fc28c f2db9cb0 c10d8020 c12d28cc 00000000 00000000 00000000
> c109cff4 GPR08: 69fd0000 00000100 00010000 00000000 00000000 00000000
> c007801c c40c1980 GPR16: 00000000 00000000 00000000 00000000 00000000
> 00000100 00000122 c11377c8 GPR24: 000000ff 00000008 0000ff00 00000000
> c14200a8 00000101 00000000 c109d000 NIP [c0719670]
> pata_macio_qc_prep+0xf4/0x190
> LR [c0719678] pata_macio_qc_prep+0xfc/0x190
> --- interrupt: 700
> [f2db9cb0] [c1421660] 0xc1421660 (unreliable)
> [f2db9ce0] [c06fc28c] ata_qc_issue+0x14c/0x2d4
> [f2db9d00] [c0707c5c] __ata_scsi_queuecmd+0x200/0x53c
> [f2db9d20] [c0707fe8] ata_scsi_queuecmd+0x50/0xe0
> [f2db9d40] [c06e2644] scsi_queue_rq+0x788/0xb1c
> [f2db9d80] [c0492464] __blk_mq_issue_directly+0x58/0xf4
> [f2db9db0] [c0497828] blk_mq_plug_issue_direct+0x8c/0x1b4
> [f2db9de0] [c0498074] blk_mq_flush_plug_list.part.0+0x584/0x5e0
> [f2db9e30] [c0485a40] __blk_flush_plug+0xf8/0x194
> [f2db9e70] [c0485f88] __submit_bio+0x1b8/0x2e0
> [f2db9ec0] [c04862e0] submit_bio_noacct_nocheck+0x230/0x304
> [f2db9f00] [c03aaf30] btrfs_work_helper+0x200/0x338
> [f2db9f40] [c006cae0] process_one_work+0x1a8/0x338
> [f2db9f70] [c006d79c] worker_thread+0x364/0x4c0
> [f2db9fc0] [c007811c] kthread+0x100/0x104
> [f2db9ff0] [c001b304] start_kernel_thread+0x10/0x14
> Code: 915e02fc 81410014 912a0004 915e03c0 939e03c4 91210014 813e04cc
> 4bfffcec 807e0370 38800000 4bffe195 4bfffc9c <0fe00000> 4bfff848 0fe00000
> 4bfff7ec ---[ end trace 0000000000000000 ]---
> 
