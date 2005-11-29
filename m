From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement ata_qc_exec_internal()
Date: Tue, 29 Nov 2005 12:09:27 +0900
Message-ID: <438BC667.4040107@gmail.com>
References: <20051128164201.GA7530@htj.dyndns.org> <5d96567b0511280948t45881bf9x989f27be235b47a1@mail.gmail.com> <438BC618.8070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:10556 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbVK2DJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2005 22:09:34 -0500
Received: by zproxy.gmail.com with SMTP id 13so18526nzn
        for <linux-ide@vger.kernel.org>; Mon, 28 Nov 2005 19:09:34 -0800 (PST)
In-Reply-To: <438BC618.8070300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Raz Ben-Jehuda(caro) wrote:
> 
>> does it solve the cpu usage ?
>>
>> On 11/28/05, Tejun Heo <htejun@gmail.com> wrote:
>>
>>> Each user libata internal commands initializes a qc, issues it, waits
>>> for its completion and checks for errors.  This patch factors internal
>>> command execution sequence into ata_qc_exec_internal().  The function
>>> also removes race condition between irq and timeout handling.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>
> 
> Hi, Raz.
> 
> It propabably has nothing to do with the cpu usage problem on piix you 
> reported.  I think you need to post more data to get people on the list 
> interested in your problem.  The followings may help.
> 
> 1. Please report exactly which kernel you're using and more information 
> on the hardware will also help.
> 
> 2. Don't use raid or any fs on it.  Just perform tests on raw /dev/sdx 
> devices.  Do something like 'time dd if=/dev/sdx of=/dev/zero bs=1M 
> count=1024' and report how much user/system time it uses.

Oops, count=1024 is way too small.  Do something like bs=1M count=1M or 
maybe count=10M.

> 
> 3. If above shows large system time consumption, build your kernel with 
> oprofile.  Start recording non-idle cpu cycles (the default) including 
> the kernel.  Repeat test in #2.  Dump oprofile result and post that here.
> 
> Hope it helps.
> 


-- 
tejun
