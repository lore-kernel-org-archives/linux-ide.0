From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pdc2026x: remove surplus initialiser
Date: Tue, 22 Jan 2008 00:13:39 +0100
Message-ID: <200801220013.40027.bzolnier@gmail.com>
References: <20080119155525.0d361552@lxorguk.ukuu.org.uk> <47922B2B.5010807@ru.mvista.com> <20080119200059.7484baea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:19050 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYAUXBL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:01:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so973156ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:01:07 -0800 (PST)
In-Reply-To: <20080119200059.7484baea@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Saturday 19 January 2008, Alan Cox wrote:
> On Sat, 19 Jan 2008 19:54:03 +0300
> Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> > Hello.
> > 
> > Alan Cox wrote:
> > 
> > > Signed-off-by: Alan Cox <alan@redhat.com>
> > 
> > > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c
> > > --- linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 14:47:56.000000000 +0000
> > > +++ linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 15:00:08.000000000 +0000
> > > @@ -138,7 +138,7 @@
> > >  static u8 __devinit pdc2026x_old_cable_detect(ide_hwif_t *hwif)
> > >  {
> > >  	struct pci_dev *dev = to_pci_dev(hwif->dev);
> > > -	u16 CIS = 0, mask = (hwif->channel) ? (1<<11) : (1<<10);
> > > +	u16 CIS, mask = (hwif->channel) ? (1<<11) : (1<<10);
> > >  
> > >  	pci_read_config_word(dev, 0x50, &CIS);
> > 
> >     Since we ignore the result of this function, if it fails CIS may be left 
> > uninitialized if the function fails. So, the initializer is not as useless as 

pci_[bus]_read_config_*() functions always assign some value according to
drivers/pci/access.c (except for unaligned access to word/dword register).

> > it seems (and there's a lot more of such cases in drivers/ide/pci/ :-)..

A lot of "patch" opportunities!

> If pci_read_config_word fails you are in very deep doodoo anyway. I don't
> think anyone checks it because there isn't an answer to "now what"

Yep, moreover we cannot just assume that "0" is a safe default value
because it doesn't have to be (i.e. in the above case cable bit set to
"0" means 80-wires cable).

Thanks,
Bart
