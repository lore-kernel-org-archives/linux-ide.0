From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sat, 21 Mar 2009 14:02:50 +0000
Message-ID: <20090321140250.6569644d@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
	<49C11A0C.3070502@rtr.ca>
	<49C11ED4.2030307@rtr.ca>
	<49C19087.5000307@gmail.com>
	<49C190F1.7010202@kernel.org>
	<49C28133.8050401@rtr.ca>
	<49C281A5.5080404@rtr.ca>
	<49C2D642.90706@kernel.org>
	<49C39690.6090802@rtr.ca>
	<49C396CF.7030202@rtr.ca>
	<20090320140714.2e7770d0@lxorguk.ukuu.org.uk>
	<49C3B7E9.2000505@rtr.ca>
	<49C4235D.5070303@kernel.org>
	<49C43ABA.4010601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34666 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751970AbZCUODH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Mar 2009 10:03:07 -0400
In-Reply-To: <49C43ABA.4010601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Yeah, that has long been a design decision -- avoid all the mechanics of 
> PIO-Multi, simply because we did not have much of a need for it (and 
> still don't).
> 
> Albert Lee worked on PIO-Multi a while ago, which was mainly to get 
> ATA_{12,16} working, IIRC.
> 
> But overall, I don't see much of a need to introduce it into the main stack?

I don't see a need - and if we do its more important IMHO to get the PIO
paths out of the irq handlers before doing so.
