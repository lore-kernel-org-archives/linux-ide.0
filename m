From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
	it in pata_via
Date: Thu, 28 Sep 2006 12:51:06 +0100
Message-ID: <1159444266.11049.422.camel@localhost.localdomain>
References: <20060928111151.GN25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4530 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161085AbWI1L0R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 07:26:17 -0400
In-Reply-To: <20060928111151.GN25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: castet.matthieu@free.fr, jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

Ar Iau, 2006-09-28 am 20:11 +0900, ysgrifennodd Tejun Heo:
> Rationale for this approach.
> 
> * uses existing facility and relatively simple
> * no busy sleep in the interrupt handler
> * updating drivers is easy

And another
	Follows the same behaviour as drivers/ide and certain other things. So
we are shifting to a different "known sane" behaviour path

> Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>


