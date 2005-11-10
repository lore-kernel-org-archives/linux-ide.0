From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Thu, 10 Nov 2005 18:01:09 +0900
Message-ID: <43730C55.7030808@gmail.com>
References: <20051110071736.23747.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.200]:1199 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbVKJJBT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Nov 2005 04:01:19 -0500
Received: by xproxy.gmail.com with SMTP id s14so506049wxc
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:01:18 -0800 (PST)
In-Reply-To: <20051110071736.23747.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org

linux@horizon.com wrote:
> Three days ago, I wrote:
> 
>>I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350
>>G of one drive without seeing problems, and am working on the other 5.
>>(In parallel, just to stress the driver.)
> 
> 
> My parallel -p1 badblocks runs (I shrunk the chunk size to -c 16384)
> finished on 3 of the 5 drives, but after 69 hours and I don't know how
> many passes, it's still running on one pair of drives.  Interestingly,
> the pair (sdc4 & sdd4) is connected to a single controller.
> 
> Thus, it might not be a multiple-controller issue (I don't know how
> many other people have 3 Sil3132s in a system), but perhaps an issue
> with simultaneous activity on the 2 ports of a single controller.
> 
> Is there anything else I could do to help debug this problem?  Any additional
> debugging I can enable?
> 
> It would take me a while to clean the backups off the system and move
> it outside the firewall to allow remote access if someone wants access
> to that particular hardware, but it's just an expensive bit bucket at
> the moment, so ask if it would help...

Hello, there.

I'll soon try to tackle this one.  However, I currently have only one
3124 controller and one harddisk to hook to that controller, so I cannot
reproduce your setup over here.  Here are things that I think might help
in diagnosing the problem.

* Trying other drivers
	* Trying the original driver.  I'll port the original driver
	  from sii to the current tree and post the patch.
	* Performing similar test under Windows.

* Ruling out disk problem
	* Trying other harddisks.  All harddisk drives perform error
	  detection/correction when data are read from the media, but
	  ruling out the possibility would still be helpful.

* If you have log of failed sectors, finding patterns will be helpful.
  If the errors occur at random places, it's likely that we have
  controller/driver issues.  If errors are localized over multiple runs,
  maybe the disk is at fault.

-- 
tejun
