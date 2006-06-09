From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 09 Jun 2006 18:22:14 +0100
Message-ID: <1149873734.22124.40.camel@localhost.localdomain>
References: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21128 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751453AbWFIRG1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 13:06:27 -0400
In-Reply-To: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org

>  Gujin is assuming that your hard disk are accessible by the documented ATA ide
>  system, and some (or all?) IDE SATA interface have (volumtary?) broken
>  implementation: they are not IDE register compatible.

SFF was never a formal standard, and ST-506 was a random vendor
interface copying exercise that caught on. ACPI permits the firmware to
provide ATA taskfiles but afaik not the boot loader unfortunately.

A lot of newer SATA hardware uses a common standard defined interface
called AHCI, and it appears most vendors are migrating in the direction
of using AHCI. If so then we are in the same kind of flux as the VLB
world before SFF and PCI settled the standard interfaces down for a
while.

Don't see how your HPA code protects versus password locking however. If
I hack the OS I write a new boot block which locks the disk then reboot
into it. By the time you go for your floppy its too late.

If thats not the case I'm most interested how you set it up to avoid
this.

Alan
