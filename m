From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Wed, 10 Aug 2016 09:34:53 -0500
Message-ID: <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-3-git-send-email-shaun@tancheff.com> <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
 <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:17392 "EHLO
	mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932670AbcHJSF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2016 14:05:28 -0400
Received: from pps.filterd (m0075032.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7AEUJRB033945
	for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2016 10:35:15 -0400
Received: from mail-yw0-f197.google.com (mail-yw0-f197.google.com [209.85.161.197])
	by mx0b-00003501.pphosted.com with ESMTP id 24r1gvh9bs-25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2016 10:35:14 -0400
Received: by mail-yw0-f197.google.com with SMTP id j12so77798214ywb.3
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2016 07:35:14 -0700 (PDT)
In-Reply-To: <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>

On Wed, Aug 10, 2016 at 6:30 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 10 August 2016 at 14:31, Tom Yan <tom.ty89@gmail.com> wrote:
>> I don't really know about SCT Write Same but there is one concern I
>> could I think of.
>>
>> libata's SATL would report a maximum write same length base on the
>> number of sectors a one-block TRIM payload can describe at most, which
>> is 65535 * 64 = 4194240 (see ata_scsiop_inq_b0 in libata-scsi.c). If
>> the drive does not support TRIM, it will not report such length. That
>> is technically fine, as per SBC standard, and I suppose the SCSI disk
>> driver would use SD_MAX_WS16_BLOCKS = 0x7fffff (8388607).
>
> Actually it will use SD_MAX_WS10_BLOCKS = 0xffff (65535) in such case.
> See sd_config_write_same() in sd.c. So if the device support TRIM,
> each SCT Write Same will cover 4194240 logical sectors; if it does
> not, each will cover 65535 logical sectors. In that case, perhaps we
> should report the same value in the Maximum Write Same Length field
> when (only) SCT Write Same is supported? (Not the Optimal Unmap
> Granularity field though).

You are correct in that we can advertise the larger limit in
ata_scsi_dev_config() when only SCT write same is supported
rather than fall back to WS10.

TRIM is bound by an interface maximum. You can only stuff 64 entries
of a 16 bit length followed by 48 bit lba into a 512 byte block.

SCT is not restricted (you can wipe an entire drive) however there
is a practical limit in that I have coded the SCT to operate
in the foreground so the command could timeout depending
on how fast the media can write.

On my machine the default timeout is 30s so to clear 4194240 (16G):
  30s -> 547 MB/s
  60s -> 274 MB/s
  90s -> 183 MB/s
120s -> 137 MB/s

So for my drives 8G and 30s or 16G and 60s is fine.
For older or slow drives 4G and 30s should be fine.

I really am not sure what would be considered the correct
solution though. I believe that the WRITE SAME defaults
are currently being chosen around physical limits.

We could reduce the trim to 16 entries when SCT is available and
bump SCT to the same 16 * 63335 maximum?

I think we can also bump the command timeout for WRITE SAME?

Suggestions are welcome.
-- 
Shaun Tancheff
