From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Sat, 26 Aug 2006 00:35:24 +0900
Message-ID: <44EF18BC.8040505@gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>	 <44EC8128.2040204@gmail.com>	 <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>	 <44ECAB62.8030804@gmail.com>	 <8202f4270608231255k116918dfk58e4c14cd859c175@mail.gmail.com>	 <8202f4270608231349v5aabace2xaff8fe93c133a7ca@mail.gmail.com>	 <20060824070257.GD21866@htj.dyndns.org>	 <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>	 <44EDDB91.1050102@gmail.com>	 <8202f4270608241701g494bfadaw74dd3d059182e4cc@mail.gmail.com> <8202f4270608250826h67edf5d7n8436961374896348@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:49868 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030254AbWHYPfb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 11:35:31 -0400
Received: by wr-out-0506.google.com with SMTP id i21so157516wra
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 08:35:31 -0700 (PDT)
In-Reply-To: <8202f4270608250826h67edf5d7n8436961374896348@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> Hi Tejun,
> 
> JFYI. I found a workaround which seems to be working in 2.6.18-rc2.
> During warm plug/unplug, if I don't delete the device through sysfs or
> proc and just rescan the host, it recovered just fine.

Hello,

I'm trying to reproduce it here but haven't succeeded yet.  Can you 
describe what you did in more detail?  I'm trying various things - 
issuing delete / scan, combination of them after unplugging my drive, 
etc..., but haven't succeeded in reproducing your error condition.  It 
seems to be a sdev refcnting problem in libata but I need more clue...

Thanks.

-- 
tejun
