From: Mark de Wever <koraq@xs4all.nl>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Sun, 21 Sep 2008 22:29:15 +0200
Message-ID: <20080921202915.GA17945@localhost>
References: <20080921185138.GA16310@localhost> <48D69F5A.9010201@ru.mvista.com> <48D6A9BB.1070705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4757 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYIUU3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 16:29:32 -0400
Content-Disposition: inline
In-Reply-To: <48D6A9BB.1070705@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 22, 2008 at 12:08:27AM +0400, Sergei Shtylyov wrote:
>>> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
>>> index 1bce84b..fd87b43 100644
>>> --- a/drivers/ide/ide-tape.c
>>> +++ b/drivers/ide/ide-tape.c
>>> @@ -2354,6 +2354,10 @@ static void  
>>> idetape_get_inquiry_results(ide_drive_t *drive)
>>>      ide_fixstring(product_id, 18, 0);
>>>      ide_fixstring(fw_rev, 6, 0);
>
>    Hm, I see that every string variable declared there has 2 extra  
> characters, and yet the author have managed to make a mistake... these 
> extra chars don't seem needed.

Those extra characters made me believe the intention was setting the
NULL character, therefore I used that solution in my patch.

Regards,
Mark de Wever
