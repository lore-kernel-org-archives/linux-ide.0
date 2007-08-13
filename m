From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: sata drive loosing connection/resetting port
Date: Mon, 13 Aug 2007 22:11:29 +0200
Message-ID: <6bffcb0e0708131311k51238bb0l63eeb2fce53e3481@mail.gmail.com>
References: <20070813220241.3f4b8df5@workstation64.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:34202 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbXHMULa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 16:11:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1950484wah
        for <linux-ide@vger.kernel.org>; Mon, 13 Aug 2007 13:11:29 -0700 (PDT)
In-Reply-To: <20070813220241.3f4b8df5@workstation64.home>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Radke <a.radke@arcor.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi Andreas,

[Adding Jeff and linux-ide to CC]

On 13/08/07, Andreas Radke <a.radke@arcor.de> wrote:
> running ArchLinux kernel 2.6.22.2 on a Abit IP35 Pro motherboard with
> Pro Intel P35 chipset (ICH9R + Jmicron) i have these entries all few
> minutes:
>
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x400101 action 0x2 frozen
> ata1.00: (irq_stat 0x08000000, interface fatal error)
> ata1.00: cmd ca/00:f8:18:d2:27/00:00:00:00:00/e6 tag 0 cdb 0x0 data
> 126976 out res 50/00:00:80:2b:3d/00:00:00:00:00/e0 Emask 0x10 (ATA bus
> error) ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> sd 0:0:0:0: [sda] 145226112 512-byte hardware sectors (74356 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>
>
> hard disc is a Western Digital 10k Raptor connected to the ICH9R. on
> the second port of the southbridge is another Samsung hard disc drive
> connected without errors. both controllers are running ahci mode.
>
> lsmod:
> sr_mod                 16548  0
> cdrom                  38312  1 sr_mod
> sd_mod                 25088  6
> pata_jmicron            5888  0
> ahci                   22404  4
> libata                119440  2 pata_jmicron,ahci
>
> i've tried changing the SATA cables and also the power wire to the
> disc without success. i checked the disc successfully with Hitachi
> drive fitness test. it has worked without any trouble so far in a Intel
> P965 ICH8 based mainboard.
>
> any idea how to find the reason?
>
> Andreas Radke
> ArchLinux developer/maintainer

Please try to CC to the appropriate maintainer(s).

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
