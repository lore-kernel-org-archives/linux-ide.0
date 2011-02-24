From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Thu, 24 Feb 2011 17:53:04 +0000
Message-ID: <20110224175304.669c56d5@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
	<20110223091437.0fb888a2@lxorguk.ukuu.org.uk>
	<201102231128.51910.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36373 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753544Ab1BXRvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 12:51:18 -0500
In-Reply-To: <201102231128.51910.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> +	/* RDC is ICH like */
> +	{ 0x17F3, 0x1011, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +	{ 0x17F3, 0x1012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +

Cable detect is now a bit iffy - probably should add the device vendor to
the table for each if you do this.

Other than that it this specific one could be pretty sensible - but it
does makes the drivers bigger especially on an embedded RDC device.
