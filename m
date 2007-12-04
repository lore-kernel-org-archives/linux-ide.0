From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_of_platform: Move electra-ide support over to new
 framework
Date: Tue, 04 Dec 2007 15:50:03 -0500
Message-ID: <4755BD7B.6030208@garzik.org>
References: <20071204170442.GA10460@localhost.localdomain> <20071204204432.GD8099@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36064 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbXLDUuP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:50:15 -0500
In-Reply-To: <20071204204432.GD8099@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>

Olof Johansson wrote:
> [POWERPC] Move electra-ide support over to new pata_of_platform framework
> 
> Move electra-ide glue over to the new pata_of_platform framework, and
> add the quirks needed to that driver.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> I'll remove the electra-ide stuff from arch/powerpc/platforms/pasemi
> once this hits a common tree, since otherwise I'd be without IDE until
> they converge (i.e.  2.6.25 merge window).

FWIW I'm presuming this work will go via a powerpc tree not libata... 
Generally that's not the case, but here it's largely an arch-specific work.

	Jeff



