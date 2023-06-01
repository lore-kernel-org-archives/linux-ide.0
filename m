Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9EC77B7E
	for <linux-ide@archiver.kernel.org>; Thu,  1 Jun 2023 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjFAPzu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjFAPzr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2023 11:55:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD56189
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 08:55:35 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43C933F16A
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685634934;
        bh=0jAabHqdSvSI81GcjIi2ShyL+hAnr5Nv9d2pTfh5lts=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ciPg7MQcwNN/ae8KOsE1g7YFE1hoiWJO0LI1w4RNgDA0sDjow2N6vgDb66u8z8yq/
         hW7uQ+7kPPa+n1597RA+azOUkZuW7nhxyG2Bxn0HQeLuHn8/nlxDNoSLA619KzR66G
         Jn4ZJiI4mgVIqD7Ej0WCk8hHFvhWo/beBjgHwIvTfvDG7cb7uRUFBhEpEgHxHDAqDF
         JvCmyJ3Dj9SAhr0Dd2G/tuAXqiSg6fZlpdZ4rKBqiUrngH9oCFZiC9O3DxjyoAahEU
         H2mm9jix2/QZfBrWxWXTfseDc+NH6zCPYt02RHTYKsRzXEDPen6cA7P8HSQCEWdB6/
         2jss5M2hbmnkQ==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-64d4472e1e5so1082312b3a.2
        for <linux-ide@vger.kernel.org>; Thu, 01 Jun 2023 08:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685634933; x=1688226933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jAabHqdSvSI81GcjIi2ShyL+hAnr5Nv9d2pTfh5lts=;
        b=hGV7886eoU+RuNRottXcTopTw6En5Kq+FZPZ66fxAPRBuww5u50Os12DneatggxJn1
         J2k2+Vh0pvAj1caJaqI9YRk7PrQt+YPXme3LN9adBAvTQ4xi6VT3lJ/UhMXPN+8oSS3D
         j3ucGmFbwL72sV9Upx8uP6OYWnPQVUHBuAFbeHMTGmFoDxU74Q83QcGkEZZJKypuUJHd
         IzpHPUWjMjDJVt5zJp494j2Asf4IbWKxixPUwpdZw5woPuGgavbceAcoQkCQS00Q84g5
         z2PJn6BDMTXZOE35AekjJiEcUh536QU5Ha1ZhUNzNzLWOXnydpaOPoA26QGfnGggpPvc
         AkSw==
X-Gm-Message-State: AC+VfDwAwB7IxktAzCsl3IbkJALN9eP8Wk+EZEzVkXyXzuwiQLJ2ss6u
        g/FiPGy1vskvYS5okR0ydBGv1nNYGcPO5ze5fdFGbUK/Bur+wDda2fEmi/UzAKodIDkhZjHh8p3
        Jr6lhMUOGZcVyDTjhAuJZYZUa/c+2pmq+UnWsCq5s/uEn4K7n8hCS8Q==
X-Received: by 2002:a05:6a20:8f04:b0:106:c9b7:c93d with SMTP id b4-20020a056a208f0400b00106c9b7c93dmr12612832pzk.19.1685634932905;
        Thu, 01 Jun 2023 08:55:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pvvJJKpMvAFbtIuz7/+acgXHck5G0WosfwFB94/V2cO+3iqB/cNFrT2JZeoiXuxJej081VjB1P5xpca6/ccI=
X-Received: by 2002:a05:6a20:8f04:b0:106:c9b7:c93d with SMTP id
 b4-20020a056a208f0400b00106c9b7c93dmr12612804pzk.19.1685634932503; Thu, 01
 Jun 2023 08:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230502150435.423770-1-kai.heng.feng@canonical.com>
 <20230502150435.423770-2-kai.heng.feng@canonical.com> <8eea2352-1d4f-aa3a-7c86-9306adb0aaae@kernel.org>
In-Reply-To: <8eea2352-1d4f-aa3a-7c86-9306adb0aaae@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 1 Jun 2023 23:55:21 +0800
Message-ID: <CAAd53p7H2C+LenmzynRHqnxd-qgc2+p9ZLKidVUOAtXMyU2rmQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ata: libata: Defer rescan on suspended device
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, May 7, 2023 at 5:23=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 2023/05/03 0:04, Kai-Heng Feng wrote:
> > During system resume, if an EH is schduled after ATA host is resumed
> > (i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
> > fully resumed, the device_lock hold by scsi_rescan_device() is never
> > released so the dpm_resume() of the disk is blocked forerver.
> >
> > That's because scsi_attach_vpd() is expecting the disk device is in
> > operational state, as it doesn't work on suspended device.
> >
> > To avoid such deadlock, defer rescan if the disk is still suspended so
> > the resume process of the disk device can proceed. At the end of the
> > resume process, use the complete() callback to schedule the rescan task=
.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v4:
> >  - No change.
> >
> > v3:
> >  - New patch to resolve undefined pm_suspend_target_state.
> >
> > v2:
> >  - Schedule rescan task at the end of system resume phase.
> >  - Wording.
> >
> >  drivers/ata/libata-core.c | 11 +++++++++++
> >  drivers/ata/libata-eh.c   | 11 +++++++++--
> >  include/linux/libata.h    |  1 +
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 8bf612bdd61a..bdd244bdb8a2 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -5093,6 +5093,16 @@ static int ata_port_pm_poweroff(struct device *d=
ev)
> >       return 0;
> >  }
> >
> > +static void ata_port_pm_complete(struct device *dev)
> > +{
> > +     struct ata_port *ap =3D to_ata_port(dev);
> > +
> > +     if (ap->pflags & ATA_PFLAG_DEFER_RESCAN)
> > +             schedule_work(&(ap->scsi_rescan_task));
> > +
> > +     ap->pflags &=3D ~ATA_PFLAG_DEFER_RESCAN;
>
> Is this called with the port lock held ? Otherwise, there is a race with
> ata_eh_revalidate_and_attach() and we may end up never actually revalidat=
ing the
> drive. At the very least, I think that ATA_PFLAG_DEFER_RESCAN needs to be
> cleared before calling schedule_work().

OK. Maybe all of these are unnecessary if the rescanning can wait for
disk device to be resumed.

>
> > +}
> > +
> >  static const unsigned int ata_port_resume_ehi =3D ATA_EHI_NO_AUTOPSY
> >                                               | ATA_EHI_QUIET;
> >
> > @@ -5158,6 +5168,7 @@ static const struct dev_pm_ops ata_port_pm_ops =
=3D {
> >       .thaw =3D ata_port_pm_resume,
> >       .poweroff =3D ata_port_pm_poweroff,
> >       .restore =3D ata_port_pm_resume,
> > +     .complete =3D ata_port_pm_complete,
> >
> >       .runtime_suspend =3D ata_port_runtime_suspend,
> >       .runtime_resume =3D ata_port_runtime_resume,
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index a6c901811802..0881b590fb7e 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/export.h>
> >  #include <linux/pci.h>
> > +#include <linux/suspend.h>
> >  #include <scsi/scsi.h>
> >  #include <scsi/scsi_host.h>
> >  #include <scsi/scsi_eh.h>
> > @@ -2983,8 +2984,14 @@ static int ata_eh_revalidate_and_attach(struct a=
ta_link *link,
> >                        */
> >                       ehc->i.flags |=3D ATA_EHI_SETMODE;
> >
> > -                     /* schedule the scsi_rescan_device() here */
> > -                     schedule_work(&(ap->scsi_rescan_task));
> > +                     /* Schedule the scsi_rescan_device() here.
>
> Code style: please start multi-line comment with a line starting with "/*=
"
> without text after it.

OK. Will do.

>
> > +                      * Defer the rescan if it's in process of
> > +                      * suspending or resuming.
> > +                      */
> > +                     if (pm_suspend_target_state !=3D PM_SUSPEND_ON)
>
> Why ? Shouldn't this be "pm_suspend_target_state =3D=3D PM_SUSPEND_ON" ? =
Because if
> the device is already resumed, why would we need to defer the rescan ?

"pm_suspend_target_state !=3D PM_SUSPEND_ON" means the system is not
"ON" state. For this particular issue, it means the system is still in
resume process.

>
> > +                             ap->pflags |=3D ATA_PFLAG_DEFER_RESCAN;
> > +                     else
> > +                             schedule_work(&(ap->scsi_rescan_task));
> >               } else if (dev->class =3D=3D ATA_DEV_UNKNOWN &&
> >                          ehc->tries[dev->devno] &&
> >                          ata_class_enabled(ehc->classes[dev->devno])) {
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index 311cd93377c7..1696c9ebd168 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -189,6 +189,7 @@ enum {
> >       ATA_PFLAG_UNLOADING     =3D (1 << 9), /* driver is being unloaded=
 */
> >       ATA_PFLAG_UNLOADED      =3D (1 << 10), /* driver is unloaded */
> >
> > +     ATA_PFLAG_DEFER_RESCAN  =3D (1 << 16), /* peform deferred rescan =
on system resume */
>
> Do we really need a new flag ? Can't we use ATA_PFLAG_PM_PENDING correctl=
y ?
> From the rather sparse commit message description, it sounds like this fl=
ag is
> being cleared too early. Not sure though. Need to dig further into this.

Defer clearing ATA_PFLAG_PM_PENDING doesn't seem to be trivial.
I'll send a new version which IMO is a lot simpler.

Kai-Heng

>
> >       ATA_PFLAG_SUSPENDED     =3D (1 << 17), /* port is suspended (powe=
r) */
> >       ATA_PFLAG_PM_PENDING    =3D (1 << 18), /* PM operation pending */
> >       ATA_PFLAG_INIT_GTM_VALID =3D (1 << 19), /* initial gtm data valid=
 */
>
> --
> Damien Le Moal
> Western Digital Research
>
