From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Mon, 22 Aug 2016 19:36:51 -0500
Message-ID: <CAJVOszC_MfPtGTR05p=qSHjY_wu4ziMMAqgra7Pu0tQYoxa-Kg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com>
 <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
 <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
 <CAJVOszAHcuyLoSJwmKvK5vgM8aLqfQJsaw=Vx7K66wMEaqmu_A@mail.gmail.com> <CAGnHSEm5Ur-7eCj-_mJsTeDwxhkGHPERAodebDS7rRg0AvGn3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:12676 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932447AbcHWAi2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 20:38:28 -0400
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7N0ZD4B008117
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 20:37:13 -0400
Received: from mail-ua0-f199.google.com (mail-ua0-f199.google.com [209.85.217.199])
        by mx0b-00003501.pphosted.com with ESMTP id 2502gatrey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 20:37:13 -0400
Received: by mail-ua0-f199.google.com with SMTP id u13so269678993uau.2
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2016 17:37:13 -0700 (PDT)
In-Reply-To: <CAGnHSEm5Ur-7eCj-_mJsTeDwxhkGHPERAodebDS7rRg0AvGn3Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Mon, Aug 22, 2016 at 6:09 PM, Tom Yan <tom.ty89@gmail.com> wrote:
> I am not sure about what you mean here. Rejecting SCSI Write Same
> commands that has its "number of blocks" field set to a value higher
> than the device's reported Maximum Write Same Length is only natural
> and mandated by SBC. We have no reason (even if it is practically not
> a must) not to do it while we are implementing a SCSI-ATA Translation
> Layer here as long as we advertise Maximum Write Same Length. It does
> not matter here whether the command ends up being translated to SCT
> Write Same or TRIM.
>
> How high or how lower the limit should be advertised has nothing to do
> with the checking.
>
> FWIW, letting the SCSI/block layer fall back with SD_MAX_WS10_BLOCKS
> does NOT count as advertising Maximum Write Same Length, that's why we
> may or may not (in terms of SBC) check n_block against it if we are
> really gonna leave ata_scsiop_inq_b0 in libata-scsi untouched.

Sorry I'm still a bit confused.

SCT Write Same does not have a limit ... it's a u64 of logical sectors.
Any limit specified is smaller based on other parts of the stack.
The SATL code being used to emulating SCSI Write Same which does
have a limited number of sectors .. so falling back to the SCSI limit
seems reasonable.

So the limit that is being applied is either the current TRIM limit,
or the SCSI Write Same limit.
-- 
Shaun Tancheff
