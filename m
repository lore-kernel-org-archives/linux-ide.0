From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Wed, 13 Oct 2004 22:16:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101313161223717f@mail.gmail.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com>
	 <58cb370e04101312321c78f3b8@mail.gmail.com>
	 <416D88FA.1050200@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.207]:61924 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269789AbUJMUQg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Oct 2004 16:16:36 -0400
Received: by mproxy.gmail.com with SMTP id 77so16750rnk
        for <linux-ide@vger.kernel.org>; Wed, 13 Oct 2004 13:16:35 -0700 (PDT)
In-Reply-To: <416D88FA.1050200@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>

On Wed, 13 Oct 2004 15:58:50 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

> >>My question is, in the current kernel, the IDE subsystem drives PATA chips
> >>and libata drives SATA chips. Will PATA driver like this be accepted into
> >>libata?
> >
> >
> > My opinion is: yes but not now, final answer is of course left to Jeff.
> 
> With the progress currently being made, I think my preference would be
> to start collecting PATA drivers such this in my libata-dev queue.
> 
> I would not send these PATA drivers upstream until the PATA to-do items
> are complete (see other email), but it would be nice to have a central
> location (both BK and patch on kernel.org) for developers and users to
> mess with PATA support.

I was going to start libata-pata-2.6 (from libata-dev-2.6)
but this sounds even better :)

and lets ignore /dev/hda vs /dev/sda issue completely
for now in hope that udev will fix this for us etc. :)

> My own comments:
> 
> >> obj-$(CONFIG_SCSI_ATA_PIIX) += libata.o ata_piix.o
> >>> +obj-$(CONFIG_SCSI_PATA_PDC_NEW) += libata.o pata_pdc202xx_new.o
> >
> >
> > why not jus pata_pdc_new? or pata_pdc_27x?
> 
> I would prefer to eliminate the "_new" suffix.  Other than that I don't
> really care.  If I had written the driver, I would have named it
> pata_pdc202xx I suppose.

There is a high chance that somebody will also port
pdc202xx_old driver to libata so pata_pdc202xx will
be confusing.
