From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Mon, 8 Jan 2007 10:28:09 +0000
Message-ID: <20070108102809.512b4409@localhost.localdomain>
References: <45A19F67.6050909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47331 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161209AbXAHKRc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jan 2007 05:17:32 -0500
In-Reply-To: <45A19F67.6050909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

> If the shared code is tiny, just create a header file and #include it 
> (sata_promise and sata_sx4 do this).  Otherwise, create a shared library 
> module.

pata_sis is both the SiS driver and the shared library. What needs fixing
IMHO is the Kconfig so that the user isn't aware of this. Then all the
CONFIG ifdef stuff goes away too.

Alan
