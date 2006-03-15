From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Wed, 15 Mar 2006 10:54:30 -0500
Message-ID: <441838B6.8060900@rtr.ca>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:14979 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1752106AbWCOPye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 10:54:34 -0500
In-Reply-To: <44164C25.10106@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff Garzik wrote:
> 
>> Applied, though I think its an open question what happens with
>> CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an
>> interrupt event that we clear, then life proceeds as normal.
> 
> Not sure. I have no such device at hand for test; currently relying
> on the SFF-8020i spec (http://www.bswd.com/sff8020i.pdf) as reference.
> According to p.31, we have to send out the CDB after receiving
> the CDB interrupt. So, just clearing the irq looks not enough.
> 
>> Does anybody actually have such a device anywhere?  :)
> 
> Maybe Alan or Mark knows? 
> 
> We really need tester for such device.

hdparm identifies them with "-I", but libata doesn't allow HDIO_DRIVE_CMD
on ATAPI (yet?), and I've not yet updated hdparm to use SGIO directly.

But I did have such devices here once, like this one below,
from my library of IDENTIFY dumps:

 >ATAPI CD-ROM, with removable media
 >        Model Number:       CD-ROM 36X/AKU
 >        Serial Number:
 >        Firmware Revision:  U10I
 >Standards:
 >        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
 >        Supported: CD-ROM ATAPI-1
 >Configuration:
 >        DRQ response: <=10ms with INTRQ
 >        Packet size: 12 bytes
...

MMmm.. there's even a drive on the shelf here that might
be that exact unit.  I'll plug it in and see if it is.

-ml

