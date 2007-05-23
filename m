From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 00:31:23 +0100
Message-ID: <20070524003123.77b9c81c@the-village.bc.nu>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	<1179209697.32247.153.camel@localhost.localdomain>
	<20070523144217.5abd9fdf@the-village.bc.nu>
	<1179960518.32247.948.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44000 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755631AbXEWX0x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 19:26:53 -0400
In-Reply-To: <1179960518.32247.948.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

> Hrm... so all MMIO drivers (PDC, etc...) are broken you think ? 

If they use the SRST and the chipset does more than tiny amounts of mmio
posting then yes.

> What would be the solution there ? A read to flush the posted write to
> the control register would work in the middle of a soft reset ? If yes,
> what register do you suggest we read ?

Anything non taskfile, which is tricky to do arbitarily for all
controllers - this is why I didn't just stuff in a simple fix and post it.

For BMDMA controllers most of them have a load of other MMIO registers
we can read (eg the SIL680 has the PRD table address you can read
harmlessly), once we get beyond SFF BMDMA however it will be controller
dependant and we probably have to actually specify what register is used
for dummy posting reads when we set up the device. For I/O space we don't
get posting so life is easy.

Jeff ?

Alan
