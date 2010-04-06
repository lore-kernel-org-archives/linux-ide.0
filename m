From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RFC] ata/core: don't enable the interrupt while activating the
 host
Date: Tue, 06 Apr 2010 14:00:33 +0400
Message-ID: <4BBB0641.3040500@ru.mvista.com>
References: <20100311220417.GA16022@Chamillionaire.breakpoint.cc> <4BAAAEA1.9040906@kernel.org> <20100325220421.GA1051@Chamillionaire.breakpoint.cc> <4BABF7CE.6060908@kernel.org> <20100406094535.GA30917@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50609 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0DFKBM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 06:01:12 -0400
Received: by bwz1 with SMTP id 1so3440850bwz.21
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 03:01:11 -0700 (PDT)
In-Reply-To: <20100406094535.GA30917@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hello.

Sebastian Andrzej Siewior wrote:

>> On 03/26/2010 07:04 AM, Sebastian Andrzej Siewior wrote:
>>     
>>>> Can you please play with ata_sff_freeze() and find out why it's not
>>>> working?
>>>>         
>>> I've been there. I've moved the functions around and nothing changed.
>>> After removing the ATA_NIEN bit it started working. So it looks like
>>> ->sff_check_status() & ->sff_irq_clear() are not clearing the interrupt
>>> for what reason ever.
>>>       
>> What happens if you remove everything else from the function and just
>> set ATA_NIEN?
>>     
>
> removing everything from ata_sff_freeze() makes the interrupt storm go
> away.
> Leaving
> - ap->ctl |= ATA_NIEN;
>   => seems to work
> - the upper and "ap->last_ctl = ap->ctl;"
>   => seems to work
> - the upper and "iowrite8(ap->ctl, ioaddr->ctl_addr);"
>   => irq storm on request irq.
>
> ata_sff_check_status() does not report ATA_DRQ set so I don't know why
> the interrupt is comming.
>   

   Perhaps the drive incorrectly triggers interrupt on setting the nIEN 
bit -- some drives are known to do this; there is a blacklist of such 
drives in the IDE core so that it avoids setting nIEN bit for them.

WBR, Sergei

