From: Tejun Heo <htejun@gmail.com>
Subject: Re: Data corruption with sata_sil (Sil 3112)
Date: Sat, 05 May 2007 17:34:20 +0200
Message-ID: <463CA3FC.3090906@gmail.com>
References: <20070504085955.GA5937@hostway.ca> <20070505024004.GA17765@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:52994 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031789AbXEEPei (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 11:34:38 -0400
Received: by py-out-1112.google.com with SMTP id a29so907007pyi
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 08:34:38 -0700 (PDT)
In-Reply-To: <20070505024004.GA17765@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Simon Kirby <sim@netnation.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello, Simon, Jim.

Jim Paris wrote:
>> I've been having problems with Sil 3112 cards I purchased for additional
>> SATA ports resulting in read data corruption, about 3-5 instances over
>> 2 GB of data, 100% reproducible.
> ..
>> I just rebuilt the entire box with the remains of another (went from
>> A7V8X (VIA) to A7N8X (NVidia), new CPU, new RAM, new power supply),
>> thinking the problem was related to the motherboard.  The issue followed
>> to the new box.
> 
> Have you tried different disks?  I recently spent a long time trying
> to track down the same sort of problem and it ended up being a bad
> HD (not a media failure, so SMART didn't report it).

Hmm... that's interesting.

>> This new motherboard has an onboard Sil 3112 as well.  The old onboard
>> was VIA SATA, which did not corrupt anything.  The Sil 3112 onboard now
>> does too.
> 
> Maybe the VIA controller was only 1.5 Gbps and your 3112 controllers
> are running at 3.0 Gbps?  Some drives have a jumper that lets you
> limit their operation to 1.5, which you could try.

3112 doesn't to 3.0 Gbps and SATA auto-negotiates transfer speed when
PHY goes online.  The jumper helps detection on some dump controllers
but shouldn't cause data corruption.

>> Scipt used to md5sum to find corruption:
>>
>> 	find $* -type f -print0 | sort -z | xargs -0 md5sum
> 
> Can you figure out the nature of the corruption?  Flipped bit, entire
> blocks corrupted, etc?  Maybe make two big identical files and use
> "cmp -l" to see how they read differently.

Yeap, please.

-- 
tejun
