From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_promise error handling
Date: Tue, 03 Jul 2007 15:45:07 +0900
Message-ID: <4689F073.4070405@gmail.com>
References: <200706191859.07050.tbaumgartner@swissonline.ch> <loom.20070620T064715-435@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:19221 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbXGCGpS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 02:45:18 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1127762nze
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 23:45:17 -0700 (PDT)
In-Reply-To: <loom.20070620T064715-435@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark <mark@runuo.com>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Mark wrote:
>> Can I ignore them (EH handled them) or do i have to worry that the dd images 
> are corrupted
>> (don't wanna make an md5sum of a 250gb disk and image)?

Yeah, data should be okay.  All failed commands are retried.

> I get the same errors with my Promise SATA300 TX4 with 3 Samsung SATA II 
> drives. I've been playing with it for a few days and I couldn't get to work 
> reliably in anything but 2.6.22-rc5.
> 
> Now that I use 2.6.22-rc5, I get those errors for a few minutes then the driver 
> hard resets and locks at 1.5 Gb/s. It seems reliable after that but I do get 
> those errors every now and then under heavy I/O.

That part of code got improved during 2.6.22 devel phase, so that's the
expected behavior.  It seems that the promise controller has some
problems when connected to certain 3Gbps drives (IIRC newer Seagate
ones).  It's most likely a hardware problem and we might need to default
to 1.5 Gbps on such combinations, but even without such modifications,
libata EH should do the right thing.

-- 
tejun
