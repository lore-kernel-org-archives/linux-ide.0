From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Sat, 08 Sep 2007 13:34:44 -0400
Message-ID: <46E2DD34.8000404@garzik.org>
References: <20070906210505.GF27404@parisc-linux.org> <46E258F3.20805@gmail.com> <20070908171917.GC6809@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33326 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbXIHRer (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Sep 2007 13:34:47 -0400
In-Reply-To: <20070908171917.GC6809@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> Can you tell me a bit more about these drivers?  Would it be possible to
> convert them to one host/many channels, which would give us the exclusion
> we want?


As a tangent, I would prefer a more "natural" representation than 
current, where there is a 1-1 correspondence between scsi_host and ATA 
controller instance, and a 1-1 correspondence between SCSI channels and 
ATA ports.

Alas _any_ change to the current setup requires special attention, 
because it is tied intimately into master/slave exclusion and scheduling.

I occasionally ponder what it would take to create an intelligent 
request scheduling framework that takes into account inflexible hardware 
bottlenecks like simplex (one command per controller, $n ports, $m 
devices), master/slave (one command port, $m devices), NCQ ($n commands 
per port, $m devices), port multipliers with their own bottlenecks, etc.

I see a lot of common code patterns in this area, but we are all sorta 
doing our own thing at a low level in drivers, because of subtle (and 
not-so-subtle) differences in hardware queueing support.

	Jeff, thinking out loud


