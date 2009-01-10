From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 13:53:50 +0000
Message-ID: <20090110135350.4eef6c59@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<200901101009.13699.borntraeger@de.ibm.com>
	<20090110104114.633cacd8@lxorguk.ukuu.org.uk>
	<200901101242.05203.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<20090110130745.GA14049@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42516 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754005AbZAJN56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 08:57:58 -0500
In-Reply-To: <20090110130745.GA14049@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

> > That would therefore not trigger the WARN_ON. Someone has passed an sg 
> > list that isn't properly terminated perhaps ?
> > 
> > I wonder if the pad code broke this.
> 
> note, one of my testboxes in the -tip testing hw pool (an older HP laptop) 
> started triggering this too today:

No suprise - the traces I've got seem to indicate a bogus sg list from
the core libata code. If so its general and the 32bit pio is just showing
it up.
