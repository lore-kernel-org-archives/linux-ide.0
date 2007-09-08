From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 08 Sep 2007 22:27:14 +0200
Message-ID: <46E305A2.9090907@gmail.com>
References: <20070906210505.GF27404@parisc-linux.org> <46E258F3.20805@gmail.com> <20070908171917.GC6809@parisc-linux.org> <46E2DD34.8000404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:26283 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbXIHU2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 16:28:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so986414wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 13:28:50 -0700 (PDT)
In-Reply-To: <46E2DD34.8000404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Matthew Wilcox wrote:
>> Can you tell me a bit more about these drivers?  Would it be possible to
>> convert them to one host/many channels, which would give us the exclusion
>> we want?
> 
> As a tangent, I would prefer a more "natural" representation than
> current, where there is a 1-1 correspondence between scsi_host and ATA
> controller instance, and a 1-1 correspondence between SCSI channels and
> ATA ports.

Currently, the biggest problem is the EH thread.  SCSI EH is per host
and entering entering SCSI EH means host-wide quiescence.

> Alas _any_ change to the current setup requires special attention,
> because it is tied intimately into master/slave exclusion and scheduling.
> 
> I occasionally ponder what it would take to create an intelligent
> request scheduling framework that takes into account inflexible hardware
> bottlenecks like simplex (one command per controller, $n ports, $m
> devices), master/slave (one command port, $m devices), NCQ ($n commands
> per port, $m devices), port multipliers with their own bottlenecks, etc.
> 
> I see a lot of common code patterns in this area, but we are all sorta
> doing our own thing at a low level in drivers, because of subtle (and
> not-so-subtle) differences in hardware queueing support.

Amen.  It's slow but things are being shifted from SCSI to block.  EH
can be shifted to block and made per-queue.  Mapping the current SCSI EH
architecture to it will take some work but after that changing ATA host
<-> SCSI host mapping shouldn't be too difficult.

Thanks.

-- 
tejun
