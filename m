From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 09:43:39 +1000
Message-ID: <1179963820.32247.996.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
	 <1179960518.32247.948.camel@localhost.localdomain>
	 <20070524003123.77b9c81c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46211 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108AbXEWXnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 19:43:52 -0400
In-Reply-To: <20070524003123.77b9c81c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 2007-05-24 at 00:31 +0100, Alan Cox wrote:
> 
> Anything non taskfile, which is tricky to do arbitarily for all
> controllers - this is why I didn't just stuff in a simple fix and post it.

We might have to provide an optional ->flush() that is device specific ?
Config space access would do the job nicely in most cases though. If
it's really only for SRST which can be slow. If it's for the 400ns of
writing the command, then we have a deeper problem but I would expect
MMIO chipsets to be smarter than that ...

> For BMDMA controllers most of them have a load of other MMIO registers
> we can read (eg the SIL680 has the PRD table address you can read
> harmlessly), once we get beyond SFF BMDMA however it will be controller
> dependant and we probably have to actually specify what register is used
> for dummy posting reads when we set up the device. For I/O space we don't
> get posting so life is easy. 

Ah yes, the PRD table pointer is a good option too... We could introduce
a ->flush() and have a default sff version that reads that pointer ?

Cheers,
Ben.


