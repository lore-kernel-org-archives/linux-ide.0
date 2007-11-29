From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Thu, 29 Nov 2007 10:04:18 +0900
Message-ID: <474E1012.40703@gmail.com>
References: <947127.83110.qm@web56306.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.181]:4350 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758949AbXK2BE0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 20:04:26 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2809702roc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 17:04:25 -0800 (PST)
In-Reply-To: <947127.83110.qm@web56306.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Cc: linux-ide@vger.kernel.org, hmh@debian.org

Dark Sylinc wrote:
> Some people around the net is concerned about their
> SATA drives. They're wondering if before kernel 2.6.22
> their SATA HDDs were making emergency shutdowns and
> didn't realize that they weren't normal shutdowns. And
> they may have been using Linux in their SATAs from a
> long time ago, just to realize now (thanks to the new
> K2.6.22 warning) that they were damaging their HDDs
> since years.
> In summary: the emergency shutdowns issue appeared in
> K2.6.22, and using previous kernels fixes it, or the
> emergenct shutdown happens in any kernel version??
> I can't answer that question by myself, because I've
> just installed Linux in this HDD and upgraded
> immediately.

It depends on your distro.  If the distro issues spin down on shutdown,
things should have been fine beofre 2.6.22 but it it doesn't, disks
attached via libata would do emergency unload on power off.  Also small
fraction of disks which spin up to do FLUSH_CACHE issued by kernel would
do double spin down where the last one is emergency if the distro
shutdown issues spin down.

2.6.22 fixes the problem completely for distros which don't issue spin
down.  For distros which do issue spin down, the situation isn't worse,
the kernel behaves the same way as before 2.6.22.  It just issues
FLUSH_CACHE.  The warning message is for small fraction of disks
mentioned above which do double spin down and to accelerate transition
to kernel-driven spin down.

>> Sure way to tell is to look at emergency unload
>> count int the output of
>> 'smartctl -a'.  Basically, it should identical to
>> 'hdparm -y'.
> 
> Thanks, but the idea that software can do such thing
> gives me the creeps.

Oh well, it can, apparently.  :-)

>> and yes you
>> definitely need to issue FLUSH before spinning down
>> the disk.
> 
> Seems missing both in the official src and in the
> patch provided...
> May be I can submit a patch...
> However the patch I'm using doesn't trigger FLUSH but
> the problem is solved anyway.

So, the patch isn't in the package yet?

-- 
tejun
