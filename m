From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Thu, 22 Jan 2009 00:17:27 -0500
Message-ID: <49780167.1060208@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca> <4977C5A5.8070202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48432 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbZAVFR3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 00:17:29 -0500
In-Reply-To: <4977C5A5.8070202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
..
>> +    /* Enable message-switched interrupts, if requested */
>> +    if (msi && 0 == pci_enable_msi(pdev))
>> +        hpriv->hp_flags |= MV_HP_FLAG_MSI;
> 
> I just don't like CONSTANT OP EXPRESSION construct.
..

Heh.. Myself, I would normally just write it this way:

     if (msi && !pci_enable_msi(pdev))

But the "coding correctness police" might point out that
it reads funny (negatives and all that).

But whatever way Jeff likes it, really.

-ml
