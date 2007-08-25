From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: readXs on pci*iomap-ped regions [Was: [PATCH] /drivers/char sx.c
 ioremap -> pci_ioremap api]
Date: Sat, 25 Aug 2007 04:56:19 -0400
Message-ID: <46CFEEB3.6000802@pobox.com>
References: <46CF2849.2090008@gmail.com> <4af2d03a0708241159v56b46299h46df9777a98590e5@mail.gmail.com> <20070824201530.5d741b37@the-village.bc.nu>	<46CF399E.3010808@gmail.com> <20070824213439.0007e653@the-village.bc.nu> <46CFEC40.7060006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53461 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764603AbXHYI4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Aug 2007 04:56:25 -0400
In-Reply-To: <46CFEC40.7060006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

If the driver knows its MMIO, using readX/writeX after pci_iomap() is 
just fine, for all current implementations, and it makes sense that way.

	Jeff



