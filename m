From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 13:17:57 +0200
Message-ID: <82c4101a83362d2ce78713a70df535d4@kernel.crashing.org>
References: <20070512145041.GA13025@lixom.net> <200705130111.03153.arnd@arndb.de> <20070513005830.38ba8e3b@the-village.bc.nu> <200705130248.22844.arnd@arndb.de> <1179022810.32247.54.camel@localhost.localdomain> <20070513061954.GA16623@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:33236 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757358AbXEMLSv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 07:18:51 -0400
In-Reply-To: <20070513061954.GA16623@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Also, in this particular case, the bindings are not standardized, and
> there's a good chance that whatever new platform uses a similar device
> will need to do something slightly different.

Yeah, everyone else will do the sane thing, and describe
the two register ranges the IDE uses, not a much bigger
range full of register shadows like you have.  It is one
thing for the hardware to do partial address decoding;
the device tree shouldn't normally expose this though.

But that's what you've got now, so you have your own
special OF device matching code, which is exactly as it
should be.  No need to have "generic" ide OF matching
code until device trees containing such devices show
up :-)


Segher

