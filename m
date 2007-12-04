From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and
	pata nodes
Date: Tue, 4 Dec 2007 14:40:11 -0600
Message-ID: <20071204204011.GB8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170726.GC15599@localhost.localdomain> <20071204191657.GB5758@lixom.net> <20071204194531.GA1253@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:47016 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXLDUgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:36:08 -0500
Content-Disposition: inline
In-Reply-To: <20071204194531.GA1253@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>

On Tue, Dec 04, 2007 at 10:45:31PM +0300, Anton Vorontsov wrote:
> This patch adds localbus and pata nodes to use CF IDE interface
> on MPC8349E-mITX boards.
> 
> Patch also adds code to probe localbus.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
