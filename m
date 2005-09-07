From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Wed, 07 Sep 2005 11:01:46 +0900
Message-ID: <431E4A0A.3060504@gmail.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:31058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751200AbVIGCBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 22:01:55 -0400
Received: by zproxy.gmail.com with SMTP id r28so914303nza
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 19:01:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Smith <alceste@xmission.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


  Hello, Jeremy.

Jeremy Smith wrote:
> 
> 
> I'm working on a system (K8N-DL) with a 3114 driver running 2.6.12 and 
> experiencing lockups on heavy disk access.  This is the built-in on an 
> ASUS-K8N-DL board.  I was wondering if the following problem is 
> symptomatic of a known bug.
> 
> I will get momentary freezes, and then I'll continue.  At some point 
> though, the disk access will freeze--no panic, but a lockup of all disk 
> access.  I have configured the first drive as a single drive 
> concatenation in the "RAID" bootup and haven't done anything with the 
> second drive.  The large logical partition on each drive is configured 
> with software RAID.

  You're the second person reporting similar problem with ASUS K8N-DL 
board.  Please see the following threads.

http://marc.theaimsgroup.com/?l=linux-ide&m=112497821103098&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=112600646820285&w=2

> dd if=/dev/sda of=/dev/null can reproduct error, as can several 
> disk-intensive activities

  In the following mail, I've attached a patch which might alleviate 
errors during writes (as Alexander was reporting CRC errors with write 
commands), but it won't do any good if you're getting errors during reading.

http://marc.theaimsgroup.com/?l=linux-ide&m=112602112819183&w=2

  Carlos and Paul, do you guys know anything about this mainboard? 
Should we perform some special tweaking to get these boards work?  I'll 
dig 3112/3114 document further but I'm not very sure what I should look for.

  Thanks.

-- 
tejun
