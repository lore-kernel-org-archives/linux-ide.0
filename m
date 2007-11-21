From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] libata fixes
Date: Tue, 20 Nov 2007 21:26:05 -0500
Message-ID: <4743973D.4090604@pobox.com>
References: <474112B8.6050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56130 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbXKUC0M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 21:26:12 -0500
In-Reply-To: <474112B8.6050505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> These are upstream patches I collected while Jeff is away.  Thanks.
> 
> * workaround for ATAPI tape drives
> * detection/suspend workarounds for several laptops
> * ICH8/9 port_enable fix
> 
> ata_piix controller ID reorganization is included to ease the fixes.
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/ata_piix.c    |   87 ++++++++++++++++++++++++++++------------
>  drivers/ata/libata-core.c |  100 +++++++---------------------------------------
>  drivers/ata/libata-eh.c   |   95 -------------------------------------------
>  drivers/ata/libata-scsi.c |    3 -
>  drivers/ata/pata_sis.c    |    1 
>  include/linux/libata.h    |    5 --
>  6 files changed, 81 insertions(+), 210 deletions(-)
> 
> Adrian Bunk (1):
>       libata: remove unused functions
> 
> Albert Lee (2):
>       libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
>       libata: use ATA_HORKAGE_STUCK_ERR for ATAPI tape drives
> 
> Gabriel C (1):
>       pata_sis.c: Add Packard Bell EasyNote K5305 to laptops
> 
> Mark Lord (1):
>       libata-scsi: be tolerant of 12-byte ATAPI commands in 16-byte CDBs
> 
> Tejun Heo (3):
>       ata_piix: add SATELLITE U205 to broken suspend list
>       ata_piix: reorganize controller IDs
>       ata_piix: port enable for the first SATA controller of ICH8 is 0xf not 0x3
> 
> Thomas Rohwer (1):
>       ata_piix: only enable the first port on apple macbook pro

Just to make sure, I pulled this into #upstream-fixes.  If Linus already 
picked it up, great.  Otherwise I'll make sure it goes upstream.

	Jeff



