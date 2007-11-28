From: Jeff Garzik <jeff@garzik.org>
Subject: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 08:45:04 -0500
Message-ID: <474D70E0.4060709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38934 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbXK1NpG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 08:45:06 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IxNDt-00057g-3m
	for linux-ide@vger.kernel.org; Wed, 28 Nov 2007 13:45:05 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

This has been bubbling on my brain for a while.  I blathered on about 
this on IRC to Tejun, but figured I might as well post it here and get 
it archived.

In general, I think we should adopt a flexible or "loose" model for 
acking interrupts on SFF controllers.

(a) whenever we are in bus-idle (qc == NULL), and get an interrupt, go 
ahead and read Status.

(b) if we are expecting an interrupt, and receive one, check Status (or 
AltStatus if DMAing).

(c) if condition "(b)" indicates busy, initiate status polling every 
250ms until timeout occurs or BSY clears.

(d) if N seconds (4?) elapses without an interrupt, initiate polling. 
keep a history of such "fail-over" events, and note each fail-over'd 
command's eventual success via polling, success via interrupt, or 
timeout.  Use that history to decide to switch to 100% polling mode 
(i.e. reach conclusion that interrupt delivery is broken, via observation)

That should cover no-interrupts, lost interrupts, early interrupts, 
screaming interrupts, insane devices, and of course normal operation.

The model could be summarized as "interrupt as a hint" operation.

	Jeff




