From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: sata_via: write errors on PATA drive connected to VT6421
Date: Tue, 21 Aug 2007 19:09:30 +0200
Message-ID: <200708211909.30652.linux@rainbow-software.org>
References: <200708202242.07290.linux@rainbow-software.org> <20070821132731.6bf10b50@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:37631 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576AbXHURJU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Aug 2007 13:09:20 -0400
In-Reply-To: <20070821132731.6bf10b50@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 21 August 2007 14:27:31 Alan Cox wrote:
> > The transfer mode decreases from UDMA/100 to UDMA/66 and then UDMA/33 but
> > it doesn't help at all. The drive itself is fine, the problems also
> > appear with
>
> Does it settle at UDMA33 or keep going down lower ?

It does not go below UDMA33. 
dd if=/dev/zero of=some.file bs=131072 count=1024 takes 526 seconds (amazing 
transfer rate 255KB/s) with system being unresponsive most of the time.

Commenting out the UDMA support in sata_via.c (.udma_mask and .set_dmamode for 
PATA port) causes the driver to run in PIO4 mode which seems to work without 
errors but slowly (3MB/s with 100% CPU load).

-- 
Ondrej Zary
