From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 8 May 2007 13:43:03 +0100
Message-ID: <20070508134303.57f95d63@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
	<20070508132046.70a4d9ed@the-village.bc.nu>
	<46406C9A.4000802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51603 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934430AbXEHMjR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:39:17 -0400
In-Reply-To: <46406C9A.4000802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> One thing I'm worried about is that somehow I'm thinking there are
> controllers/devices out there which choke if there PIO data transfer is
> interrupted (timing-wise).  Is this something I just imagined up?

There are a couple of problem controllers. They use the
ata_data_xfer_noirq method for ->data_xfer() which blocks local
interrupts in the method itself and in those cases we have no choice. Such
chips are all ancient thankfully.

Alan
