Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AEBC432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4593B60F11
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 09:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhIAJLH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241783AbhIAJLG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 05:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630487409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fm8zGk2Bjo/Hj4tDG7GzsmpjVti6KgzDI6tcDiq78i4=;
        b=VI8GqL9aOsCAFiKNyaVjzfPb+J0hH48s//VxSdditf8GaO/mflbMkOPrPPZtH8SEo7lxJk
        H1MrA9uMmQsAORP1zzTT+TbIaz4CIkNNgxdlbEWJbWvtiuSZCyh+OEFJPbSUYKA/eYZY8g
        g96QrdTTGl1RqcICnAJzHGsKqrky+WA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-QHOCemXoODqgTfKZLWSYjg-1; Wed, 01 Sep 2021 05:10:08 -0400
X-MC-Unique: QHOCemXoODqgTfKZLWSYjg-1
Received: by mail-lf1-f71.google.com with SMTP id q18-20020a05651232b200b003d9019c6ae4so783156lfe.22
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2021 02:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fm8zGk2Bjo/Hj4tDG7GzsmpjVti6KgzDI6tcDiq78i4=;
        b=rQDh3Z/t6E1ne2kZH12Zb9IpXRn7Engxj3qzuGfJGmhWWIZmuwlBW69Ce8ZpQvS6Ui
         w9Gpnnj+hAfMttEe9JyGmHO++uocs0IIP49KLsBEORx17RJHsITtTIk2StflWJZINAn0
         hk1kEwHbmENDua3scHfq0TkEzbDNTJ8fscJHWuIxG9VAWx+fvD0ItEUIAUjTf4BwtN4y
         65lCMJ3me5h2c/b+WkF2GCUKLe0s3H1+P7EdL50ZbAlETYswH3/Ijnuyqss9J5+DXk1N
         69iOo6AmWamS7D5M7hQn+7o/1m+/GvjCXpM9KB7KCcAuQv3FiNG5My2YSU7Oq024przt
         VjfQ==
X-Gm-Message-State: AOAM530n3f3S1VjQg7XLUdkCK2xxgG4Zv6H7jYhmVDfL2SsGj7h2iEDu
        pzkEPYaR7Hb8Gtcf5zSQd1T/3eLCHhFUxiIqg9xdHf7ZdZ2tzScm8iMr+vFRay6eyDxbbap72Bg
        OAB7erUc35PYhQMTjgwn3fYOfdLdIq53VMpJs
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr29324956ljk.265.1630487406956;
        Wed, 01 Sep 2021 02:10:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1R3dV5nbsPewj+ZaftCmOx8hGhvHTBUmT/Z8BuAhj6nOTUqU9LAoCrQ3IENgib2/ZsRiBJ/pZL3J41nGtbE4=
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr29324935ljk.265.1630487406621;
 Wed, 01 Sep 2021 02:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210901045220.27746-1-hpa@redhat.com> <f923a8d9-4da5-7e66-55fd-7c07cfc9fccf@redhat.com>
In-Reply-To: <f923a8d9-4da5-7e66-55fd-7c07cfc9fccf@redhat.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Wed, 1 Sep 2021 17:09:55 +0800
Message-ID: <CAEth8oEDTajqHmpf-QKQktndf5UBVzaAnS46zNyn-b6G3HQHUg@mail.gmail.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvic9@mailbox.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Hans,

On Wed, Sep 1, 2021 at 5:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kate,
>
> On 9/1/21 6:52 AM, Kate Hsuan wrote:
> > Many users are reporting that the Samsung 860 and 870 SSD are having
> > various issues when combined with AMD SATA controllers and only
> > completely disabling NCQ helps to avoid these issues.
> >
> > Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
> > SATA adapter vendor will cause I/O performance degradation with well
> > behaved adapters. To limit the performance impact to AMD adapters,
> > introduce the ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ
> > only for these adapters.
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D201693
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> > Changes in v4:
> > * A function ata_dev_check_adapter() is added to check the vendor ID of
> >   the adapter.
> > * ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to
> >   align with the naming=C3=82 convention.
> > * Commit messages were improved according=C3=82 to reviewer comments.

Thanks, I'll fix this.

> >
> > Changes in v3:
> > * ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to
> >   ATA_HORKAGE_NONCQ_ON_AMD.
> > * Codes were fixed to completely disable NCQ on AMD controller.
> >
> > ---
> >  drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++++--
> >  include/linux/libata.h    |  1 +
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index c861c93d1e84..49049cd713e4 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -2186,6 +2186,25 @@ static void ata_dev_config_ncq_prio(struct ata_d=
evice *dev)
> >       dev->flags &=3D ~ATA_DFLAG_NCQ_PRIO;
> >  }
> >
> > +static bool ata_dev_check_adapter(struct ata_device *dev,
> > +                               unsigned short vendor_id)
> > +{
> > +     struct pci_dev *pcidev =3D NULL;
> > +     struct device *parent_dev =3D NULL;
> > +
> > +     for (parent_dev =3D dev->tdev.parent; parent_dev !=3D NULL;
> > +          parent_dev =3D parent_dev->parent) {
> > +             if (dev_is_pci(parent_dev)) {
> > +                     pcidev =3D to_pci_dev(parent_dev);
> > +                     if (pcidev->vendor =3D=3D vendor_id)
> > +                             return true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static int ata_dev_config_ncq(struct ata_device *dev,
> >                              char *desc, size_t desc_sz)
> >  {
> > @@ -2204,6 +2223,13 @@ static int ata_dev_config_ncq(struct ata_device =
*dev,
> >               snprintf(desc, desc_sz, "NCQ (not used)");
> >               return 0;
> >       }
> > +
> > +     if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_AMD &&
> > +         ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)) {
> > +             snprintf(desc, desc_sz, "NCQ (not used)");
> > +             return 0;
> > +     }
> > +
> >       if (ap->flags & ATA_FLAG_NCQ) {
> >               hdepth =3D min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
> >               dev->flags |=3D ATA_DFLAG_NCQ;
> > @@ -3971,9 +3997,11 @@ static const struct ata_blacklist_entry ata_devi=
ce_blacklist [] =3D {
> >       { "Samsung SSD 850*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> >                                               ATA_HORKAGE_ZERO_AFTER_TR=
IM, },
> >       { "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>
> Something went wrong when you applied my pre-cursor patch to your tree
> as base for this patch, you have spaces in front of and behind the
> "NULL,", where there should be tabs. So this does not apply cleanly
> on top of my patch.
>
> I'll forward my patch to you as an attached .eml file. You should
> "git am <file>.eml" that file on top of the latest linux-block/for-next
> and then rebase your patch on top of that.
>
> > -                                             ATA_HORKAGE_ZERO_AFTER_TR=
IM, },
> > +                                             ATA_HORKAGE_ZERO_AFTER_TR=
IM |
> > +                                             ATA_HORKAGE_NO_NCQ_ON_AMD=
, },
> >       { "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
>
> Idem for this line.

Got it.

>
> > -                                             ATA_HORKAGE_ZERO_AFTER_TR=
IM, },
> > +                                             ATA_HORKAGE_ZERO_AFTER_TR=
IM |
> > +                                             ATA_HORKAGE_NO_NCQ_ON_AMD=
, },
> >       { "FCCT*M500*",                 NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
> >                                               ATA_HORKAGE_ZERO_AFTER_TR=
IM, },
> >
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index 860e63f5667b..cdc248a15763 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -426,6 +426,7 @@ enum {
> >       ATA_HORKAGE_NOTRIM      =3D (1 << 24),    /* don't use TRIM */
> >       ATA_HORKAGE_MAX_SEC_1024 =3D (1 << 25),   /* Limit max sects to 1=
024 */
> >       ATA_HORKAGE_MAX_TRIM_128M =3D (1 << 26),  /* Limit max trim size =
to 128M */
> > +     ATA_HORKAGE_NO_NCQ_ON_AMD =3D (1 << 27),  /* Disable NCQ on AMD c=
hipset */
> >
> >        /* DMA mask for user DMA control: User visible values; DO NOT
> >           renumber */
>
> As discussed elsewhere in this thread, you should allow setting/clearing
> this flag from the libata.force kernel commandline option by adding the
> following extra bit to the patch:
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index daa375c7e763..e2e900085f99 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6136,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
>                 { "ncq",        .horkage_off    =3D ATA_HORKAGE_NONCQ },
>                 { "noncqtrim",  .horkage_on     =3D ATA_HORKAGE_NO_NCQ_TR=
IM },
>                 { "ncqtrim",    .horkage_off    =3D ATA_HORKAGE_NO_NCQ_TR=
IM },
> +               { "noncqamd",   .horkage_on     =3D ATA_HORKAGE_NO_NCQ_ON=
_AMD },
> +               { "ncqamd",     .horkage_off    =3D ATA_HORKAGE_NO_NCQ_ON=
_AMD },

I'll add them and propose v5 patch.

>                 { "dump_id",    .horkage_on     =3D ATA_HORKAGE_DUMP_ID }=
,
>                 { "pio0",       .xfer_mask      =3D 1 << (ATA_SHIFT_PIO +=
 0) },
>                 { "pio1",       .xfer_mask      =3D 1 << (ATA_SHIFT_PIO +=
 1) },
>
> Regards,
>
> Hans
>

Thank you.

--=20
BR,
Kate

