From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 15:36:44 +0000
Message-ID: <20071130153644.7bf76b4a@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<20071129160555.38ee2edc@the-village.bc.nu>
	<474EE561.7010207@gmail.com>
	<474EE5F8.1030409@gmail.com>
	<474F0B11.7000205@rtr.ca>
	<474F4294.9030203@gmail.com>
	<474F6163.3030500@rtr.ca>
	<474F68B9.2090203@gmail.com>
	<20071130134053.0085a2b4@the-village.bc.nu>
	<47501751.5020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51284 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752944AbXK3PsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 10:48:22 -0500
In-Reply-To: <47501751.5020601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

> Basically, yes but I think it would be nice to be able to change the
> value on the fly.

If you export it then that will "just work". If you want to be able to
set it per device we just need to inherit it at creation time for the
device. 
> 
> > As to the sysfs node for per device setup that makes sense as does fixing
> > the support to allow users to force a mode of their choice, and putting
> > in the geometry fields.
> 
> Yeap.

We need the sysfs for geometry for ATA-1 and pre ATA devices as well
which means we want a way to write to it when we find a device of unknown
geometry we can't start.

