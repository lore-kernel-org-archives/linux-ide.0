From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI
 devices
Date: Wed, 3 Jan 2007 11:34:15 +0000
Message-ID: <20070103113415.707f4ab3@localhost.localdomain>
References: <200701021939.10496.liml@rtr.ca>
	<459AFDC2.6060900@garzik.org>
	<20070103010724.19b17522@localhost.localdomain>
	<459B42C5.2080804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58502 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750695AbXACLYF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 06:24:05 -0500
In-Reply-To: <459B42C5.2080804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

> > For 16 byte commands via SG_IO you know the command is 16 bytes long as
> > the command length is passed in hdr->cmd_len which becomes rq->cmd_len.
> > Is that not sufficient to avoid this ATA_16 test if you pass it on to the
> > required functions ?
> 
> No.  The SCSI code calculates the expected cmd_len based on the opcode it sees,
> and makes exceptions only for the vendor-specific command blocks,
> which ATA_16 is *not* part of.

I know it currently does this, the more important question for the ATA
side is - should it ? 
