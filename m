From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 18:51:43 +1000
Message-ID: <1214556703.8011.531.camel@pasglop>
References: <1214548895.8011.526.camel@pasglop>
	 <4864A6C9.2050709@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40010 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYF0JCW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 05:02:22 -0400
In-Reply-To: <4864A6C9.2050709@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

On Fri, 2008-06-27 at 12:37 +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> Benjamin Herrenschmidt wrote:
> > The main one is that one their latest cell, they do the following
> > "workarounds" which I never implemented in drivers/ide/ppc/pmac.c b=
ut
> > I'd like to implement in the libata driver, unless you believe that=
 is
> > unnecessary:
> >
> > a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multip=
le of 16
> > bytes, switch to PIO for this command.
> >  =20
>=20
>    No need to do this in old driver anyway since the *IDE* core only=20
> uses DMA for block commands like READ and WRITE.
> Not sure about libata.

It doesn't use DMA to transfer the bulk of ATAPI ? I know it uses PIO
for the CDB but the rest of the transfer isn't done with DMA ?

Ben.


