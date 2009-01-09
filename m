From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Fri, 9 Jan 2009 12:44:12 +0000
Message-ID: <20090109124412.619330ea@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50327 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbZAIMpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 07:45:09 -0500
In-Reply-To: <200901091334.55823.borntraeger@de.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

On Fri, 9 Jan 2009 13:34:55 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Hello,
> 
> with todays git I lots of these warnings:
> 
> [    1.246807] ata1.00: ATA-7: ST910021AS, 4.06, max UDMA/100
> [    1.253066] ata1.00: 195371568 sectors, multi 16: LBA48
> [    1.262561] ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-U10N, 1.05, max UDMA/33
> [    1.273159] ata1.00: configured for UDMA/100
> [    1.275279] ata2.00: configured for UDMA/33
> [    1.285546] scsi 0:0:0:0: Direct-Access     ATA      ST910021AS       4.06 PQ: 0 ANSI: 5
> [    1.292049] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.298427] sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors: (100 GB/93.1 GiB)
> [    1.299631] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-U10N  1.05 PQ: 0 ANSI: 5
> [    1.311059] sd 0:0:0:0: [sda] Write Protect is off
> [    1.317409] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.317426] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    1.318378] ------------[ cut here ]------------
> [    1.318380] WARNING: at drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x45e/0x750()
> [    1.318381] Hardware name: 64575GG

Can you see if this goes away if you back out all Arjan's async stuff.
Then if not can you back out my 32bit PIO patch and see if that is the
trigger.

Alan
