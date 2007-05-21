From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 18:12:26 +0200
Message-ID: <4651C4EA.8070604@gmail.com>
References: <20070521151332.4ec9ea1d@the-village.bc.nu>	<4651AB20.7070103@gmail.com>	<20070521154741.490bcdb6@the-village.bc.nu>	<4651B23A.40207@gmail.com> <20070521171410.6920bd3b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:19730 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925AbXEUQMj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:12:39 -0400
Received: by py-out-1112.google.com with SMTP id a73so363554pye
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 09:12:38 -0700 (PDT)
In-Reply-To: <20070521171410.6920bd3b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I think host side detection should work as long as the bridge properly
>> releases CBLID after IDENTIFY.  Drive side detection seems hopeless
>> unless the bridge modifies IDENTIFY data accordingly.  Maybe the best we
>> can do here is allowing user to select transfer mode.  :-(
> 
> There are far too many systems with this kind of bridge to just dump it
> on the user. I'll have a think about doing it only if the controller
> hasn't decided the cable is 40 wire. That might work.

Okay.

>>>> Another problem is that there are still codes which interpret ap->cbl ==
>>>> ATA_CBL_SATA as SATA host port.  They need to be fixed first before
>>>> using ap->cbl for the actual cable type.
>>> I thought we had those all sorted now. A grep shows there is nobody doing
>>> conditional checking off the ap->cbl cable in drivers/ata any more. They
>>> did in the past - which is this patch got held up - but no longer that I
>>> can see.
>> Hmm... I was looking at sata_scr_valid().  I think this needs to be
>> converted to ATA_FLAG_SATA test too.
> 
> Possibly but PATA controllers don't have ->scr_read so its ok as is.

I'll submit a patch just in case.  I think we used to do depend on that
for PATA/SATA combined controllers before new init model.

Thanks.

-- 
tejun
