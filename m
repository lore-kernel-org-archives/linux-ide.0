From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.29-rc libata sff 32bit PIO regression
Date: Wed, 21 Jan 2009 21:47:46 +0000
Message-ID: <20090121214746.2b15d1de@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0901211322010.15945@blonde.anvils>
	<18807.33113.550070.329912@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49078 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752856AbZAUVsa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2009 16:48:30 -0500
In-Reply-To: <18807.33113.550070.329912@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Hugh Dickins <hugh@veritas.com>, Jeff Garzik <jgarzik@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 21 Jan 2009 21:11:05 +0100
Mikael Pettersson <mikpe@it.uu.se> wrote:

> Hugh Dickins writes:
>  > I've a Dell Precision 670 here (four-year-old EM64T Xeon with ata_piix)
>  > which doesn't like your commit 871af1210f13966ab911ed2166e4ab2ce775b99d
>  > libata: Add 32bit PIO support.  Full dmesg (and .config) attached, but
>  > here's an extract showing the start of the error messages on ata2:

Cool - so we need two different 32bit PIO methods - at least according to
the docs for the AMD we should use entirely 32bit I/O there. Fun fun


Alan
