From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 1/4] libata: cache device select
Date: Tue, 2 Mar 2010 17:28:47 +0000
Message-ID: <20100302172847.2e87de07@lxorguk.ukuu.org.uk>
References: <20100217130847.16338.55586.stgit@localhost.localdomain>
	<4B8C2079.7010607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50729 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752433Ab0CBRZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2010 12:25:36 -0500
In-Reply-To: <4B8C2079.7010607@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, jeff@garzik.org.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > -	ata_dev_select(ap, qc->dev->devno, 1, 0);
> > +	if (qc->dev->devno != ap->sff_selected)
> > +        	ata_dev_select(ap, qc->dev->devno, 1, 0);
> >
> >   	/* start the command */
> >   	switch (qc->tf.protocol) {
> 
> My main worry here is that this logic excises the 150ms wait in 
> ata_dev_select() that has been used effectively to allow ATAPI devices 
> to "collect themselves" after waiting for idle, prior to command issuance.

It doesn't. You call it with wait = 1, can_sleep = 0 so it will never do
the 150ms magic delay here anyway (good job or it would kill us for
performance ;))

It does mean we don't do the device idle wait in that situation but there
are no code paths where we try to overlap commands by spinning on the
drive busy bit (again for obvious reasons)

Alan
