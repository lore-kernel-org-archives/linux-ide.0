From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 15:12:48 +0000
Message-ID: <20090110151248.063199d2@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<200901101009.13699.borntraeger@de.ibm.com>
	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>
	<200901101242.05203.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<1231598170.3642.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40548 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbZAJPNZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 10:13:25 -0500
In-Reply-To: <1231598170.3642.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

O> Your problem is that the *device* is wanting to transfer a set of bytes
> not divisible by four.  If you want to use word based PIO, you'll have
> to fall back to collecting bytes for the last two.  Alternatively, you

Nope.. you can't do that with ATA block transfers - it isn't the same as
SCSI

> could just do byte PIO for all reply lengths like this ... they occur
> all over the SCSI standard, but not usually in critical paths.

The problem we have is that the sg list the drivers were given had a
segment which was not divisible in length by four and was *NOT* the last
segment in the sg list

The logic in the ATA PIO code is basically


	for each sg entry

		compute the number of bytes to transfer staying within
the page
		transfer that many bytes (but may be more)

		if and only if the transfer is NOT the last segment but is
			more than the bytes requested - WARN


The block alignment is set to 4 bytes so the block code should be handing
down stuff which is safe. Some of the sense and other stuff is "adjusted"
by the libata-scsi conversion code which at this point I suspect is the
offender.

This is why libata uses the pad buffers we don't get to be quite so exact
about transfer sizes as SCSI is.

Alan
