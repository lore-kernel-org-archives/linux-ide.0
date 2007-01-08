From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Mon, 08 Jan 2007 07:50:14 -0500
Message-ID: <45A23E06.5020605@garzik.org>
References: <45A19F67.6050909@garzik.org>	<20070108102809.512b4409@localhost.localdomain>	<45A22E9F.1050607@garzik.org> <20070108125116.015da28f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54406 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161275AbXAHMuS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 07:50:18 -0500
In-Reply-To: <20070108125116.015da28f@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

Alan wrote:
> If it was added as a library then the non library driver would look
> contain only a call to register the pci driver and a PCI table. The other
> 7.5K would be waste space. That also means there is no load order issue.

Ok there is no load order issue, but it's still an ugly solution.

Far better would be, then, to combine the drivers into a single ata_sis 
driver, it sounds like.

	Jeff


