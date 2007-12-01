From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Date: Sat, 01 Dec 2007 17:54:49 -0500
Message-ID: <4751E639.8090308@garzik.org>
References: <20071127153708.GA12490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46833 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbXLAWy5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:54:57 -0500
In-Reply-To: <20071127153708.GA12490@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Vitaly Bordug <vitb@kernel.crashing.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Anton Vorontsov wrote:
> Hi all,
> 
> Here is the second spin of the OF-platform PATA driver and
> related patches.
> 
> Changes since RFC:
> - nuked drivers/ata/pata_platform.h;
> - powerpc bits: proper localbus node added.
> 
> 
> Thanks for the previous review! This time I'm collecting acks,
> don't be shy to give 'em generously. ;-)

if (ack_collected(PaulM))
	push(ACK)
else {
	/* do nothing */
}




