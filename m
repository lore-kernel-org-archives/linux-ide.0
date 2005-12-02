From: Tejun Heo <htejun@gmail.com>
Subject: Re: cpu consumption
Date: Fri, 02 Dec 2005 11:14:16 +0900
Message-ID: <438FADF8.5050209@gmail.com>
References: <5d96567b0511260545j61970a01j3b5c435766a51a6d@mail.gmail.com> <438FAB44.5030807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:61075 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964788AbVLBCOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 21:14:22 -0500
Received: by zproxy.gmail.com with SMTP id 14so132916nzn
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 18:14:21 -0800 (PST)
In-Reply-To: <438FAB44.5030807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Raz Ben-Jehuda(caro) wrote:
> 
>> Hello Jeff.
>> Here is my problem.
>>
>> When I issue a READ operation over a SATA disk in linux i have
>> huge cpu consumption , about 90% cpu usage.
>>
>> I am using MAXTOR disks in a supermicro machine.
>> the cpu test was made when i "raw read" from the DISK using DIRECT_IO.
> 
> 
> I dunno... do some profiling (in-kernel profiler, or oprofile) and see 
> where the CPU is being consumed.
> 
> Are you also seeing a lot of interrupts?
> 
>     Jeff
> 
> 

Jeff, this one is resolved.  It turned out that Raz mistook wait time to 
be busy.

Hmmm... marc doesn't show any mesage after 2005-11-25.  This is is 
resolved in a thread on linux-ide named "CPU usage is very high while 
io'ing a sata disk" from Raz.  The first message of the thread is posted 
on 2005-11-30 06:23 +0900.

-- 
tejun
