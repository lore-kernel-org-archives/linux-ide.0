From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 15:02:28 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40672F54.1050703@pobox.com>
References: <4066021A.20308@pobox.com> <20040328175436.GL24370@suse.de> <20040328181223.GA791@holomorphy.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <40672D07.2060201@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262413AbUC1UCr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 15:02:47 -0500
In-Reply-To: <40672D07.2060201@vgertech.com>
List-Id: linux-ide@vger.kernel.org
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Nuno Silva wrote:
> With this kind of control we could have /etc/init.d/io-optimize that
> paused the startup for 10 seconds and tests every device|controller in
> fstab and optimizes according to the .conf file for latency or speed...
> Or a daemon that retrieves statistics and adjusts the policies every 
> minute?
> 
> Also, everybody says "do it in userland". This is doing (some of) it in
> userland :)


An iotune daemon that sits in userland -- probably mlockall'd into 
memory -- would be fun.  Like the existing irqbalance daemon that Red 
Hat (disc: my employer) ships, "iotuned" could run in the background, 
adjusting policies every so often.  It would be a good place to put some 
of the more high-level "laptop mode" or "high throughput mode" tunables, 
so that the user wouldn't have to worry about the minute details of such 
things.

Just watch the IO statistics and tweak the queue settings...  Gotta make 
sure the queue settings don't get tweaked beyond what the hardware can 
do, though.

A good iotune daemon would probably have to pay attention to various VM 
statistics as well, since the VM is often the one that decides when to 
start writing out stuff...  such an app could (quite justifiably) 
mushroom into a io-and-vmtune daemon.

This is a side issue from the topic of finding a decent in-kernel 
default, of course...

	Jeff



