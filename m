From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACHI: Attempt to enable a single MSI if block enable fails
Date: Tue, 4 Feb 2014 09:40:51 -0700
Message-ID: <CAErSpo5J=dEZjAc8TtS7LgAEa9cxEpzYOC_4Qpe2EhLg_wDX0w@mail.gmail.com>
References: <52EFFE7F.6050807@michaelmarley.com> <20140203204608.GK30250@htj.dyndns.org>
 <20140204060139.GA16513@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:42371 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbaBDQlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Feb 2014 11:41:12 -0500
Received: by mail-oa0-f45.google.com with SMTP id i11so10033193oag.4
        for <linux-ide@vger.kernel.org>; Tue, 04 Feb 2014 08:41:11 -0800 (PST)
In-Reply-To: <20140204060139.GA16513@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michael Marley <michael@michaelmarley.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Feb 3, 2014 at 11:01 PM, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Mon, Feb 03, 2014 at 03:46:08PM -0500, Tejun Heo wrote:
>> cc'ing Alexander.  Alexander, can you please reply with Reviewed-by?
>
> [...]
>
>> >
>> > - --- drivers/ata/ahci.c.orig       2014-02-03 20:00:04.834008843 +0000
>> > +++ drivers/ata/ahci.c      2014-02-03 19:34:53.737257483 +0000
>> > @@ -1171,7 +1171,7 @@ static int ahci_init_interrupts(struct p
>> >     nvec = rc;
>> >     rc = pci_enable_msi_block(pdev, nvec);
>> >     if (rc)
>> > - -         goto intx;
>> > +           goto single_msi;
>> >
>> >     return nvec;
>
> Single MSI should not be tried in case pci_enable_msi_block() returned a
> negative errno. The correct fix is below. Bjorn already has pulled it to
> his pci.git tree, into pci/msi branch.
>
> @Bjorn,
>
> Mind pushing the branch to the remote?

Done; it's now here:
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/msi

I'll probably wait to merge it into -next until I pull in some more of
your MSI patches.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8516f4d..df24eef4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1117,8 +1117,10 @@ int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
>
>         nvec = rc;
>         rc = pci_enable_msi_block(pdev, nvec);
> -       if (rc)
> +       if (rc < 0)
>                 goto intx;
> +       else if (rc > 0)
> +               goto single_msi;
>
>         return nvec;
>
> --
> 1.7.7.6
>
> --
> Regards,
> Alexander Gordeev
> agordeev@redhat.com
