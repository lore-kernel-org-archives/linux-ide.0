From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 18:01:50 +1000
Message-ID: <1179043310.32247.58.camel@localhost.localdomain>
References: <20070512145041.GA13025@lixom.net>
	 <200705130111.03153.arnd@arndb.de>
	 <20070513005830.38ba8e3b@the-village.bc.nu>
	 <200705130248.22844.arnd@arndb.de>
	 <1179022810.32247.54.camel@localhost.localdomain>
	 <20070513061954.GA16623@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40484 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbXEMICJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 May 2007 04:02:09 -0400
In-Reply-To: <20070513061954.GA16623@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, paulus@samba.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


> Great. That should fit perfectly with the glue I have now, it'll turn
> into the constructor instead.
> 
> I honestly don't see what the benefit is of this recent obsession
> with creating of_platform devices for every new device that's not
> PCI, especially when there's an already well-fitting driver in the
> traditional platform model. It's not like the code to link the two is
> large and complex.

I agree.

> Also, in this particular case, the bindings are not standardized, and
> there's a good chance that whatever new platform uses a similar device
> will need to do something slightly different.

Yup.

Ben.


