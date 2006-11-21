From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/ide: PATA driver for Celleb
Date: Tue, 21 Nov 2006 11:49:53 +0000
Message-ID: <20061121114953.1443e7a1@localhost.localdomain>
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47527 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030561AbWKULoH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 06:44:07 -0500
In-Reply-To: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

> We use a drivers/ide driver because its design is more suitable for
> SCC IDE controller than libata driver. Since SCC supports only 32bit

Understand that drivers/ide will be going away at some point long term
but not for a while.

> read/write, we must override many callbacks of ata_port_operations
> by modifying generic helpers. Each time the libata common code is
> updated, we must update those modified helpers. It is very hard for us.
> But we will try to implement the libata driver as needed.

It would be good to do so - the future is libata. It may also help because
it may indicate places were libata not your code should change in order to
get a nicer interface.


> +/* PIO transfer mode  table */
> +/* JCHST */
> +static unsigned long JCHSTtbl[2][7] = {

const...

> +	switch (speed) {
> +	case XFER_UDMA_6:
> +		idx = 6;
> +		break;

These values are carefully arranged so you can do

	if (speed >= XFER_UDMA_0)
		idx = speed - XFER_UDMA_0;
	else
		return 1;


Otherwise looks ready to merge.

Alan
