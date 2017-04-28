From: Tejun Heo <tj@kernel.org>
Subject: Re: PROBLEM: sil24: transfer errors causing data corruption or very
 low performance
Date: Fri, 28 Apr 2017 17:36:17 -0400
Message-ID: <20170428213617.GF22354@htj.duckdns.org>
References: <1605874.IPVSbxyx3P@c21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35635 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939025AbdD1VgT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Apr 2017 17:36:19 -0400
Received: by mail-yw0-f169.google.com with SMTP id u70so37054897ywe.2
        for <linux-ide@vger.kernel.org>; Fri, 28 Apr 2017 14:36:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1605874.IPVSbxyx3P@c21>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mtths@nurfuerspam.de
Cc: linux-ide@vger.kernel.org

Hello,

On Sat, Apr 22, 2017 at 05:33:56PM +0200, mtths@nurfuerspam.de wrote:
> A SATA PCI-controller card using the kernel module sata_sil24 has problems 
> transferring big files.
> 
> 
> First of all a description of the situation:
> 
> -- Hardware:
> - mainboard Gigabyte GA-MA69GM-S2H; chipset AMD 690G / SB600; 2 PCI slots
>   (32 bit); 1 PCIe 4x slot; 1 PCIe 16 x slot; 8 GiB RAM; AMD Phenom(tm) II X4
>   955 Processor
> - SATA controller card Dawicontrol DC-3410 RAID, 32 bit PCI; chipset
>   SiI3124ACBHU; BIOS message: running at 32 bit / 33 MHz
> - with hard disks: HDS721616PLA380 (twice), ST3000DM001-9YN166 (temporary)
> - q.v. attachment lspci; (dmidecode (v 3.0) finds no SMBIOS nor DMI entry
>   point)
...
> 1st test setting:
> Reading from the disks to /dev/null with
> 		dd if=/dev/sde of=/dev/null bs=4k count=2304k
> one after the other. (Disk ST3000DM001 was temporarily directly connected to 
> the card's external SATA port.)
> Result: After some MB, but before 470 MiB errors occurred:
> 	failed command: READ FPDMA QUEUED
> 		[cf. attachment dmesg]
> 	failed command: READ DMA
> 		[cf. attachment dmesg_tmpHD]
> The errors were reproducible - however, they started after different amounts 
> of data.
> 
> 2nd test setting:
> Using Debian's kernel and patching the driver to not use 64 bit DMA [cf. 
> attachment sata_sil24.c.diff].
> Doing the same tests as above.
> Result: Repeatedly no errors occurred.
> 
> 
> N.B.: 1) There is a Windows Vista (32 bit) installation that uses two of the 
> ports of the controller card as a fake RAID 1: There are no problems with the 
> internal directly connected drives nor with an external drive.
> 2) Prior to this controller card there was a PCI Express card using SiI 3132, 
> that - if I remember rightly - also had such problems, but they started after 
> a greater amount of data. (At that time a Windows XP x64 installation had no 
> problems, too.)

That's interesting, so you're seeing similar host bus errors whether
the controller is attached to PCI or PCIe.

The controller itself is known to be okay with 64bit addressing and
restricting it to 32bit addressing means that you'd be bouncing pages
(DMA to low pages and then copy using CPU), which slows down things a
bit.  It could be that the slowing down in timing is what's helping,
not necessarily forcing 32bit DMA.

I don't know.  Host bus errors are rarely reported and the controller
is definitely known to be okay with 64bit DMAs.  Given this didn't get
reported at all in the haydays of SB600, it could actually be faulty
hardware.

I'm not sure what we can do at the moment.

Thanks.

-- 
tejun
