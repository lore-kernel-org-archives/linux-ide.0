From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil4726 ahci driver initialization sequence
Date: Fri, 30 Nov 2007 19:57:21 +0900
Message-ID: <474FEC91.1040203@gmail.com>
References: <5501535d0711290927u613e61d1h2368eebc26bd4982@mail.gmail.com>	 <474F5DDB.2090408@gmail.com> <5501535d0711300251xdd609d2w86b912184fd85a0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:1538 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbXK3K5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 05:57:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2630697wah
        for <linux-ide@vger.kernel.org>; Fri, 30 Nov 2007 02:57:32 -0800 (PST)
In-Reply-To: <5501535d0711300251xdd609d2w86b912184fd85a0d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjoern Olausson <lkmlist@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Bjoern Olausson wrote:
> On 11/30/07, Tejun Heo <htejun@gmail.com> wrote:
>> JMB?  That's Jmicron.  What should be updated is the SIMG4726 firmware.
>>
> 
> Sry you are right.... seems my mind was on holliday when writing the mail.
> Okay, I'll see if I can find something to update the SIMG4726 and test
> hotpuging.
> 
> (any advices?)

Please first verify the problem occurs on your machine before updating
firmware.  You can download needed software from silicon image's web
page.  You'll probably need to use Windows.  :-(

-- 
tejun
