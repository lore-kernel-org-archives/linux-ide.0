From: Sven Mueller <debian@incase.de>
Subject: Re: ata_piix installation/device detection problems on Dell server
Date: Tue, 05 Apr 2005 02:15:49 +0200
Message-ID: <4251D8B5.4090107@incase.de>
References: <425188F0.60805@incase.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.ciphirelabs.net ([217.72.114.64]:44226 "EHLO
	mx1.ciphirelabs.net") by vger.kernel.org with ESMTP id S261464AbVDEAPy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Apr 2005 20:15:54 -0400
In-Reply-To: <425188F0.60805@incase.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Debian-Boot <debian-boot@lists.debian.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi.

> The problem I experienced is as follows:
> 
> the ata_piix driver detects PATA and SATA in combined mode (which does 
> seem correct as far as I can tell). However, only the HD is 
> detected/registered in the kernel while the CD-ROM remains 
> undetected/unregistered.
 >
> I was able to work around this issue by _not_ loading the ata_piix 
> module at first, but load the generic ide driver module instead. Of 
> course, that module doesn't detect the SATA part, so I would be able to 
> access the CD-ROM but not the HD. However, loading ata_piix _after_ the 
> generic IDE driver notes that the first port is busy (PATA, used by 
> ide_generic) and only initializes the SATA part. This makes it possible 
> to access both SATA (HD) and PATA (CD).

I just found out that libata by default doesn't support PATA devices. 
This can be changed in include/linux/libata.h (or so) at compile time of 
the kernel by defining ATA_ENABLE_PATA (it's #undef'ed there by default).
Since ata_piix blocks the PATA part of the chip(set), it would be good 
if either that default is changed to enable PATA in libata drivers or 
that ata_piix doesn't touch the PATA part when ATA_ENABLE_PATA isn't 
defined (or, preferably, both).

Regarding debian-installer, I guess there are currently three ways to 
solve this:
1) Re-compile the kernel with ATA_ENABLE_PATA defined (which is
    currently only used in ata_piix.c anyway, so it shouldn't have
    ill side effects)
2) Document the problem and provide a description of the possible
    workaround.
3) Implement the workaround in debian-installer. (Loading the generic
    IDE driver (ide_generic?) before ata_piix)

I would prefer to see (1), but I assume this will not happen pre-Sarge.

PS: I created a bug report for debian-installer (#303135).

> If anyone wants access to the machine in question, I guess I could 
> arrange both root and serial console access to it for a limited time. 
> Will have to check with my boss though. Tell me if you would need that.

The offer still stands.

Regards,
Sven

> PS: Please Cc me in answers unless you also send a copy to the 
> debian-boot mailinglist (which I read).

