From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sat, 27 Sep 2008 18:19:19 +0200
Message-ID: <200809271819.19510.bzolnier@gmail.com>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:63134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbYI0R2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:28:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963865fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:50 -0700 (PDT)
In-Reply-To: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, Tejun Heo <htejun@gmail.com>

On Friday 12 September 2008, Atsushi Nemoto wrote:
> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

[...]

> > >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> > 
> > >>   Why is this needed BTW?
> > 
> > > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > > upper layers expects the data is in main memory.
> > 
> >     Hum, then I wonder why it's MIPS specific...
> 
> SPARC also have it.  And there were some discussions for ARM IIRC.

I was under the impression that it has been addressed by Tejun at
the higher-layer level (for both ide/libata) long time ago and that
MIPS/SPARC code are just a left-overs which could be removed now?

Thanks,
Bart
