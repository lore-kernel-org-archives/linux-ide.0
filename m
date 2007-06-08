From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 08 Jun 2007 17:02:24 +0900
Message-ID: <46690D10.9040808@gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org> <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com> <466196AD.3090502@garzik.org> <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com> <46667466.4010500@gmail.com> <9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com> <4667B347.9040900@gmail.com> <alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org> <20070607224746.GA23290@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:14313 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968329AbXFHICw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 04:02:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so945672wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 01:02:51 -0700 (PDT)
In-Reply-To: <20070607224746.GA23290@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>

Hello,

Jeff Garzik wrote:
> On Thu, Jun 07, 2007 at 01:56:11PM -0700, Linus Torvalds wrote:
>> On Thu, 7 Jun 2007, Tejun Heo wrote:
>>> Ah.. okay.  Now I see what's going on.  Jeff, this is another device
>>> which doesn't set nsect and lbal to 1 after reset.  Gregor, please try
>>> the attached patch.
> 
>> Tejun, since Jeff is apparently traveling this week, and Gregor tested the 
>> patch successfully (and it looks sane anyway - why in Gods name _would_ we 
>> care what the initial setting of nsect/lbal is?), can you send this in 
>> with the changelog and sign-off?
> 
> Ack'ing the sata_promise change was easy, but with this one it would
> be nice to wait a bit before changing the core probe code that [now]
> every ATA setup goes through, based on a single bug report.

Yeap, I'm not so sure about the change either.  The posted patch is more
of proof-of-concept.

Currently we have three related reports.

* this one
* IT8212 raid mode Alan is working on
* (likely) pata_pcmcia http://thread.gmane.org/gmane.linux.kernel/530099

> The values assist in detecting ghost devices (same device appearing
> on both master and slave) and TF register malfunctions, and I would
> appreciate not breaking _that_ so late in 2.6.22-rc for a single
> report.  Thankfully we have -some- ghost device prevention code
> elsewhere, but this is part of it.

Upto 2.6.21, if the same condition triggers, it delays 30secs and just
continue, so I don't think it was a worthy protection against ghost
devices or TF malfunction.  The only protection it offers is preventing
libata from accessing slave's status register too early.  SRST sequence
looks like the following.

1. SRST raised, delay, and cleared

2. libata waits for master device readiness after 150ms pause.  After
finishing reset, if slave is present, master waits for PDIAG- assert.

3. slave asserts PDIAG-, master asserts readiness.  libata goes on to
check for the slave device nsect/lbal.

4. slave sets nsect/lbal, libata goes on to check readiness

5. slave asserts readiness, SRST complete.

So, the nsect/lbal check is meaningful iff 1. slave lies about device
readiness after releasing PDIAG- but before setting nsect/lbal, or 2.
master/slave register selection is flimsy.

I don't think the first one is probable considering BSY is supposed to
set when SRST is received.  This is pretty fundamental in the protocol
and necessary for the device to work properly as master, so I think this
is one of few things we can rely upon.

To me, the second one sounds pretty far fetched too but, well, it's ATA.
 Who knows?

How about limiting nsect/lbal wait duration?  Say, 100ms or 500ms?  That
can somewhat ease our paranoia and should show acceptable behavior for
braindead devices too.

Thanks.

-- 
tejun
