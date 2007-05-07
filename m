From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 7 May 2007 12:18:45 +0100
Message-ID: <20070507121845.5d7cd1f8@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42905 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932526AbXEGLOw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 07:14:52 -0400
In-Reply-To: <463ED8B9.4060501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> Yeap, this is how IDE deals with polling commands but I'm not sure how
> it's supposed to work with PCI IRQ sharing.  Bartlomiej, can you
> enlighten me here?

Simple answer: Badly. If you've got the IRQ shared it mucks up the
behaviour of the other device especially when its doing PIO.

