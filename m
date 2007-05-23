From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 08:48:38 +1000
Message-ID: <1179960518.32247.948.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58418 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757316AbXEWWtq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 18:49:46 -0400
In-Reply-To: <20070523144217.5abd9fdf@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Wed, 2007-05-23 at 14:42 +0100, Alan Cox wrote:

> I'm going to have to NAK this on further review as it will break SRST
> handling in some cases. Until ata_bus_softreset has been fixed (see
> FIXME: entries) we shouldn't push this patch mainstream, or if we have
> then someone should fix the software reset posting as SRST only has an
> effect if the timing is honoured. 

Hrm... so all MMIO drivers (PDC, etc...) are broken you think ? 

What would be the solution there ? A read to flush the posted write to
the control register would work in the middle of a soft reset ? If yes,
what register do you suggest we read ?

Ben.


