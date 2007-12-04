From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/4] [libata] pata_platform: make probe and remove
	functions device type neutral
Date: Tue, 4 Dec 2007 14:40:59 -0600
Message-ID: <20071204204059.GC8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170625.GA15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:47036 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbXLDUg5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:36:57 -0500
Content-Disposition: inline
In-Reply-To: <20071204170625.GA15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

On Tue, Dec 04, 2007 at 08:06:25PM +0300, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Olof Johansson <olof@lixom.net>

Tested with both the old pata_platform and new pata_of_platform drivers on
PA Semi Electra (see separate post with pata_of_platform cutover patch).


-Olof

