From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
Date: Tue, 4 Dec 2007 15:03:44 -0600
Message-ID: <20071204210344.GE8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204204432.GD8099@lixom.net> <4755BD7B.6030208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:39620 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbXLDU7l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:59:41 -0500
Content-Disposition: inline
In-Reply-To: <4755BD7B.6030208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>

On Tue, Dec 04, 2007 at 03:50:03PM -0500, Jeff Garzik wrote:
> Olof Johansson wrote:
>> [POWERPC] Move electra-ide support over to new pata_of_platform framework
>> Move electra-ide glue over to the new pata_of_platform framework, and
>> add the quirks needed to that driver.
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> I'll remove the electra-ide stuff from arch/powerpc/platforms/pasemi
>> once this hits a common tree, since otherwise I'd be without IDE until
>> they converge (i.e.  2.6.25 merge window).
>
> FWIW I'm presuming this work will go via a powerpc tree not libata... 
> Generally that's not the case, but here it's largely an arch-specific work.

Ok, that works. I was thinking of letting this patch go through libata,
and do the removal through the powerpc merge path. But I can do both
through powerpc.

-Olof
