From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 11:08:09 -0700
Message-ID: <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>
References: <20090520065942.GD11363@kernel.dk>
	 <20090520070038.GE11363@kernel.dk>
	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:21444 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZETSIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 14:08:12 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n4KI8COJ014707
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 11:08:12 -0700
Received: from fxm1 (fxm1.prod.google.com [10.184.13.1])
	by spaceape12.eur.corp.google.com with ESMTP id n4KI8Abp031710
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 11:08:10 -0700
Received: by fxm1 with SMTP id 1so570732fxm.45
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 11:08:10 -0700 (PDT)
In-Reply-To: <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, jeff@garzik.org, htejun@gmail.com

Form the ATA and SATA spec, NCQ is per device. It is possible to
assign the same tag on different port, the disks and PMP will not
care.
However, today, we assign tag on a port basis [see
__ata_qc_from_tag()], therefore only 32 commands can be inflight to
all devices behind a given port.

Being able to a do a mapping qc <---> {pmp port, tag} instead of just
qc <---> {tag} will provide a performance boost when disks supporting
NCQ are connected behind a PMP. Maybe it can be done, by moving qcmd
from ata_port to ata_link.

As Tejun said, the patch needs more work to be able to support same
tag used on 2 different links behind the same port.
Also, given we are changing the amount of commands we sent to the
controller, we would have to change can_queue from ATA_MAX_QUEUE to
ATA_MAX_QUEUE*n, where n is the number of ports supported by the
controller [max SATA_PMP_MAX_PORTS, but some controller, like SiI3132
only supports 5 devices, and other may only support n = 1]

When done, the patch will require a great amount of testing, given we
will exercise the controllers in a brand new way. A white list might
be necessary.

Jens, using SCSI tagging for ata commands is a great idea, but it is
no small feat...

Gwendal.

On Wed, May 20, 2009 at 10:10 AM, Grant Grundler <grundler@google.com> wrote:
> On Wed, May 20, 2009 at 12:00 AM, Jens Axboe <jens.axboe@oracle.com> wrote:
>> libata currently has a pretty dumb ATA_MAX_QUEUE loop for finding
>> a free tag to use. Instead of fixing that up, convert libata to
>> using block layer tagging - gets rid of code in libata, and is also
>> much faster.
> ...
>> @@ -1137,7 +1141,17 @@ static int ata_scsi_dev_config(struct scsi_device *sdev,
>>
>>                depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
>>                depth = min(ATA_MAX_QUEUE - 1, depth);
>> -               scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
>> +
>> +               /*
>> +                * If this device is behind a port multiplier, we have
>> +                * to share the tag map between all devices on that PMP.
>> +                * Set up the shared tag map here and we get automatic.
>
> Automatic what?
>
>> +                */
>> +               if (dev->link->ap->pmp_link)
>> +                       scsi_init_shared_tag_map(sdev->host, ATA_MAX_QUEUE - 1);
>> +
>> +               scsi_set_tag_type(sdev, MSG_SIMPLE_TAG);
>> +               scsi_activate_tcq(sdev, depth);
>
> I just read Tejun's reply and it sounds right what he's saying.
> But can SATA controllers handle NCQ and !NCQ devices on the same port?
> Can the PMP handle it?
>
> If both can, I don't understand how a mixed config works today.
>
> TBH, this isn't something I'm very worried about since most commercial configs
> will be homogenous (think HW replacement/support costs).
>
> hth,
> grant
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
