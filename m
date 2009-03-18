From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 17:09:23 +0000
Message-ID: <20090318170923.12e779d3@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
	<20090318143230.2b64e273@lxorguk.ukuu.org.uk>
	<49C10DFC.2070206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37776 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbZCRRIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 13:08:34 -0400
In-Reply-To: <49C10DFC.2070206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> > 	if (n & (n - 1))
> ..
> 
> ????
> 
> Eg. for n = 5:  (5 & 4) == "true", but not a power of two.

if (!(...)) rather

Alan
