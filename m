From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: kill ata_irq_on() prototype
Date: Sat, 15 May 2010 01:29:00 +0400
Message-ID: <4BEDC09C.3040103@ru.mvista.com>
References: <201005062215.22697.sshtylyov@ru.mvista.com> <4BEDBF99.8010006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46665 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0ENV3r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:29:47 -0400
Received: by wwe15 with SMTP id 15so117681wwe.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:29:46 -0700 (PDT)
In-Reply-To: <4BEDBF99.8010006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>> Commit 9363c3825ea9ad76561eb48a395349dd29211ed6 renamed ata_irq_on() to
>> ata_sff_irq_on() but forgot to rename its prototype in "libata.h". This
>> prototype is duplicate anyway, as the function is already declared in
>> <linux/libata.h>, so remove it...

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

>> ---
>> The patch is against the recent Linus' tree.

>>   drivers/ata/libata.h |    1 -
>>   1 file changed, 1 deletion(-)

> applied

    Jeff, this patch conflicts with Tejun's recently posted patch:

http://marc.info/?l=linux-ide&m=127352053709702

    It would probably have been better to apply Tejun's patch as more 
complete.

MBR, Sergei
