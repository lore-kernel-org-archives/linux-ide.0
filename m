From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 26 May 2004 15:49:30 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085608170.4148.138.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <1085188300
	.3658.18.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:477 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265839AbUEZVtd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 May 2004 17:49:33 -0400
In-Reply-To: <1085188300.3658.18.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> To my newbie surprise, I have more good news.  Teaching my -bk8 kernel
> to clear x04 ATA_DMA_INTR, means my kernel no longer needs my lab hack of
> the bk8.good.always.patch.
> 
> Failure is ok now, though not yet autosensed.

Oi, I cannot repeat that result.

Sorry.  I therefore suspect back then I lost control of my version.

I find now that I have to clear unit attentions via the abuse of
unsolicited sense else { cmd->result = SAM_STAT_CHECK_CONDITION; }
occurs, which in turn makes my open/ ioctl SG_IO/ close hang, which in
turn denies me modprobe -r privilege.

In this thread I will continue working auto sense, but for the
contemporaneous issue of expecting no data I began again from vanilla
2.6.7-rc1-bk3 at:

Subject: [PATCH] libata SATAPI no data
http://marc.theaimsgroup.com/?l=linux-ide&m=108560773104910

Pat LaVarre


