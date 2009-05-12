From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA disks resets in a md setup
Date: Tue, 12 May 2009 17:24:57 +0900
Message-ID: <4A093259.30606@kernel.org>
References: <200905081739.46206.v.virvilis@biovista.com> <4A053229.5010406@garzik.org> <200905111324.38715.v.virvilis@biovista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58768 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292AbZELIYt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 04:24:49 -0400
In-Reply-To: <200905111324.38715.v.virvilis@biovista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: v.virvilis@biovista.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Vassilis Virvilis wrote:
> Ok I changed
> 	M/B,
> 	PSU
> 	and cables.
> 
> Now the stress test passes only one SATA reset instead of 3 or 4 before the fatal one.
> 
> 
> [ 1804.915319] ata1.01: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
> [ 1804.915319] ata1.01: ST-ATA: DRQ=1 with device error, dev_stat 0x0
> [ 1804.915319] ata1: SError: { PHYRdyChg }
> [ 1804.915319] ata1.01: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/10 tag 0 pio 512 in
> [ 1804.915319]          res 00/00:01:09:4f:c2/00:00:00:00:00/10 Emask 0x212 (ATA bus error)
> [ 1804.915319] ata1: hard resetting link
> [ 1810.279540] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

PHYRdyChg under load is very symptomatic of inadequate power supply.
If you run "smartctl -a" on the device before and after the error,
what counters change?

If you have two PSUs around, one thing worth trying is to power up the
second PSU separately and put half of the drives on the separate PSU
and see whether the problem goes away or the pattern of failures
changes.  PSU can be easily powered up w/o motherboard.

  http://modtown.co.uk/mt/article2.php?id=psumod

-- 
tejun
