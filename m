From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 15:45:04 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40673950.4050703@pobox.com>
References: <4066021A.20308@pobox.com>	<200403282030.11743.bzolnier@elka.pw.edu.pl>	<20040328183010.GQ24370@suse.de>	<200403282045.07246.bzolnier@elka.pw.edu.pl>	<406720A7.1050501@pobox.com> <20040328123240.4332964e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262046AbUC1UpV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 15:45:21 -0500
In-Reply-To: <20040328123240.4332964e.akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, wli@holomorphy.com, nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> I like generic tunables such as "laptop mode" or "low latency" or "high 
>> throughput".  These sorts of tunables should affect the "automagic" 
>> calculations.
> 
> 
> Not sure.  Things like "low latency" and "high throughput" may need other
> things, such as "seek latency" and "bandwidth" as _inputs_, not as outputs.

I should probably better define the hypotheticals :)  I think of "laptop 
mode" or "low latency versus high throughput" more as high level binary 
flags, influencing widely varying things like from an ATA disk's "low 
noise versus high performance" tunable to the IO scheduler's deadlines.


> Such device parameters should have reasonable defaults, and use a userspace
> app which runs a quick seek latency and bandwidth test at mount-time,
> poking the results into sysfs.

Certainly...

	Jeff



