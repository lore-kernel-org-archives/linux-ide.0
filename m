From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.29-rc libata sff 32bit PIO regression
Date: Wed, 21 Jan 2009 22:58:08 +0000
Message-ID: <20090121225808.1f5ffac1@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0901211322010.15945@blonde.anvils>
	<18807.33113.550070.329912@harpo.it.uu.se>
	<20090121214746.2b15d1de@lxorguk.ukuu.org.uk>
	<4977A6E5.6080506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52584 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752568AbZAUXMV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 18:12:21 -0500
In-Reply-To: <4977A6E5.6080506@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Hugh Dickins <hugh@veritas.com>, Jeff Garzik <jgarzik@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 22 Jan 2009 01:51:17 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Alan Cox wrote:
> 
> >> Hugh Dickins writes:
> >>  > I've a Dell Precision 670 here (four-year-old EM64T Xeon with ata_piix)
> >>  > which doesn't like your commit 871af1210f13966ab911ed2166e4ab2ce775b99d
> >>  > libata: Add 32bit PIO support.  Full dmesg (and .config) attached, but
> >>  > here's an extract showing the start of the error messages on ata2:
> >>     
> >
> > Cool - so we need two different 32bit PIO methods - at least according to
> > the docs for the AMD we should use entirely 32bit I/O there. Fun fun
> >   
> 
>    Could you refer me to the exact AMD doc that requires that?

AMD762 page 82, under DevB:1x40 bit 14 and bit 12

"Note: only 32-bit writes to the data port are allowed when this bit is
set."

