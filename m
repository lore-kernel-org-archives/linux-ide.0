From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Fri, 10 Nov 2006 07:47:10 +0900
Message-ID: <4553AFEE.1070504@gmail.com>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>	 <20061030114503.GW4563@kernel.dk>	 <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>	 <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org>	 <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:15079 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424217AbWKIWrV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 17:47:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1178777nfa
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 14:47:20 -0800 (PST)
In-Reply-To: <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Monty Montgomery <monty@xiph.org>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Jens Axboe <jens.axboe@oracle.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Douglas Gilbert <dougg@torque.net>

Hello,

Monty Montgomery wrote:
[--snip--]
>>  Kernel
>> and libata can't do much about it.  So, please find other way to detect
>> interface.
> 
> Just to be clear-- it is the kernel at fault here, and the kernel can
> do something about it-- but only if the kernel gets fixed.  Also to be
> clear, given this brokenness, yes I need to find another way.

Yeap, it seems to be kernel's fault and we need to fix both.

> Dammit, dammit, dammit, one step forward, two steps back :-(

:-(

-- 
tejun
