From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sat, 23 Jun 2007 16:54:16 +0900
Message-ID: <467CD1A8.5070700@gmail.com>
References: <20070620224847.GA5488@alinoe.com> <4679B2DE.9090903@garzik.org> <20070622214859.GC6970@alinoe.com> <467CC5C5.6040201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:44590 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXFWHyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 03:54:22 -0400
Received: by py-out-1112.google.com with SMTP id u77so729656pyb
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 00:54:22 -0700 (PDT)
In-Reply-To: <467CC5C5.6040201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Carlo Wood <carlo@alinoe.com>, Manoj Kasichainula <manoj@io.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Carlo Wood wrote:
>> The dmesg output of 33480a0ede8dcc7e6483054279008f972bd56fd3 (thus
>> "before") is:
> [...]
>> And the dmesg output of 551c012d7eea3dc5ec063c7ff9c718d39e77634f (thus
>> "after") is:
> [...]
> 
> Your disk configurations are quite radically different between the two
> kernels (see attached diff for key highlights).
> 
> The new behavior of the more recent kernel (551c012d7...) is that it now
> fully drives your hardware :)  The reset problems go away, NCQ is
> enabled, and if you had 3.0Gbps drives (you don't) they would be driven
> at a faster speed.
> 
> Given that some drives might be better tuned for benchmarks in
> non-queued mode, and that a major behavior difference is that your
> drives are now NCQ-enabled, the first thing I would suggest you try is
> disabling NCQ:
>     http://linux-ata.org/faq.html#ncq
> 
> Other indicators are the other changes in the "ahci 0000:00:1f.2:
> flags:" line, which do affect other behaviors, though none so important
> to RAID5 performance as NCQ, I would think.
> 
> Turning on NCQ also potentially affects barrier behavior in RAID, though
> I'm guessing that is not a factor here.

Ah.. right.  That should have enabled NCQ.  Me slow today.  :-)

-- 
tejun
