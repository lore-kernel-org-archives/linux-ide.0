From: Nicholas Miell <nmiell@comcast.net>
Subject: Re: SATA timeouts with Seagate disk on VIA VT6420 controller
Date: Thu, 23 Feb 2006 00:56:15 -0800
Message-ID: <1140684975.9471.3.camel@entropy>
References: <1140068654.3274.12.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:56482 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750753AbWBWI4R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Feb 2006 03:56:17 -0500
In-Reply-To: <1140068654.3274.12.camel@entropy>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, 2006-02-15 at 21:44 -0800, Nicholas Miell wrote:
> >From time to time, I've been experiencing timeouts with my SATA disk (a
> Seagate ST3300831AS) attached to a VIA VT6420 controller on a VIA
> K8T800-based MSI motherboard. This has happened somewhat rarely on a
> variety of Fedora kernel versions.
> 
> Basically, sometimes IO will get really slow and I'll start getting
> "ata1: command 0x35 timeout, stat 0x50 host_stat 0x4" in my logs, with
> the occasional "ata1: command 0x25 timeout, stat 0x50 host_stat 0x4" and
> "ata1: command 0xb0 timeout, stat 0x50 host_stat 0x0" thrown in for good
> measure.
> 
> The disk (and/or controller) isn't unresponsive -- I can do a smartctl
> -a -d ata /dev/sda and it'll complete (eventually), and IO to the disk
> continues (very slowly), but it's generally unusable until the next
> reboot.

I actually managed to successfully unmount the filesystem and deactivate
the LVM volume group for once, which allowed me to remove and reload
sata_via, libata, sd_mod and scsi_mod.

After the drivers were reloaded, IO to the disk worked fine, which leads
me to think that sata_via and/or libata needs the ability to reset the
hardware when errors occur.

-- 
Nicholas Miell <nmiell@comcast.net>

