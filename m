From: "George Spelvin" <linux@horizon.com>
Subject: Re: 88SE9172 additional PCI ID: 1b4b:9172
Date: 28 May 2013 03:12:20 -0400
Message-ID: <20130528071220.3601.qmail@science.horizon.com>
References: <20130528002234.GB18531@mtj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:49200 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754650Ab3E1HMV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 May 2013 03:12:21 -0400
In-Reply-To: <20130528002234.GB18531@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

> I don't think it's a typo.

Indeed, pci.ids has three entries.

> And we'll need a separate entry
>
>> (If I enable VT-d and the IOMMU, the devices are recognized but not the
>> disks plugged into them, but I'm still working on figuring that out.)
>
> when the device gets working.

I don't quite understand this.  With VT-d disabled in the BIOS,
the devices *are* working.  I even have a port multiplier plugged
into one.  (Which gets all confused by hdparm -m16, but whatever.)

When I get time, I'm going to play with various BIOS and kernel
options to narrow down the problem.  But that's for later.

Can you explain what you think is not working now?
