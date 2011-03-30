From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to the right address.
Date: Wed, 30 Mar 2011 22:37:32 +0200
Message-ID: <201103302237.32286.arnd@arndb.de>
References: <4D937FDC.4090607@danielpalmer.co.uk> <201103302200.47052.arnd@arndb.de> <4D93917F.6090309@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52820 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979Ab1C3Uhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 16:37:41 -0400
In-Reply-To: <4D93917F.6090309@danielpalmer.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 30 March 2011 22:24:31 Daniel Palmer wrote:
> > Is this an ARM machine? The platform specific mach/io.h header
> 
> Sorry, I should have mentioned it more explicitly.
> The machine is an SH4 based (The processor model is SH7751R, board is 
> landisk.. in /arch/sh/include/mach-landisk/).
> 

Ok, in that case, you should look at how arch/sh/kernel/ioport.c
handles this. You probably just need to call __set_io_port_base().

	Arnd
