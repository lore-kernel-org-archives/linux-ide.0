From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: kill ata_irq_on() prototype
Date: Fri, 14 May 2010 17:36:51 -0400
Message-ID: <4BEDC273.8070301@pobox.com>
References: <201005062215.22697.sshtylyov@ru.mvista.com> <4BEDBF99.8010006@pobox.com> <4BEDC09C.3040103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49805 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab0ENVgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:36:53 -0400
Received: by gwj19 with SMTP id 19so1563493gwj.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:36:52 -0700 (PDT)
In-Reply-To: <4BEDC09C.3040103@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org

On 05/14/2010 05:29 PM, Sergei Shtylyov wrote:
> Hello.
>
> Jeff Garzik wrote:
>
>>> Commit 9363c3825ea9ad76561eb48a395349dd29211ed6 renamed ata_irq_on() to
>>> ata_sff_irq_on() but forgot to rename its prototype in "libata.h". This
>>> prototype is duplicate anyway, as the function is already declared in
>>> <linux/libata.h>, so remove it...
>
>>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
>>> ---
>>> The patch is against the recent Linus' tree.
>
>>> drivers/ata/libata.h | 1 -
>>> 1 file changed, 1 deletion(-)
>
>> applied
>
> Jeff, this patch conflicts with Tejun's recently posted patch:
>
> http://marc.info/?l=linux-ide&m=127352053709702
>
> It would probably have been better to apply Tejun's patch as more complete.

So noted, patch dropped.  I was about to turn to Tejun's pile-o-stuff, 
and this saved me a bit of time.

	Jeff




