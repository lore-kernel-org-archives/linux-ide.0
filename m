From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20-rc3-mm1 2/2] libata: SiS 180 pata/sata support
Date: Mon, 08 Jan 2007 06:44:31 -0500
Message-ID: <45A22E9F.1050607@garzik.org>
References: <45A19F67.6050909@garzik.org> <20070108102809.512b4409@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54110 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbXAHLof (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 06:44:35 -0500
In-Reply-To: <20070108102809.512b4409@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>, Sven Ladegast <sven@linux4geeks.de>

Alan wrote:
>> If the shared code is tiny, just create a header file and #include it 
>> (sata_promise and sata_sx4 do this).  Otherwise, create a shared library 
>> module.
> 
> pata_sis is both the SiS driver and the shared library. What needs fixing

It is /very/ bad policy to force the user to load a driver that drives 
real hardware, just to be able to access a few functions.  Hardware and 
probe side effects are a very real possibility, and with this setup, the 
user has /less/ control than normal over things such as load order when 
pata_sis is loaded as a dependency.

If the duplicated code in question is small, just putting it in a header 
file a la drivers/ata/sata_promise.h is fine.  Otherwise, a library 
approach with no side effects should be chosen.

	Jeff



