From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from
 qc->tf
Date: Sat, 01 Dec 2007 18:23:44 -0500
Message-ID: <4751ED00.90802@garzik.org>
References: <20071126113438.GB9232@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55745 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbXLAXXq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:23:46 -0500
In-Reply-To: <20071126113438.GB9232@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mikpe@it.uu.se, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make pdc_atapi_pkt() use values from qc->tf instead of creating its
> own.  This is to ease future ATAPI handling changes.
> 
> DONT APPLY YET
> ---
> Mikael, would this work?  Values other than lbam and lbah remain the
> same.  Does sata_promise have strict requirements for lbam and lbah?
> 
> Thanks.
> 
>  drivers/ata/sata_promise.c |   34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)

what was the outcome of this discussion?

I haven't looked over the Promise datasheet nor checked my brain for 
details, hoping Mikael would do that for me ;-)


