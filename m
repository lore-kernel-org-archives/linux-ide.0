From: philby john <pjohn@mvista.com>
Subject: Re: [PATCH] sil3531: has no PM capability, remove support.
Date: Mon, 09 Apr 2012 20:37:30 +0530
Message-ID: <1333984050.12301.1.camel@localhost.localdomain>
References: <1333980849.11209.5.camel@localhost.localdomain>
	 <4F82F765.4010705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64638 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab2DIPGk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2012 11:06:40 -0400
Received: by bkcik5 with SMTP id ik5so3445147bkc.19
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2012 08:06:39 -0700 (PDT)
In-Reply-To: <4F82F765.4010705@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

On Mo, 2012-04-09 at 10:51 -0400, Jeff Garzik wrote:
> On 04/09/2012 10:14 AM, philby john wrote:
> > From: Philby John<pjohn@mvista.com>
> > Date: Mon, 9 Apr 2012 19:09:51 +0530
> > Subject: [PATCH] sil3531: has no PM capability, remove support.
> >
> > SATA sil3531 does not support Power Management Capability and
> > as per the manual Bit [31:27] is hardwired to 00h.
> > Otherwise, when the device goes into suspend/resume the Power
> > Management Control + Status registers are accessed and the
> > arch specific readl()/__raw_readl() calls block indefinitely.
> >
> > This patch sets the PCI_DEV_FLAGS_NO_D3 flag by which the if
> > condition in pci_set_power_state() evaluates to true and
> > pci_raw_set_power_state() functions are not executed.
> >
> > Signed-off-by: Philby John<pjohn@mvista.com>
> > Signed-off-by: Johnny Chiang<Johnny.Chiang@caviumnetworks.com>
> > ---
> >   drivers/pci/pci.c |    1 +
> >   1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8156744..129120d 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1863,6 +1863,7 @@ void pci_pm_init(struct pci_dev *dev)
> >   		pci_pme_active(dev, false);
> >   	} else {
> >   		dev->pme_support = 0;
> > +		dev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> 
> This patch applies to -every- piece of PCI hardware out there, not just 
> the sil3531...
> 

But if pme_support is zero, isn't it ok to set dev_flags to
PCI_DEV_FLAGS_NO_D3 ?

Regards,
Philby


