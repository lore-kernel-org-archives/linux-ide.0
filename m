From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 11:49:16 -0500
Message-ID: <4B58858C.5080502@garzik.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34516 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab0AUQtT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 11:49:19 -0500
Received: by yxe17 with SMTP id 17so163655yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2010 08:49:18 -0800 (PST)
In-Reply-To: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

On 01/21/2010 10:57 AM, Paul Check wrote:
> I am having an intermittent problem:
>
> ata1.01: SATA link down (SStatus 0 SControl 301)
>
> which is causing one of my four hard drives to not get recognized.
>
> This happens on ata1.01, ata2.00 or ata2.01, although it seems to happen
> more on the 01 channels, I believe.  My motherboard is an ASUS P6T Deluxe
> V2, with the Marvel 88SE61XX ATA controller.
>
> I am running the 2.6.31 kernel.  A variety of ATA controllers are enabled
> in my kernel (as per default?) including AHCI SATA Support (SATA_AHCI),
> Marvell SATA Support (SATA_MV), Generic ATA Support (ATA_Generic), and
> Marvell PATA Support via Legacy Mode (PATA_MARVELL), among others.
>
> I see that the pata, generic and ahci are getting loaded (from lsmod):
>
> libata                189532  4 pata_marvell,ata_generic,ahci,ata_piix
>
> I am not using hardware RAID (although do have software RAID 1 running).
>
> The BIOS for the board has been updated to the latest version.  The disks
> are Seagate ST31000528AS 1 TB drives (4 of them, 2 sets of RAID 1).  I
> also have a Sony BWU-300S plugged in.
>
> Would deselecting the pata_marvell likely get rid of this problem? The
> descriptor says:

Link-down means the hardware is reporting that the link between host and 
drive disconnected.  Removing unused or PATA drivers will probably not 
have any effect.

Check your SATA cables and/or power supply.

	Jeff




