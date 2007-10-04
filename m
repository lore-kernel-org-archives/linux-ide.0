From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 02:16:27 -0400
Message-ID: <18180.34107.704754.565573@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
	<18180.31651.305092.579581@kitty1.shrimp.net>
	<470480C9.9030309@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([204.127.225.92]:46113 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbXJDGQg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 02:16:36 -0400
In-Reply-To: <470480C9.9030309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Tejun Heo writes:
> > ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
> > ata4.00: hard resetting link
> > ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata4.01: hard resetting link
> > ata4.01: softreset failed (SRST command error)
> > ata4.01: reset failed (errno=-5), retrying in 10 secs
> 
> Eeeek, the above sequence repeats for each downstream port.  Weird.  How
> reproducible is the problem?  Every time?

I just rebooted and got exactly the same log (did diff), it seems very
reproducible.

Regards, Igor
