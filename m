From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 05/09] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Date: Mon, 07 Feb 2005 14:04:25 +0900
Message-ID: <4206F6D9.6050700@gmail.com>
References: <20050205021502.GA17767@htj.dyndns.org>	 <20050205021556.CFCE41326F9@htj.dyndns.org> <58cb370e050206103817d11145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.203]:41825 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261351AbVBGFEb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2005 00:04:31 -0500
Received: by wproxy.gmail.com with SMTP id 71so839039wra
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 21:04:30 -0800 (PST)
In-Reply-To: <58cb370e050206103817d11145@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@home-tj.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sat,  5 Feb 2005 11:15:56 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 
>>-       int err = 0;
>>-       u8 args[7], *argbuf = args;
>>-       int argsize = 7;
>>+       u8 args[7];
>>+       ide_task_t task;
>>+       task_ioreg_t *regs = task.tfRegister;
> 
> 
> u8 *regs please
> 

  Sure.

> 
>>+       int ret;
> 
> 
> What is the reason for changing the name of variable
> (other than making the patch bigger ;) ?

  Heh, Heh, I thought I could get away with it.

  I'll restore it. :-)

> Please also read comments to patch #4.

  Thanks.

-- 
tejun

