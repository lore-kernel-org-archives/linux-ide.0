From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 16:21:37 -0500
Message-ID: <20090110162137.378e55fc@infradead.org>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<200901101404.39139.borntraeger@de.ibm.com>
	<49689F19.7030203@garzik.org>
	<20090110135104.3f402b5d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39487 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZAJVTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 16:19:39 -0500
In-Reply-To: <20090110135104.3f402b5d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

On Sat, 10 Jan 2009 13:51:04 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > 2.6.28 is OK
> > 2.6.28 + PIO32 is broken
> 
> As far as I can tell
> 
> 2.6.28 is broken but it doesn't show due to other factors
> 2.6.28 using 32bit PIO shows up the fact someone seems to be passing
> broken sg lists

are you sure; I have lots of these in kerneloops.org... so it does show
somewhat in 2.6.28... (assuming it's the exact same underlying bug
obviously)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
