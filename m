From: "SMALL, Timothy" <timothy.small@astrium.eads.net>
Subject: RE: Questions about ATA Command Timeouts and kernel lockups
Date: Tue, 15 Nov 2005 10:00:56 -0000
Message-ID: <C2D16922D674664C9CCA61127AC9B77B03E0F0@auk52177.ukr.astrium.corp>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viruswall.astrium.eads.net ([194.203.13.70]:44048 "EHLO
	viruswall.astrium.eads.net") by vger.kernel.org with ESMTP
	id S1751417AbVKOKBI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Nov 2005 05:01:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Chase Venters' <chase.venters@clientec.com>, linux-ide@vger.kernel.org


-----Original Message-----
> From: Chase Venters [mailto:chase.venters@clientec.com]
> kernel and the bus over DMA, but it seems to me that since this diagnostic

> information *does* get printed, followed by a total lockup, that the
kernel 
> may be falling into a tight loop with interrupts disabled. To this end,
I'm 
> building the kernel that will run on my system once it's rebuilt to
include 
> sleep while holding spinlock checking.
> 	Is there anything else I can do, in case this crash hits me again?

Enable the NMI watchdog?

This email is for the intended addressee only.
If you have received it in error then you must not use, retain, disseminate or otherwise deal with it.
Please notify the sender by return email.
The views of the author may not necessarily constitute the views of EADS Astrium Limited.
Nothing in this email shall bind EADS Astrium Limited in any contract or obligation.

EADS Astrium Limited, Registered in England and Wales No. 2449259
Registered Office: Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England
