From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/12] libata: ignore normal qc completion during EH
Date: Sun, 22 Jan 2006 20:09:25 +0900
Message-ID: <43D367E5.4040104@gmail.com>
References: <11379167111733-git-send-email-htejun@gmail.com> <43D35629.8030409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:37785 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932385AbWAVLJb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 06:09:31 -0500
Received: by xproxy.gmail.com with SMTP id s14so523202wxc
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 03:09:31 -0800 (PST)
In-Reply-To: <43D35629.8030409@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Don't let interrupt handler and pio task complete qc's while EH is in
>> progress.  This makes sure that qc's don't go away underneath EH.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> I haven't done an in-depth analysis, but this feels like the wrong 
> approach:  you've still got drivers writing to qc->err_mask, and 
> potentially other struct members.
> 
> The better solution is most likely to examine the interrupt handling 
> paths of each driver...
> 

No matter what we do to the interrupt handlers, once a qc enters EH, the 
qc is owned by EH and other entities must not be allowed to 
complete/free it.  This patch does not eliminate interferences between 
EH and others but it makes sure that oops doesn't occur due to 
completing qc underneath EH.

This patch + flushing solve the whole problem for PIO tasks.

This patch + proper IRQ masking during EH solve it for interrupt driven 
commands.

-- 
tejun
