From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 12:32:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040328123240.4332964e.akpm@osdl.org>
References: <4066021A.20308@pobox.com>
	<200403282030.11743.bzolnier@elka.pw.edu.pl>
	<20040328183010.GQ24370@suse.de>
	<200403282045.07246.bzolnier@elka.pw.edu.pl>
	<406720A7.1050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <406720A7.1050501@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, wli@holomorphy.com, nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  I like generic tunables such as "laptop mode" or "low latency" or "high 
>  throughput".  These sorts of tunables should affect the "automagic" 
>  calculations.

Not sure.  Things like "low latency" and "high throughput" may need other
things, such as "seek latency" and "bandwidth" as _inputs_, not as outputs.

Such device parameters should have reasonable defaults, and use a userspace
app which runs a quick seek latency and bandwidth test at mount-time,
poking the results into sysfs.
