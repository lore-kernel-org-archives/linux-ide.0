From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ahci: imx: software workaround for phy reset issue in resume
Date: Tue, 15 Apr 2014 00:19:38 -0300
Message-ID: <CAOMZO5D+LOZ0rxJ0mRZfyURzeH_tfhE0jnYgtWnULvxKq5NpuQ@mail.gmail.com>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
	<1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59010 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaDODTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 23:19:39 -0400
Received: by mail-wi0-f181.google.com with SMTP id hm4so4986775wib.8
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2014 20:19:38 -0700 (PDT)
In-Reply-To: <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Richard Zhu <r65037@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 14, 2014 at 11:41 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> When suspending imx6q systems which have rootfs on SATA, the following
> error will likely be seen in resume.  The SATA link will fail to come
> up, and it results in an unusable system across the suspend/resume
> cycle.
>
> $ echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> PM: Entering mem sleep
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Stopping disk
> PM: suspend of devices complete after 61.914 msecs
> PM: suspend devices took 0.070 seconds
> PM: late suspend of devices complete after 4.906 msecs
> PM: noirq suspend of devices complete after 4.521 msecs
> Disabling non-boot CPUs ...
> CPU1: shutdown
> CPU2: shutdown
> CPU3: shutdown
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
> CPU1 is up
> CPU2: Booted secondary processor
> CPU2 is up
> CPU3: Booted secondary processor
> CPU3 is up
> PM: noirq resume of devices complete after 10.486 msecs
> PM: early resume of devices complete after 4.679 msecs
> sd 0:0:0:0: [sda] Starting disk
> PM: resume of devices complete after 22.674 msecs
> PM: resume devices took 0.030 seconds
> PM: Finishing wakeup.
> Restarting tasks ... done.
> $ ata1: SATA link down (SStatus 1 SControl 300)
> ata1: SATA link down (SStatus 1 SControl 300)
> ata1: limiting SATA link speed to 1.5 Gbps
> ata1: SATA link down (SStatus 1 SControl 310)
> ata1.00: disabled
> ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen t4
> ata1: irq_stat 0x00000040, connection status changed
> ata1: SError: { CommWake DevExch }
> ata1: hard resetting link
> sd 0:0:0:0: rejecting I/O to offline device
> sd 0:0:0:0: killing request
> sd 0:0:0:0: rejecting I/O to offline device
> Aborting journal on device sda2-8.
> sd 0:0:0:0: rejecting I/O to offline device
> EXT4-fs warning (device sda2): ext4_end_bio:317: I/O error writing to inode 132577 (offset 0 size 0 starting block 26235)
> Buffer I/O error on device sda2, logical block 10169
> ...
>
> It's caused by a silicon issue that SATA phy does not get reset by
> controller when coming back from LPM.  The patch adds a software
> workaround for this issue.  It enforces a software reset on SATA phy
> in imx_sata_enable() function, so that we can ensure SATA link will
> come up properly in both power-on and resume.
>
> The software reset is implemented by writing phy reset register through
> the phy control register bus interface.  Functions
> imx_phy_reg_[addressing|write|read]() implement this bus interface, while
> imx_sata_phy_reset() performs the actually reset operation.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>


Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

This fixes the warning I reported at:
http://www.spinics.net/lists/arm-kernel/msg318745.html

Thanks,

Fabio Estevam
