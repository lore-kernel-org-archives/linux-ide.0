From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 3/4] SCT Write Same / DSM Trim
Date: Mon, 22 Aug 2016 08:33:58 +0000
Message-ID: <CAGnHSEmFMx1Q6mRV-hXwR4_08OvvSR1xcxoT1dLjVMvOHYY_+g@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-4-shaun@tancheff.com>
 <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35253 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbcHVIeB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 04:34:01 -0400
In-Reply-To: <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

On 22 August 2016 at 08:31, Tom Yan <tom.ty89@gmail.com> wrote:
> As mentioned before, as of the latest draft of ACS-4, nothing about a
> larger payload size is mentioned. Conservatively speaking, it sort of

*payload block size

> means that we are allowing four 512-byte block payload on 4Kn device

*eight 512-byte-block payload

> regardless of the reported limit in the IDENTIFY DEVICE data. I am
> really not sure if it's a good thing to do. Doesn't seem necessary
> anyway, especially when our block layer does not support such a large
> bio size (well, yet), so each request will end up using a payload of
> two 512-byte blocks at max anyway.
>
> Also, it's IMHO better to do it in a seperate patch (series) after the
> SCT Write Same support has entered libata's repo too, because this has
> nothing to with it but TRIM translation. In case the future ACS
> standards has clearer/better instruction on this, it will be easier
> for us to revert/follow up too.
>
> And you'll need to fix the Block Limits VPD simulation
> (ata_scsiop_inq_b0) too, so that it will advertise the Maximum Write
> Same Length dynamically as per the logical sector size, otherwise your
> effort will be completely in vain, even if our block layer is
> overhauled in the future.
>
> Please be noted that, since your haven't touched ata_scsiop_inq_b0 at
> all, the reported Maximum Write Same Length will be:
>
> On device with TRIM support:
> - 4194240 LOGICAL sector per request split / command
> -- ~=2G on non-4Kn drives
> -- ~=16G on non-4Kn drives
>
> On device without TRIM support:
> - 0 --> SD_MAX_WS10_BLOCKS (65535) per request split / command
> -- ~= 32M on non-4Kn drives
> -- ~=256M on non-4Kn drives
>
> Even if we ignore the upper limit(s) of the block layer, do we want
> such inconsistencies?
>
