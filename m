From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Sun, 02 Apr 2006 04:07:52 -0400
Message-ID: <442F8658.2090905@pobox.com>
References: <11438230983159-git-send-email-htejun@gmail.com> <442ED8E6.6030306@pobox.com> <442F2110.7080501@gmail.com> <20060402065856.GI13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46313 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932095AbWDBIIA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:08:00 -0400
In-Reply-To: <20060402065856.GI13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Sun, Apr 02, 2006 at 09:55:44AM +0900, Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Implement ata_down_xfermask_limit().  This function manipulates
>>>> @dev->pio/mwdma/udma_mask such that the next lower transfer mode is
>>>> selected.  This will be used by ata_bus_probe() rewrite and later by
>>>> EH speeding down.
>>>>
>>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> ACK, though I share Alan's concerns, even with your explanation.  We'll 
>>> see where this leads...
>>>
>>> Not applied because it will cause a compile warning.
>>>
>> I'll write fuller description of synchronization model in the head 
>> message of new EH framework patchset. Sorry about the compile warning.
>>
> 
> Jeff, the compile warning is about ata_down_xfermask_limit() being
> unused,

Correct.  It just didn't get merged because I didn't merge any users.

	Jeff



