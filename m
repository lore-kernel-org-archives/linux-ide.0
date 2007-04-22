From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_amd: remove contamination added during
 cable_detect conversion
Date: Sun, 22 Apr 2007 18:59:17 +0100
Message-ID: <20070422185917.5fe14e97@the-village.bc.nu>
References: <20070422170438.GK10619@htj.dyndns.org>
	<20070422184037.537ae748@the-village.bc.nu>
	<462BA0A5.2080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47426 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753665AbXDVRzu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:55:50 -0400
In-Reply-To: <462BA0A5.2080900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> I have patches to update pata_amd to use _STM/_GTM for cable detection
> (a lot are taken from pata_acpi) but ACPI cable detection is just as
> broken as PCI config one.

I'm unclear we can safely mix _STM/_GTM and direct access to the drive in
a general form. The ACPI documentation seems to be carefully very silent
on the subject.

Whatever works in this area is good.

Alan
