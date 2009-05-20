From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 15:09:14 -0400
Message-ID: <4A14555A.6080307@garzik.org>
References: <20090520065942.GD11363@kernel.dk>	 <20090520070038.GE11363@kernel.dk> <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60119 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339AbZETTJR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 15:09:17 -0400
In-Reply-To: <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Grant Grundler wrote:
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

A mixed config over PMP works today by setting the proper depth iff NCQ 
(== will not send too many cmds to device, if !NCQ) and using link-wide 
tag allocation (== will not send too many cmds to link).

	Jeff




