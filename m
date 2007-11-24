From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Sat, 24 Nov 2007 21:50:07 +0100
Message-ID: <200711242150.09812.arnd@arndb.de>
References: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXKXUu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Nov 2007 15:50:27 -0500
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Paul Mundt <lethal@linux-sh.org>

On Friday 23 November 2007, Anton Vorontsov wrote:
> Here is the PATA Platform driver using OF infrastructure.
> 
> Mostly it's just a wrapper around a bit modified pata_platform
> driver.

Thanks a lot for doing this. Patches 2/3 are what I tried to get
people to do for some time now but was too lazy to do myself.

As a further thought, do the drivers now still need to be
pata specific, or should the OF part be called ata_of_platform
instead and also be used for sata devices?

	Arnd <><
