From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Tue, 4 Dec 2007 14:01:21 -0600
Message-ID: <20071204200121.GA6782@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:51628 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbXLDT5T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:57:19 -0500
Content-Disposition: inline
In-Reply-To: <20071204194921.GB1253@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>

On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
>  	tristate "Generic platform device PATA support"
> -	depends on EMBEDDED || ARCH_RPC
> +	depends on EMBEDDED || ARCH_PPC

It needs to be || PPC, not || ARCH_PPC.


-Olof

