From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 13:09:38 +0000
Message-ID: <20071130130938.0e3abd94@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<20071129160555.38ee2edc@the-village.bc.nu>
	<474EE561.7010207@gmail.com>
	<474EE5F8.1030409@gmail.com>
	<474F0B11.7000205@rtr.ca>
	<474F4294.9030203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41847 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758196AbXK3NNy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 08:13:54 -0500
In-Reply-To: <474F4294.9030203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

> One thing I don't understand about this argument is that PIO cycle time
> is not determined by CPU power.  It's bound by PCI and ATA bus speed.
> If you put a faster CPU on the job, it just ends up wasting the same
> amount of time burning up more CPU cycles or am I misjudging power of
> those embedded CPUs?

The faster your CPU the more processor cycles you have between ATA stalls
to do the work. You also probably have hypedthreading which will help a
bit as you'll stall half the CPU not all of it some of the time at least.

