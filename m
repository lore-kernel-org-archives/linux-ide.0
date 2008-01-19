From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pdc2026x: remove surplus initialiser
Date: Sat, 19 Jan 2008 20:00:59 +0000
Message-ID: <20080119200059.7484baea@lxorguk.ukuu.org.uk>
References: <20080119155525.0d361552@lxorguk.ukuu.org.uk>
	<47922B2B.5010807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57674 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751441AbYASUC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 15:02:57 -0500
In-Reply-To: <47922B2B.5010807@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Sat, 19 Jan 2008 19:54:03 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Alan Cox wrote:
> 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c
> > --- linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 14:47:56.000000000 +0000
> > +++ linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 15:00:08.000000000 +0000
> > @@ -138,7 +138,7 @@
> >  static u8 __devinit pdc2026x_old_cable_detect(ide_hwif_t *hwif)
> >  {
> >  	struct pci_dev *dev = to_pci_dev(hwif->dev);
> > -	u16 CIS = 0, mask = (hwif->channel) ? (1<<11) : (1<<10);
> > +	u16 CIS, mask = (hwif->channel) ? (1<<11) : (1<<10);
> >  
> >  	pci_read_config_word(dev, 0x50, &CIS);
> 
>     Since we ignore the result of this function, if it fails CIS may be left 
> uninitialized if the function fails. So, the initializer is not as useless as 
> it seems (and there's a lot more of such cases in drivers/ide/pci/ :-)..

If pci_read_config_word fails you are in very deep doodoo anyway. I don't
think anyone checks it because there isn't an answer to "now what"

Alan
