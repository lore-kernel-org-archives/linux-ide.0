From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 13:42:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040329114210.GF1453@openzaurus.ucw.cz>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <200403280032.22180.bzolnier@elka.pw.edu.pl> <40660FEC.8080703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40660FEC.8080703@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Hi!

> >What about latency?
...
> merged transfer will top out at 8MB.  You don't see that unless 
> you're on a totally quiet machine with tons of free, contiguous 
> pages.  So in practice it winds up being much smaller, the more 
> loaded the system gets (and pagecache gets fragmented).
> 
> Latency definitely changes for the default case, but remember that a 
> lot of that is writeback, or streaming writes.  Latency-sensitive 
> applications already know how to send small or no-wait I/Os, because 

Well, waiting second for read because 32MB write is being done
will not be fun...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
