From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in libata-core.c
Date: Thu, 11 Jan 2007 11:17:06 -0600
Message-ID: <20070111171706.GG6177@austin.ibm.com>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp> <200701111008.34866.arnd@arndb.de> <200701110928.l0B9SUri015056@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50816 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXAKRRT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 12:17:19 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0BHHhNE024435
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 12:17:43 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l0BHH9fA224348
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 12:17:09 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0BHH8WP018470
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 12:17:09 -0500
Content-Disposition: inline
In-Reply-To: <200701110928.l0B9SUri015056@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org

On Thu, Jan 11, 2007 at 06:30:55PM +0900, Akira Iguchi wrote:
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

Yes, I agree that it is better to use common functions when possible.

Why is it that other drivers did not need this functions? Did they
copy them?  Or maybe they don't need them?

--linas
