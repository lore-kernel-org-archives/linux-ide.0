From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
Date: Thu, 20 Dec 2007 14:53:46 +1100
Message-ID: <18281.59210.200603.12093@cargo.ozlabs.ibm.com>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204204432.GD8099@lixom.net>
	<4755BD7B.6030208@garzik.org>
	<20071204210344.GE8099@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:42592 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbXLTIe1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2007 03:34:27 -0500
In-Reply-To: <20071204210344.GE8099@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>

Olof Johansson writes:

> > FWIW I'm presuming this work will go via a powerpc tree not libata... 
> > Generally that's not the case, but here it's largely an arch-specific work.
> 
> Ok, that works. I was thinking of letting this patch go through libata,
> and do the removal through the powerpc merge path. But I can do both
> through powerpc.

Are you going to send me a patch to do this addition plus the removal
of the old stuff, or do you want me to merge this patch as is?

Paul.
