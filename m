From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 10:10:45 -0700
Message-ID: <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
References: <20090520065942.GD11363@kernel.dk>
	 <20090520070038.GE11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:15776 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZETRKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 13:10:48 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id n4KHAlOF024300
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 10:10:48 -0700
Received: from yx-out-2324.google.com (yxm8.prod.google.com [10.190.4.8])
	by zps38.corp.google.com with ESMTP id n4KHAj9f024811
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 10:10:46 -0700
Received: by yx-out-2324.google.com with SMTP id 8so323367yxm.15
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 10:10:45 -0700 (PDT)
In-Reply-To: <20090520070038.GE11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com

On Wed, May 20, 2009 at 12:00 AM, Jens Axboe <jens.axboe@oracle.com> wr=
ote:
> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
> a free tag to use. Instead of fixing that up, convert libata to
> using block layer tagging - gets rid of code in libata, and is also
> much faster.
=2E..
> @@ -1137,7 +1141,17 @@ static int ata_scsi_dev_config(struct scsi_dev=
ice *sdev,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depth =3D min(=
sdev->host->can_queue, ata_id_queue_depth(dev->id));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depth =3D min(=
ATA_MAX_QUEUE - 1, depth);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_adjust_queue_=
depth(sdev, MSG_SIMPLE_TAG, depth);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If this de=
vice is behind a port multiplier, we have
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to share t=
he tag map between all devices on that PMP.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set up the=
 shared tag map here and we get automatic.

Automatic what?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev->link->ap-=
>pmp_link)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 scsi_init_shared_tag_map(sdev->host, ATA_MAX_QUEUE - 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_set_tag_type(=
sdev, MSG_SIMPLE_TAG);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_activate_tcq(=
sdev, depth);

I just read Tejun's reply and it sounds right what he's saying.
But can SATA controllers handle NCQ and !NCQ devices on the same port?
Can the PMP handle it?

If both can, I don't understand how a mixed config works today.

TBH, this isn't something I'm very worried about since most commercial =
configs
will be homogenous (think HW replacement/support costs).

hth,
grant
