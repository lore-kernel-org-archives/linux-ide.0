From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Sat, 14 Nov 2009 00:03:29 +0000
Message-ID: <20091114000329.5d224cdc@lxorguk.ukuu.org.uk>
References: <4AFCC0D4.9020708@gmail.com>
	<200911132317.35088.bzolnier@gmail.com>
	<20091113224251.766c7910@lxorguk.ukuu.org.uk>
	<200911132358.45137.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42690 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932504AbZKNABg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 19:01:36 -0500
In-Reply-To: <200911132358.45137.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, 13 Nov 2009 23:58:45 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Friday 13 November 2009 23:42:51 Alan Cox wrote:
> > 
> > > 	http://article.gmane.org/gmane.linux.ide/43136
> > > 
> > > [ it has still unfixed problems.. ]
> > 
> > Which of course you haven't bothered to point out or explain.
> 
> I meant problems reported by Mikulas:
> 
> 	http://thread.gmane.org/gmane.linux.ide/43069/focus=43136
> 
> Maybe they were fixed in your local tree but how would anyone know that given
> that there haven't been any updates on the problem for the last two weeks..

Yeah its fixed - well I think so. I've not chased it up further yet
because I've been working on far more important things than an anicent IDE
controller patch that isn't an -rc candidate anyway.

(basically you need to also set priv->dma_live if you are the only device
or nothing is live but doing DMA)

Alan
