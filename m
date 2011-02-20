From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/20] ata_piix: unify code for programming PIO and
 MWDMA timings
Date: Sun, 20 Feb 2011 18:59:58 +0000
Message-ID: <20110220185958.364df4cc@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122346.19110.8441.sendpatchset@linux-mhg7.site>
	<4D6118DC.80505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54911 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754576Ab1BTS6i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2011 13:58:38 -0500
In-Reply-To: <4D6118DC.80505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > +	if (ata_pio_need_iordy(adev) || use_mwdma)
> >   		control |= 2;	/* IE enable */
> 
>     Why IORDY is enabled for MWDMA has always been beyond me... I understand 
> that the stupid Intel docs are to be blamed here.

I fail to see whats stupid about the docs ?

The same timing register set is used for MWDMA and PIO cycles in MWDMA
tuned modes (eg ATAPI). Thus the controller needs to be in an MWDMA mode
whose timings are compatible with the PIO timing and we want IORDY in use
for the PIO transfer parts.

Alan
