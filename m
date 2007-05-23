From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Wed, 23 May 2007 14:42:17 +0100
Message-ID: <20070523144217.5abd9fdf@the-village.bc.nu>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	<1179209697.32247.153.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39230 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755063AbXEWNhu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 09:37:50 -0400
In-Reply-To: <1179209697.32247.153.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Tue, 15 May 2007 16:14:57 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> That one is the right one. I think the only diffs vs. the previous
> one that was missing a quilt ref are I wasn't initializing altstatus
> address and I turned some printk's into dev_dbg() as that's really
> what they are.

I'm going to have to NAK this on further review as it will break SRST
handling in some cases. Until ata_bus_softreset has been fixed (see
FIXME: entries) we shouldn't push this patch mainstream, or if we have
then someone should fix the software reset posting as SRST only has an
effect if the timing is honoured.

Alan
