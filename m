From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Tue, 25 Sep 2007 04:13:46 -0400
Message-ID: <46F8C33A.3060601@garzik.org>
References: <200709251323031982245@gmail.com>, <46F8B3F8.1050909@garzik.org> <200709251552483357334@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55698 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXIYINv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 04:13:51 -0400
In-Reply-To: <200709251552483357334@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Peer Chen wrote:
> We have three mode for one controller - IDE/RAID/AHCI, we want sata_nv being load when user select the IDE mode in BIOS, load ahci driver if RAID/AHCI being selected, which will verify if our legacy mode work well and have additional option if there is any
> bug for the ahci mode.

I understand that logic, but look at what happens in practice:

1) User installs new OS in AHCI mode.  Distro updates initramfs (loaded 
at kernel boot time, with boot drivers) to include ahci driver.
2) User reboots into BIOS setup, and switches from AHCI mode to IDE mode.
3) BIOS setup reboots computer.
4) OS kernel and initramfs image are loaded.  ahci driver load fails.
5) User is left without a bootable system.

The same situation happens in reverse, if you install in IDE mode 
(sata_nv in initramfs), and then switch to AHCI/RAID mode.

Additionally, AHCI provides better performance and more direct exposure 
to the SATA frames.  This is key for supporting many modern SATA 
features that cannot be accessed via IDE legacy mode.  AHCI lacks 
in-silicon simulation of an IDE interface, which time has shown is a 
less stable, edge-case-prone approach to SATA.

I do not find the "verify nvidia's legacy mode works" argument 
compelling; that is not the kernel's job, nor the user's.  And if there 
is an AHCI silicon bug, let us deal with that when such a bug appears.

Overall, AFAICS this patch -introduces- new ways for the user to easily 
render their systems unbootable.

	Jeff


