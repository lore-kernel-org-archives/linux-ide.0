From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 16:03:41 +0200
Message-ID: <58cb370e0710250703y341da713x33afa3d82f24fbd2@mail.gmail.com>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
	 <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net>
	 <200710251406.05804.bzolnier@gmail.com>
	 <200710251411.42546.bzolnier@gmail.com> <47208DAC.1000207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:42128 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbXJYODn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 10:03:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so491849nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 07:03:42 -0700 (PDT)
In-Reply-To: <47208DAC.1000207@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew <andrew@nelless.net>, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

On 10/25/07, Jeff Garzik <jeff@garzik.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > @@ -2379,9 +2379,13 @@ static int nv_init_one (struct pci_dev *
> >       if (type == CK804 && adma_enabled) {
> >               dev_printk(KERN_NOTICE, &pdev->dev, "Using ADMA mode\n");
> >               type = ADMA;
> > +     } else if (type == GENERIC && swncq_enabled) {
> > +             dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n");
> > +             type = SWNCQ;
> >       }
> >
>
>
> If we want to start putting PCI_ANY_ID entries in the pci_device_id
> table (as other NVIDIA patches have proposed), I don't think it's safe
> to assume that all devices marked GENERIC can do SWNCQ, while it should
> be safe to fall back from SWNCQ to GENERIC.  GENERIC is the selection
> being considered for use as being compatible with future chips.

This is up to nVidia people and may as well be dealt with in the future
patches.  The only goal of this patch was to fix "a showstopper bug".

> But overall both patches look straightforward...

Thanks,
Bart
