From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] tx4938ide: Fix build error due to read_sff_dma_status
 moving
Date: Thu, 15 Jan 2009 16:52:32 +0300
Message-ID: <496F3FA0.8060807@ru.mvista.com>
References: <1231608019-28679-1-git-send-email-anemo@mba.ocn.ne.jp> <4968DA1B.2020702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13217 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754698AbZAONv5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 08:51:57 -0500
In-Reply-To: <4968DA1B.2020702@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>> diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
>> index b4ef218..d909534 100644
>> --- a/drivers/ide/tx4938ide.c
>> +++ b/drivers/ide/tx4938ide.c
>> @@ -202,7 +202,6 @@ static const struct ide_tp_ops tx4938ide_tp_ops = {
>>      .exec_command        = ide_exec_command,
>>      .read_status        = ide_read_status,
>>      .read_altstatus        = ide_read_altstatus,
>> -    .read_sff_dma_status    = ide_read_sff_dma_status,
>>  
>>      .set_irq        = ide_set_irq,
>>  
> 
> 
>    Oops. Don;t know how I managed to miss this one...

    Ah, I know how: this driver was added after I created my patch, and I 
didn't re-check for the missing pieces several months later, when preparing 
the patch for submission. :-/

MBR, Sergei
