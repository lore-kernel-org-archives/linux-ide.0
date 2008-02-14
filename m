From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] scsi: align shost->hostdata to cacheline
Date: Fri, 15 Feb 2008 07:49:03 +0900
Message-ID: <47B4C55F.1070806@gmail.com>
References: <20080212180254.GA28237@postdiluvian.org>	 <20080212221257.12eeab13@core>	<20080213184702.GA13458@postdiluvian.org>	 <20080213202151.34b7e5bc@core>	<20080213212549.GA14732@postdiluvian.org>	 <20080214002135.065dd322@core> <47B3AFDC.5040605@gmail.com>	 <47B40E51.3060002@gmail.com> <1203001520.3189.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:58378 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934134AbYBNWtL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 17:49:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so332878rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 14:49:10 -0800 (PST)
In-Reply-To: <1203001520.3189.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Jens Axboe <jens.axboe@oracle.com>

James Bottomley wrote:
> On Thu, 2008-02-14 at 18:48 +0900, Tejun Heo wrote:
>> shost->hostdata can contain arbitrary data including DMA target
>> buffers.  Align it to cacheline.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> James, what do you think?
> 
> Hmm, it will blow out the host size ... although that's not such a huge
> problem since there are relatively few of them in most running kernels.
> What's the actual use case for this, though?  The host structure is
> allocated in ordinary memory ... we don't make sure it's DMAable, and
> most HBAs that want to use memory for mailboxes need coherent memory
> anyway.

"As it can contain arbitrary structure, it should follow the largest
meaningful alignment to allow the contained structure proper alignment."
is the logic.  I think it's generally RTTD for inline private data but
feel free to disagree.

Thanks.

-- 
tejun
