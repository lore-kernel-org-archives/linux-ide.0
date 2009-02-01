From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/07] sata_mv: mv_fill_sg fixes
Date: Sun, 01 Feb 2009 16:46:14 -0500
Message-ID: <49861826.4060004@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca>	 <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>	 <49839209.9010602@rtr.ca> <49839256.7090402@rtr.ca> <da824cf30902011255s52878598v5f1e98746865bcab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33878 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZBAVqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Feb 2009 16:46:15 -0500
In-Reply-To: <da824cf30902011255s52878598v5f1e98746865bcab@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
> On Fri, Jan 30, 2009 at 3:50 PM, Mark Lord <liml@rtr.ca> wrote:
..
>>
>>        if (likely(last_sg))
>>                last_sg->flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
>> +       mb(); /* ensure data structure is visible to the chipset */
> 
> It's not obvious to me what you are racing against here.
> Normally the mb() is to prevent the above store from getting executed
> *after* some MMIO read or write that would tell the chip to read the
> flags_size field (or anything recently stored in that data structure).
> 
> I guess I'm asking for the comment to indicate which MMIO write it's
> racing with.
..

It's exactly the same as the generic routine in libata-sff,
which has a mb() in the same place for the same reason:
To ensure the PRD table is visible to the chipset
before we trigger the I/O operation.

Pretty standard.
