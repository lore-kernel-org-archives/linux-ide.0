From: linas@austin.ibm.com (Linas Vepstas)
Subject: [PATCHSET] spidernet, sungem_phy: consolidated patch series
Date: Thu, 15 Feb 2007 18:18:57 -0600
Message-ID: <20070216001857.GC923@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <45D3EAA7.80805@garzik.org> <1171525923.20192.243.camel@localhost.localdomain> <200702151141.49708.jens@de.ibm.com> <20070215171414.GU923@austin.ibm.com> <1171572392.5644.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40763 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422829AbXBPATB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 19:19:01 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0J0V3016461
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 19:19:00 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1G0J0w7285184
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 19:19:00 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1G0IwaE004861
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 19:19:00 -0500
Content-Disposition: inline
In-Reply-To: <1171572392.5644.15.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, James K Lewis <jim@jklewis.com>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

On Fri, Feb 16, 2007 at 07:46:32AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I can send a tested patch series (merging all three sources)
> 
> Just send the blast to our list first so I can verify that the
> sungem_phy doesn't adversely affect sungem and everybody 

By "our list", I assume you mean "linuxppc-dev@ozlabs.org". 
I'm going to severely trim the cc list at this point, and 
send a patch series of 12 shortly.  I'm going to pretend
as if I was maintainer (formalities on this side pending)
and attach a "signed-off-by" to each.  Ben, it'll be up to 
you to go/no-go; if you say "go", I'll repost to eff Garzik
(right?)

> (especially Kou
> sine you dn't have the Toshiba hardware, do you ?) can verify it all
> works fine.

I don't have Toshiba hardware. FWIW, I also don't have a ps3. 

--linas
