From: Mark Lord <mlord@pobox.com>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 03:08:35 -0400
Message-ID: <48609D73.5020000@pobox.com>
References: <OF1CA00FC2.4783C0D2-ON85257471.0053BCDF-85257471.0053FA0F@applera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFXHJA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 03:09:00 -0400
In-Reply-To: <OF1CA00FC2.4783C0D2-ON85257471.0053BCDF-85257471.0053FA0F@applera.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike P Moore <Mike.Moore@appliedbiosystems.com>
Cc: linux-ide@vger.kernel.org

Mike P Moore wrote:
> Hi Mark,
> 
>   Sorry to hijack this thread a little, but I was wondering how is the 
> support for the 88SX6081?
> Does it have hot-plug, PMP w/FIS switching, etc. yet?
..

The 6081 are PCI(-X) only chips, and so cannot be used with PCIe.
These older chips had many issues with various things, and most of
the errata workarounds required are now in Linux.
A few more are coming for 2.6.27, though.

The "C0" revision (PCI "Rev.9") is the best of the lot;
I wouldn't really use the older ones if I could avoid them,
as they do not support PMP hotplug.

No FIS-based switching on any 6081, but they all do support PMPs.

There is a newer 6042 chip for PCI(-X) slots,
which is more or less identical to the 7042 internally
and featurewise on Linux.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
