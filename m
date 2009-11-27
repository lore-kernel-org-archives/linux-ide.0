From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] pata_piccolo: Driver for old Toshiba chipsets
Date: Fri, 27 Nov 2009 15:34:32 +0000
Message-ID: <20091127153432.42922230@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<20091117145144.15430.55784.stgit@localhost.localdomain>
	<200911271528.09697.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39336 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751484AbZK0Pc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Nov 2009 10:32:29 -0500
In-Reply-To: <200911271528.09697.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > +#define PCI_DEVICE_ID_TOSHIBA_PICCOLO	0x0101
> > +#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_2	0x0102
> > +#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_3	0x0103
> > +#define PCI_DEVICE_ID_TOSHIBA_PICCOLO_5	0x0105
> >  #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
> >  #define PCI_DEVICE_ID_TOSHIBA_TOPIC97	0x060f
> >  #define PCI_DEVICE_ID_TOSHIBA_TOPIC100	0x0617
> 
> This adds kernel regression and breaks kernel build (it is generally good to
> grep kernel tree for the existing users before doing changes like the above):
> 
> drivers/ide/ide-pci-generic.c:
> 
>         { PCI_VDEVICE(TOSHIBA,  PCI_DEVICE_ID_TOSHIBA_PICCOLO),          4 },
>         { PCI_VDEVICE(TOSHIBA,  PCI_DEVICE_ID_TOSHIBA_PICCOLO_1),        4 },
>         { PCI_VDEVICE(TOSHIBA,  PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),        4 },
> 
> Please fix your patch.

Will do - I'll add the missing ones to ide-generic as well.

Alan
