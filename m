From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v3 3/3] Add ata pass-through path for ZAC commands.
Date: Fri, 10 Jun 2016 02:28:46 -0500
Message-ID: <CAJVOszCyEVxjtxXdWuYkY2vQyjNZ2kfKJ_Rm5DCqtn=2VOv9hA@mail.gmail.com>
References: <1465542626-26536-1-git-send-email-shaun@tancheff.com>
 <1465542626-26536-4-git-send-email-shaun@tancheff.com> <575A6A05.1090006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:28378 "EHLO
	mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751573AbcFJH3H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2016 03:29:07 -0400
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5A7RFBv036414
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 03:29:06 -0400
Received: from mail-qg0-f71.google.com (mail-qg0-f71.google.com [209.85.192.71])
	by mx0b-00003501.pphosted.com with ESMTP id 23fs5rr070-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 03:29:05 -0400
Received: by mail-qg0-f71.google.com with SMTP id a95so89544608qgf.2
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 00:29:05 -0700 (PDT)
In-Reply-To: <575A6A05.1090006@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Jeff Layton <jlayton@poochiereds.net>, "J . Bruce Fields" <bfields@fieldses.org>

On Fri, Jun 10, 2016 at 2:19 AM, Hannes Reinecke <hare@suse.de> wrote:
> On 06/10/2016 09:10 AM, Shaun Tancheff wrote:
>> The current generation of HBA SAS adapters support connecting SATA
>> drives and perform SCSI<->ATA translations in hardware.
>> Unfortunately the ZBC commands are not being translate (yet).
>>
>> Currently users of SAS controllers can only send ZAC commands via
>> ata pass-through.
>>
>> This method overloads the meaning of REQ_META to direct ZBC commands
>> to construct ZAC equivalent ATA pass through commands.
>> Note also that this approach expects the initiator to deal with the
>> little endian result due to bypassing the normal translation layers.
>>
>> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
>> ---
>> So this patch isn't the right way to work around hardware that is
>> missing features (mixing ATA commands in SCSI interface code) it
>> maybe useful for end users in the near term who have HBA SAS
>> controllers that don't support ZBC <-> ZAC translations.
>>
> And indeed, this patch isn't right.
> It is just for a very specific SAS HBA (mpt2sas/mpt3sas).
> Other SAS HBAs like isci and hisi_sas work just nicely here.

That is good to know there are some vendors that are on the ball.

> So a translation into a ATA_16 command is _wrong_.
> If you need to do this you'll have to move it into the LLDD itself.
> Or use blacklisting to invoke this behaviour.
> But _not_ in the general code path.

Agreed. Thanks!

> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG N=C3=BCrnberg)

--=20
Shaun Tancheff
