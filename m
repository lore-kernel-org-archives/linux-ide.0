From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 15:32:00 +0000
Message-ID: <20090110153200.51d76a0c@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<200901101009.13699.borntraeger@de.ibm.com>
	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>
	<200901101242.05203.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<1231598170.3642.12.camel@localhost.localdomain>
	<20090110151248.063199d2@lxorguk.ukuu.org.uk>
	<4968BECE.8070304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751997AbZAJPdy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 10:33:54 -0500
In-Reply-To: <4968BECE.8070304@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

>     The ATAPI logic is more complex since it has to take into account the 
> arbitrary byte count that a device want to transfer on each INTRQ (read from 
> the byte count low/high regs).

Actually our ATAPI logic plain doesn't work for arbitary byte counts but
that is another story that needs looking into now the can of worms has
been noticed and opened.
