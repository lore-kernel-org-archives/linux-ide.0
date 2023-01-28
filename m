Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C60EC54EAA
	for <linux-ide@archiver.kernel.org>; Sat, 28 Jan 2023 00:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjA1Aks (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjA1Akq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2023 19:40:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B91BE6
        for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2023 16:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674866444; x=1706402444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cKFsKpmmzu6Woagk/ZR/i+nzuRdTfU6KzMyBFnPYOU8=;
  b=XxzzaF7UQhuS+2Bbt9i70GPz/SbzvNLli3bqCP/wCdd4G4KxaFAyXHWj
   dPwB34No7QtecERgh8+KPHeNMq9vZ7FcLCAzt8q55tO8ej6nX0gSTnYwg
   tsr8wfrxJG7RmGro1Kni71fT9I6yrnerXYz6G/nO3mQuiC0YMAm17F61d
   3SW7bNpFt/XUHvaf7vicxWzyssCahRe1PyYAfksXjpXKD6eK+xfmZDqa8
   ZIvtympC4eTBpWo0mxRkgTgplVCfyT7UT06vETBhdMgodeHYwpY3xMgNX
   AASZ0BYYxxwNpdcGEbUdfOME6QBDMbm0e336LaFVn6pg1cvbGs0xaYYgy
   A==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="220264300"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 08:40:43 +0800
IronPort-SDR: VAQFnGpmt/ppzTyZ1ln2d4oEFHMwpuVzHoNWtvHpUCyeepJc1BEFlcZv8APV+XGinabu0kMwG9
 lg9tv8DNREf3xjYgdg1aqrnA98xBMSwNkdSJliHAvH22BK8xGk4Zk11zCK4JCEgtpE9K5bjC4Y
 /5oXufgy48A2trp55sy4LtdQbm26qoEF010DGm9aFyg7oIp4zicHABGnUYi40HTsyeBWE20Y6o
 XjVkeFlbKnOx9g9r+9PfzV6J6A9mKszdQp6z1fqTwdMFc9PDeSO72Yk2CY+sQ0TSAf6PHzI1Ur
 yo4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 15:52:26 -0800
IronPort-SDR: SeSjqPjTaVwzI7i6bsZgBZhxwlhSH4Iqd1P+/Pdc9Ql2+DB3Eeev9T5GOmpLCoYTfHorENx4dA
 oQ1zrSlHlJX/qYP4in4bh1z0ojRu3s9uoF5Y9QBClaFFeyWaLWYs4EJuogoGPufBel6FfVFWIN
 +RqfoGm1bCkWSGzkBTwhB/qoMB7rxHVjj/i1s4wFKLa9+PHOYrfERRbEDYGNjw2J0az8n8teYY
 HYsr488DYhQ2wP2Zg5rD4PS9Jfaa8VIR7D4qw0TtI3HRduc//O7/X1ClcAbFRlwy8EmhtuXtEV
 Im4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:40:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3bG20yW9z1Rwtl
        for <linux-ide@vger.kernel.org>; Fri, 27 Jan 2023 16:40:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674866440; x=1677458441; bh=cKFsKpmmzu6Woagk/ZR/i+nzuRdTfU6KzMy
        BFnPYOU8=; b=FsKlqNxVo6Ji+qZKF4d1kZvenDQREvj2366fo5MCw7gF+RGGZE+
        oGfNLYtnjV/+HoFdVuAlkhUf090mQrC8qJJifWffyU+ip3Gv0nsG92xI3n7bcVbP
        4WqBE2ZlbxcF8t4XPpSDZxRiMTK7BKJL9pQwbWFo1oo9U/nhV2WgtGkhnlg+98lA
        zza5z/cQUqW12jMSjy3bSHho5oDvfqstGQs9f4h/r4VVephhNpXBcYsnjNz5quDf
        JjdM1yigJxqlnCl771QPR90rw/zvH9D2DIxIofcxNPDY/9kOPHhbWdXHbo/29LuT
        a9AG77TVcoAbgM6ImK35cMya8aQ0iZa4ZEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EByT2qlCNzpN for <linux-ide@vger.kernel.org>;
        Fri, 27 Jan 2023 16:40:40 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3bFz2gDbz1RvLy;
        Fri, 27 Jan 2023 16:40:39 -0800 (PST)
Message-ID: <049a7e88-89d1-804f-a0b5-9e5d93d505f7@opensource.wdc.com>
Date:   Sat, 28 Jan 2023 09:40:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230124190308.127318-2-niklas.cassel@wdc.com>
 <bd0ce7ad-cf9e-a647-9b1e-cb36e7bbe30f@acm.org>
 <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
 <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
 <5066441f-e265-ed64-fa39-f77a931ab998@acm.org>
 <275993f1-f9e8-e7a8-e901-2f7d3a6bb501@opensource.wdc.com>
 <e8324901-7c18-153f-b47f-112a394832bd@acm.org> <Y9Gd0eI1t8V61yzO@x1-carbon>
 <86de1e78-0ff2-be70-f592-673bce76e5ac@opensource.wdc.com>
 <Y9KF5z/v0Qp5E4sI@x1-carbon> <7f0a2464-673a-f64a-4ebb-e599c3123a24@acm.org>
 <29b50dbd-76e9-cdce-4227-a22223850c9a@opensource.wdc.com>
 <c8ef76be-c285-c797-5bdb-3a960821048b@opensource.wdc.com>
 <ddc88fa1-5aaa-4123-e43b-18dc37f477e9@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ddc88fa1-5aaa-4123-e43b-18dc37f477e9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/28/23 02:23, Bart Van Assche wrote:
> A summary of my concerns is as follows:
> * The current I/O priority levels (RT, BE, IDLE) apply to all block 
> devices. IOPRIO_CLASS_DL is only supported by certain block devices 
> (some but not all SCSI harddisks). This forces applications to check the 
> capabilities of the storage device before it can be decided whether or 
> not IOPRIO_CLASS_DL can be used. This is not something applications 
> should do but something the kernel should do. Additionally, if multiple 
> dm devices are stacked on top of the block device driver, like in 
> Android, it becomes even more cumbersome to check whether or not the 
> block device supports CDL.

Yes, RT, BE and IDLE apply to all block devices. And so does CDL in the sense
that if a user specifies the CDL class for IOs to a device that does not support
CDL, then nothing special will happen. There will be no differentiation of the
IOs. That *exactly* what happens when using RT, BE or IDLE with the none
scheduler (e.g. default nvme setup). And the same remark applies to RT class
mapping to ATA NCQ priority feature: the user needs to check the device to know
if that will happen, *and* also needs to turn on that feature for that mapping
to be effective.

The levels of the CDL priority class are also very well defined: they map to the
CDL descriptors defined on the drive, which are consultable by the user through
sysfs (no special tools needed), so easily discoverable.

As for DM devices, these have no scheduler. So any processing of a priority
class by a DM target driver is that driver responsibility. Initially, all that
happens is the block layer passing on that information through the stack with
the BIOs. That's it. Real action may happen once the physical block device is
reached with the IO scheduler for that device, if one is set.

At that level, none scheduler is of no concern, nothing will happen. Kyber also
ignores priorities. We are left with only bfq and mq-deadline. The latter only
cares about the priority class, ignoring levels. bfq does act on both class and
level.

IOPRIO_CLASS_DL is equal to 4, so strictly speaking, is of lower priority than
the IDLE class if you want to consider it as part of that ordering. But we
defined it as a different class to allow *not* having to do that. IO schedulers
can be modified to ignore that priority class for now, mapping it to say the
default BE class for instance. Our current patch set maps the CDL class to the
RT class for the schedulers, as that made most sense given the time-sensitive
nature of CDL workloads. But we can change that to actually let the scheduler
decide if you want. There are no other changes in the block layer that have or
need special handling of the CDL class. All very clean in my opinion, no special
conditions for that feature. No additional "if" in the hot path, no overhead added.

> * For the RT, BE and IDLE classes, it is well defined which priority 
> number represents a high priority and which priority number represents a 
> low priority. For CDL, only the drive knows the priority details. I 
> think that application software should be able to select a DL priority 
> without having to read the CDL configuration first.

The levels of the CDL priority class are also very well defined: they map to the
CDL descriptors defined on the drive, which are consultable by the user through
sysfs (no special tools needed), so easily discoverable. And unless we restrict
how CDL descriptors can be defined, which I explained in my previous email is
not desirable at all, we cannot and should not try to order levels in some sort
of priority semantic. CDL semantic does not define directly a priority level,
only time limits, which may or may not be ordered, depending on the limits
definitions.

As Niklas pointed out, this is not a "generic" feature that any random
application can magically use without modifications. The application must be
aware of what CDL is and if how the descriptors are. And for 99.99% of the use
cases, the CDL descriptors will be defined in a way usefull for that
application. There is no magic generic set of descriptors defined by default.
Though a simple set of increasing time limits that can be cleanly mapped to
priority levels. A system administrator is free to do that for the system drives
if that is what the running applications expect. CDL is a very flexible feature
that can cover a lot of use cases. Trying to shoehorn in into the legacy/classic
priority semantic framework would only restrict its usefulness.

> I hope that I have it made it clear that I think that the proposed user 
> space API will be very painful to use for application developers.

I completely disagree. Reusing the prio class/level API made it easy to allow
applications to use the feature. fio support for CDL requires exactly *one line*
change, to allow for the CDL class number 4. That's it. From there, one can use
the --cmdprio_class=4 nd --cmdprio=idx options to exercise a drive. The value of
"idx" here of course depends on how the descriptors are set on the drive. But
back to the point above. This depends on the application goals and the
descriptors are set accordingly for that goal. There is no real discovery needed
by the application. The application expect a certain set of CDL limits for its
use case, and checking that this set is the one currently defined on the drive
is easy to do from an application with the sysfs interface we added.

Many users out there have deployed and using applications taking advantage of
ATA NCQ priority feature, using class RT for high priority IOs. The new CDL
class does not require many application changes to be enabled for next gen
drives that will have CDL.

> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

