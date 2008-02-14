From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] scsi: align shost->hostdata to cacheline
Date: Thu, 14 Feb 2008 09:05:20 -0600
Message-ID: <1203001520.3189.11.camel@localhost.localdomain>
References: <20080212180254.GA28237@postdiluvian.org>
	 <20080212221257.12eeab13@core>	<20080213184702.GA13458@postdiluvian.org>
	 <20080213202151.34b7e5bc@core>	<20080213212549.GA14732@postdiluvian.org>
	 <20080214002135.065dd322@core> <47B3AFDC.5040605@gmail.com>
	 <47B40E51.3060002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:40397 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090AbYBNPF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 10:05:28 -0500
In-Reply-To: <47B40E51.3060002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jens Axboe <jens.axboe@oracle.com>

On Thu, 2008-02-14 at 18:48 +0900, Tejun Heo wrote:
> shost->hostdata can contain arbitrary data including DMA target
> buffers.  Align it to cacheline.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> James, what do you think?

Hmm, it will blow out the host size ... although that's not such a huge
problem since there are relatively few of them in most running kernels.
What's the actual use case for this, though?  The host structure is
allocated in ordinary memory ... we don't make sure it's DMAable, and
most HBAs that want to use memory for mailboxes need coherent memory
anyway.

James


