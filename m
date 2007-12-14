From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Fri, 14 Dec 2007 10:09:28 -0600
Message-ID: <20071214160928.GA16607@ld0162-tx32.am.freescale.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net> <20071205004841.GA25905@linux-sh.org> <20071205183912.GA4516@loki.buserror.net> <20071214082313.GA28118@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56526 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbXLNQKQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 11:10:16 -0500
Content-Disposition: inline
In-Reply-To: <20071214082313.GA28118@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org

On Fri, Dec 14, 2007 at 02:23:13AM -0600, Olof Johansson wrote:
> On Wed, Dec 05, 2007 at 12:39:12PM -0600, Scott Wood wrote:
> > Why is it dependent on anything other than platform bus support and ATA?
> 
> There's no way to specify dependency on platform bus as a config option,
> that's likely what EMBEDDED was meant to do. Some platforms have platform
> bus in spite of being !EMBEDDED, arch/arm/configs/rpc_defconfig seems
> to be among those. PPC too.

If platform bus can't be configged out, then the only dependency should
be the implicit one on ATA (is there anything else whose absence will
stop the code from building, or working if the appropriate platform
device is passed in?).

-Scott
