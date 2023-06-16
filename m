Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8602CEB64D9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Jun 2023 03:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjFPDcR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 15 Jun 2023 23:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjFPDcN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jun 2023 23:32:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB862686
        for <linux-ide@vger.kernel.org>; Thu, 15 Jun 2023 20:32:10 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CDEF3F36A
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2023 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686886328;
        bh=e5autB/dfHgjBRvA2eBYALYimY/hNsU7bj3L/KlaG6g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I0Wk3/LGCJp1J77YSYM56ZOFFJNKR/rN84LwIM/Bq1kvN9lO0SYIC8kRVNGTnpmIg
         4//GX12D5FKjA2oLOI6uhCm6ydjw8qTXKi76oibklVhm156at/xWxNjQpOO3T+TOPE
         R1WaA2ZJ8v6+1HJ7GyeU96C4IOSxErnhKJPquaMTjUDJCMWjHbWmhe+GCUJR9njbFw
         xIHyI5SI02Z9Gc08lPpXLO8t/L90gWMCRrj09hk2/WD9Ke09NoStbN89kEmAk/Po6m
         uR4XZ7zm47PQBY0h8P52iWpdTpaR0NORfjE6o9jPQOZf8ef3AItgnkE4zUkduUFW39
         7YzqDN4OwjJCg==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39ca0a35e21so295213b6e.2
        for <linux-ide@vger.kernel.org>; Thu, 15 Jun 2023 20:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686886327; x=1689478327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5autB/dfHgjBRvA2eBYALYimY/hNsU7bj3L/KlaG6g=;
        b=d2PR+fyi60C2crdFfXIkVzySgqne9MQOqhos6sc0mV92tqhB0baRbqopdtXq4Nn5K6
         LOMAlK1phPxyeRMpcHzYDomGOutkKwTlLvsnM1l55hOe3NKcL759HjP0ufPY2AnXyPIb
         nDXSY9nKitlmPiwC08y+ERj1V9ZUirzf33qBumX403bLVMLXLlUtGI5+IxK6WRzsoeCQ
         6+4Pzk2InVALLiUZ41znvVqUa7qxk6w/xgcQk1FCjqX9GZUMWjo3UHOnO8JlUXLKsQ/Q
         H4mukY76dg0TIRHhpHm88CurOkdBf6omvyy7BHA3h6AMPua5PdVw+8yxY7QNN07cyX3b
         YqWg==
X-Gm-Message-State: AC+VfDzFEJBeeK9+2qpUobCMJT+rn/5HBqipOBOeSAtqRavV3wFGpOAE
        cFddJvJfNGTeHWd79FAChEDOfpZRs/5jUeVhgqC6LmVxwcRzSPqboCmBniLFIhoz3wUeRKsWgNy
        bbEgy91UDdBTxaTZvvTDoZcb/jk3POGCEXT0aKcRy3i/OUGSPYoryCA==
X-Received: by 2002:aca:120d:0:b0:39a:a19a:3207 with SMTP id 13-20020aca120d000000b0039aa19a3207mr1040611ois.18.1686886326747;
        Thu, 15 Jun 2023 20:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qVZLrWzR12LrdKIg1I9eJQ5EA1dk+XTVfU5unfFTvIB6ly1kPYwFu5gLy7jmlJgDQyLrBVfJ9E16KTi12lIA=
X-Received: by 2002:aca:120d:0:b0:39a:a19a:3207 with SMTP id
 13-20020aca120d000000b0039aa19a3207mr1040596ois.18.1686886326405; Thu, 15 Jun
 2023 20:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230615083326.161875-1-dlemoal@kernel.org>
In-Reply-To: <20230615083326.161875-1-dlemoal@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 16 Jun 2023 11:31:55 +0800
Message-ID: <CAAd53p6PMhNO8PynWAw5xz_gEOp+NQv18XKkW-M-r=JfHWT6FQ@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-scsi: Avoid deadlock on rescan after device resume
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Hannes Reinecke <hare@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Jun 15, 2023 at 4:33=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> When an ATA port is resumed from sleep, the port is reset and a power
> management request issued to libata EH to reset the port and rescanning
> the device(s) attached to the port. Device rescanning is done by
> scheduling an ata_scsi_dev_rescan() work, which will execute
> scsi_rescan_device().
>
> However, scsi_rescan_device() takes the generic device lock, which is
> also taken by dpm_resume() when the SCSI device is resumed as well. If
> a device rescan execution starts before the completion of the SCSI
> device resume, the rcu locking used to refresh the cached VPD pages of
> the device, combined with the generic device locking from
> scsi_rescan_device() and from dpm_resume() can cause a deadlock.
>
> Avoid this situation by changing struct ata_port scsi_rescan_task to be
> a delayed work instead of a simple work_struct. ata_scsi_dev_rescan() is
> modified to check if the SCSI device associated with the ATA device that
> must be rescanned is not suspended. If the SCSI device is still
> suspended, ata_scsi_dev_rescan() returns early and reschedule itself for
> execution after an arbitrary delay of 5ms.
>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Joe Breuer <linux-kernel@jmbreuer.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217530
> Fixes: a19a93e4c6a9 ("scsi: core: pm: Rely on the device driver core for =
async power management")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/ata/libata-core.c |  3 ++-
>  drivers/ata/libata-eh.c   |  2 +-
>  drivers/ata/libata-scsi.c | 22 +++++++++++++++++++++-
>  include/linux/libata.h    |  2 +-
>  4 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8bf612bdd61a..b4f246f0cac7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5348,7 +5348,7 @@ struct ata_port *ata_port_alloc(struct ata_host *ho=
st)
>
>         mutex_init(&ap->scsi_scan_mutex);
>         INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
> -       INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
> +       INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
>         INIT_LIST_HEAD(&ap->eh_done_q);
>         init_waitqueue_head(&ap->eh_wait_q);
>         init_completion(&ap->park_req_pending);
> @@ -5954,6 +5954,7 @@ static void ata_port_detach(struct ata_port *ap)
>         WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
>
>         cancel_delayed_work_sync(&ap->hotplug_task);
> +       cancel_delayed_work_sync(&ap->scsi_rescan_task);
>
>   skip_eh:
>         /* clean up zpodd on port removal */
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a6c901811802..6f8d14191593 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2984,7 +2984,7 @@ static int ata_eh_revalidate_and_attach(struct ata_=
link *link,
>                         ehc->i.flags |=3D ATA_EHI_SETMODE;
>
>                         /* schedule the scsi_rescan_device() here */
> -                       schedule_work(&(ap->scsi_rescan_task));
> +                       schedule_delayed_work(&ap->scsi_rescan_task, 0);
>                 } else if (dev->class =3D=3D ATA_DEV_UNKNOWN &&
>                            ehc->tries[dev->devno] &&
>                            ata_class_enabled(ehc->classes[dev->devno])) {
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8ce90284eb34..551077cea4e4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4597,10 +4597,11 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, u=
nsigned int channel,
>  void ata_scsi_dev_rescan(struct work_struct *work)
>  {
>         struct ata_port *ap =3D
> -               container_of(work, struct ata_port, scsi_rescan_task);
> +               container_of(work, struct ata_port, scsi_rescan_task.work=
);
>         struct ata_link *link;
>         struct ata_device *dev;
>         unsigned long flags;
> +       bool delay_rescan =3D false;
>
>         mutex_lock(&ap->scsi_scan_mutex);
>         spin_lock_irqsave(ap->lock, flags);
> @@ -4614,6 +4615,21 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>                         if (scsi_device_get(sdev))
>                                 continue;
>
> +                       /*
> +                        * If the rescan work was scheduled because of a =
resume
> +                        * event, the port is already fully resumed, but =
the
> +                        * SCSI device may not yet be fully resumed. In s=
uch
> +                        * case, executing scsi_rescan_device() may cause=
 a
> +                        * deadlock with the PM code on device_lock(). Pr=
event
> +                        * this by giving up and retrying rescan after a =
short
> +                        * delay.
> +                        */
> +                       delay_rescan =3D sdev->sdev_gendev.power.is_suspe=
nded;
> +                       if (delay_rescan) {
> +                               scsi_device_put(sdev);
> +                               break;
> +                       }
> +
>                         spin_unlock_irqrestore(ap->lock, flags);
>                         scsi_rescan_device(&(sdev->sdev_gendev));
>                         scsi_device_put(sdev);
> @@ -4623,4 +4639,8 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>
>         spin_unlock_irqrestore(ap->lock, flags);
>         mutex_unlock(&ap->scsi_scan_mutex);
> +
> +       if (delay_rescan)
> +               schedule_delayed_work(&ap->scsi_rescan_task,
> +                                     msecs_to_jiffies(5));
>  }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 311cd93377c7..dd5797fb6305 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -836,7 +836,7 @@ struct ata_port {
>
>         struct mutex            scsi_scan_mutex;
>         struct delayed_work     hotplug_task;
> -       struct work_struct      scsi_rescan_task;
> +       struct delayed_work     scsi_rescan_task;
>
>         unsigned int            hsm_task_state;
>
> --
> 2.40.1
>
