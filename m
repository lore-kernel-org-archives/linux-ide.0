From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/15] libata: implement ata_down_xfermask_limit()
Date: Sun, 02 Apr 2006 09:55:44 +0900
Message-ID: <442F2110.7080501@gmail.com>
References: <11438230983159-git-send-email-htejun@gmail.com> <442ED8E6.6030306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:15390 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932352AbWDBAzw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 19:55:52 -0500
Received: by zproxy.gmail.com with SMTP id o37so1359973nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 16:55:52 -0800 (PST)
In-Reply-To: <442ED8E6.6030306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement ata_down_xfermask_limit().  This function manipulates
>> @dev->pio/mwdma/udma_mask such that the next lower transfer mode is
>> selected.  This will be used by ata_bus_probe() rewrite and later by
>> EH speeding down.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK, though I share Alan's concerns, even with your explanation.  We'll 
> see where this leads...
> 
> Not applied because it will cause a compile warning.
> 

I'll write fuller description of synchronization model in the head 
message of new EH framework patchset. Sorry about the compile warning.

-- 
tejun
