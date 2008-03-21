From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 21 Mar 2008 10:42:37 +0000
Message-ID: <20080321104237.72379e41@core>
References: <217535.99274.qm@web34505.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41605 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754031AbYCUK6F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 06:58:05 -0400
In-Reply-To: <217535.99274.qm@web34505.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: osb972ww-linuxczmil@yahoo.com
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, 20 Mar 2008 20:04:13 -0700 (PDT)
osb972ww-linuxczmil@yahoo.com wrote:

> 
> HI Tejun,
> 
>   setting irqpoll fixed both problems, and there are no "nasty grams" in dmesg now.   The original reason I was trying to use the hdparm -u on /dev/sda was because it was hanging for a few seconds when doing writes to the CFdisk, and in the past that was the kind of thing that hdparm -u would generally fix.   Now with the irqpoll kernel option, the /dev/sdb SATA drive was found, and I can mount it and write to it.  The CFcard /dev/sda is also responding to writes better than before.
> 
> Thanks for the suggestion to use irqpoll.    What is the problem within the driver(s) that is requiring irqpoll. ?

irqpoll works around BIOS bugs not driver bugs (well generally speaking
anyway).

Alan
