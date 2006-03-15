From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Wed, 15 Mar 2006 11:49:58 -0500
Message-ID: <441845B6.2070200@rtr.ca>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com> <441838B6.8060900@rtr.ca> <44183CDA.5010407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:40590 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1752145AbWCOQuC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 11:50:02 -0500
In-Reply-To: <44183CDA.5010407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Mark Lord wrote:
>
> Yup, I have two such drives here.
> 
> One of them has a grease-pencil "NFG" marking on it,
> and other other one doesn't.  They both powered up and
> worked just now, and their identify blobs are attached
> (you can interpret them with "hdparm --Istdin <blob").
..

Oh, another note:  neither of these two drives works
with DMA enabled, at least not in 2.6.12 using the IDE driver.

PIO mode appears to be functioning fine on both of them.

Cheers
