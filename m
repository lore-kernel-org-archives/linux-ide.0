From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [linux-2.6.git] IDE/ATA fighting over driver name?
Date: Sat, 13 Oct 2007 06:51:06 -0400
Message-ID: <4710A31A.7020204@garzik.org>
References: <1192254081.29452.13.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33924 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbXJMKvJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Oct 2007 06:51:09 -0400
In-Reply-To: <1192254081.29452.13.camel@Homer.simpson.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mike Galbraith wrote:
> Greetings,
> 
> Perhaps my .config is dainbramaged.  When make oldconfig asked me if I
> wanted CONFIG_PATA_PLATFORM, I said "Damned if I know, go for it".
> 
> drivers/ide/legacy/ide_platform.c:		.name = "pata_platform",
> drivers/ata/pata_platform.c:#define DRV_NAME "pata_platform"

That's a clear bug..  IDE's should be called ide_platform.

	Jeff


