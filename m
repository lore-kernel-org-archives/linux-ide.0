From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Date: Fri, 12 Jan 2007 08:37:12 +1100
Message-ID: <1168551432.22458.421.camel@localhost.localdomain>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	 <200701111008.34866.arnd@arndb.de>
	 <200701110928.l0B9SUUv028654@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35254 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXAKVh2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 16:37:28 -0500
In-Reply-To: <200701110928.l0B9SUUv028654@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, paulus@samba.org

On Thu, 2007-01-11 at 18:30 +0900, Akira Iguchi wrote:
> Hi, Arnd-san.
> 
> Thank you for checking our patches.
> 
> >On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
> >> This patch modifies some static functions in libata-core.c
> >> and libata.h to use them in ata_scc.c.
> >
> >Exporting new symbols needs some explanation here about why they
> >should now be global for ata_scc while the existing drivers
> >did not need them. Since the patch otherwise only moves stuff
> >around as needed, I assume it's good.
> 
> I thought it was better to use common functions as far as possible.
> But if it is preferable to copy them in ata_scc.c, I will do so.

Nah, it's not preferable. I think what is preferable on the contrary is
to make even more common function generic enough so you can use them
instead of copying them.

Ben.


