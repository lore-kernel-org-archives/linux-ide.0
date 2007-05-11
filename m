From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_mv hotplug status?
Date: Fri, 11 May 2007 15:16:20 -0400
Message-ID: <4644C104.2010104@garzik.org>
References: <464453A8.9080307@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41357 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030799AbXEKTQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 15:16:26 -0400
In-Reply-To: <464453A8.9080307@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> I'm a little confused about sata_mv hotplug status.
> 
> According to http://linux-ata.org/driver-status.html#marvell, the driver 
> has "full SATA control including hotplug".
> 
> A bit down on that same page, the matrix 
> http://linux-ata.org/driver-status.html#matrix says sata_mv - device 
> hotplug: no.
> 
> Which one is true? I guess the first says about drive hotplug, and the 
> second says about (PCI) device hotplug?

Both are true.

The first discusses HARDWARE capabilities, the second lists SOFTWARE 
implementation features.

	Jeff



