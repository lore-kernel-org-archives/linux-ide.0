From: greg <greg-dated-1184731565.7e0579@lucidsolutions.co.nz>
Subject: Re: [RFT][PATCH v7] =?utf-8?b?c2F0YV9tdjo=?= convert to new EH
Date: Fri, 13 Jul 2007 04:09:05 +0000 (UTC)
Message-ID: <loom.20070713T053938-434@post.gmane.org>
References: <20070711200538.GA7374@havoc.gtf.org> <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org> <46960225.5000502@garzik.org> <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXGMEPE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 00:15:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I9CYY-0003YK-EI
	for linux-ide@vger.kernel.org; Fri, 13 Jul 2007 06:15:02 +0200
Received: from mta.lucidsolutions.co.nz ([202.154.159.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 06:15:02 +0200
Received: from greg-dated-1184731565.7e0579 by mta.lucidsolutions.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 06:15:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

dean gaudet <dean <at> arctic.org> writes:
> if you've got any other workload you'd like me to throw at it, 
> let me know.  

I've had a few problems with the driver in 2.6.20 (fc6xen x86_64). The machine 
tended to lock up after a random period of time (from a few minutes upwards), 
without any messages. Performing a smartctl on all the disks, or leaving smartd 
running, seemed to speed up the rate at which the crash occurred. What I found 
was that by moving the sata_mv device onto it's own bus (or a bus with two 
sata_mv devices), the crashes went away. Are you doing tests with the 
controller sharing a bus with other devices?

Is there an merit to my observation that it might be an issue with devices 
sharing a PCI-X bus?

Cards: Supermicro 5081 (SAT-MV8), Supermicro 6081 (SAT2-MV8), Highpoint 5081 
(RocketRaid 1820A v1.1). Motherboards: Tyan S2882, AMD 8131 chipset; IBM x206, 
Intel 6300ESB.

