From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bug or HW? ata1: command timeout, stat 0x50 host_stat 0x4
Date: Wed, 28 Jun 2006 15:33:47 +0900
Message-ID: <44A222CB.1080300@gmail.com>
References: <20060627184320.GA16782@planetzork.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:45753 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932746AbWF1Gd2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:33:28 -0400
Received: by wr-out-0506.google.com with SMTP id i24so347822wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 23:33:28 -0700 (PDT)
In-Reply-To: <20060627184320.GA16782@planetzork.ping.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Cc: linux-ide@vger.kernel.org

Jochen Heuer wrote:
> Hi everyone!
> 
> I have some severe problems on my Athlon X2 system. The problem is that the
> system sometimes hangs (during plain web browsing). If I wait long enough the
> system comes to a complete halt so that not even sysrq does work. The system
> has to be reset and then everything is fine again for some time.
> 
> Today I was quick enough to switch from X11 to console and check sysrq output.
> After enabling logging (sysrq+6) I got the following messages on console:
> 
> ata1: command 0xca timeout, stat 0x50 host_stat 0x4
> ata1: status=0x50 { DriveReady SeekComplete }
> ata1: command 0xea timeout, stat 0x50 host_stat 0x0
> ata1: status=0x50 { DriveReady SeekComplete }

The original error is probably a hardware problem.

> Then the system was frozen again and only reset did help. Log files don't
> contain any infos which makes sense since ata1 is the disk with the OS and
> where metalog should save log files ...
> 
> Some infos to my system:
> 
> Asus A8V with Athlon X2 3800 and 2GB memory
> current kernel 2.6.17 with SMP compiled
> 
> I had hoped 2.6.17 would fix this since I seem to remember some fixes for
> libata with similar error messages. But at least on my system it did not.

Can you apply the following patch and see what happens?

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2

-- 
tejun
