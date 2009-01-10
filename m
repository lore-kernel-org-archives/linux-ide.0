From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 15:29:42 +0000
Message-ID: <20090110152942.11375c6c@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<200901101009.13699.borntraeger@de.ibm.com>
	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>
	<200901101242.05203.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<1231598170.3642.12.camel@localhost.localdomain>
	<20090110151248.063199d2@lxorguk.ukuu.org.uk>
	<1231600972.3642.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48266 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751975AbZAJPbo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 10:31:44 -0500
In-Reply-To: <1231600972.3642.22.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

> > Nope.. you can't do that with ATA block transfers - it isn't the same as
> > SCSI
> 
> Well, in that case you'll have to do byte PIO for all ATAPI devices,
> because this is an expected device to host transfer length.

Not possible there is no such thing as byte PIO in ATAPI.

See my other mail - it appears to be a long standing bug in
__atapi_pio_sector rather than a corrupt sg list as I first thought.
