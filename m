Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC997C27C76
	for <linux-ide@archiver.kernel.org>; Thu, 26 Jan 2023 00:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAZAYU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Jan 2023 19:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAZAYT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2023 19:24:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD215CBF
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2023 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674692658; x=1706228658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frjvExlbaFW8o5bPWpgdAwANx+J3RblfsBG77uw8j2M=;
  b=az9RsOTST/fTOhTFUzHkrVOfUh+QzUQk8wpOJeabvrIK2zAbeykBNH2v
   YBzikoEa6c8UEbsnbkl0TUgxsmIaDdI6rQIyUUHcJRZ0qRmaWsF5bPIom
   wqY3oS3q9k8I4upnNBTJiB81yShF3UcnR2gBn77RKdSV6HuNj3IgROUiL
   Q4as20gWezQ7sDpxr2fVPihFZyYYOgBmO8+qjU3JVlgIOF7tvqU0gNCF9
   oaUVVtCVnBp4YJFhYeivniC3pEotYn1JPwmN6MEDiFyqx1n7M8+iJ/ASD
   9VLvN4n5hoUa/b9/7bwP4PYrweb+S2oGdcAWGLtqGI3GXwSlgNostBOSr
   w==;
X-IronPort-AV: E=Sophos;i="5.97,246,1669046400"; 
   d="scan'208";a="333749642"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2023 08:24:16 +0800
IronPort-SDR: rWbA5+4Mv9/XnZhsY+NSXL6jwIYHodW8S6Q3q/MQbytiS2ieJse/rNg1Q3H/8KBFptpiWWnC0Z
 wZzW1UbrtyoGAWyyVphYouQqIMJIZP7iDU5/uWTF7a7HzrWS38ejG5BLEia9BD1dW0Q6UwV1sc
 ZbXYF2z/YzOoUTMsYTmEU4PfIV8Al0h+jbS9gVXa3DnKb8iPH+t3EcInJLH6iAR1zQzdCVy/rS
 QjxuOHXnEO88/BNEjeSFxpS2BsGtx3QWi+ga0vjFeovIMEkUkR8cvHawsVdhzjPS/BsdB4lrYi
 eSM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2023 15:36:03 -0800
IronPort-SDR: r0AMbBTXzw1vcvmTIuO8iwdwin8WSh0/h3NMnx5IAkhdLFI77sFREqCreVzuzg4ZoaYqdHyzrP
 B4c5hJCNtClR8361Rsc5Q5I+SMO488csrgP2TYL0rAOtzlSbAoUEskTsaQmxqZJG/jKbZ/5Nte
 ITXdpmfUhpuEVG3INavEYN5X9UOaCTYV49CTi08Kei4GhWOacrJmGc70vY5VdEc8DZnm4Go47J
 wU4nyTcbV7aNT5xx7r3VijgmPUHqZAjmGIG2X1I9keUq1Nte+n4UUpN5MaEcLL0aoZz0ksl/y2
 II8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2023 16:24:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P2M0022wzz1RwqL
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2023 16:24:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674692655; x=1677284656; bh=frjvExlbaFW8o5bPWpgdAwANx+J3RblfsBG
        77uw8j2M=; b=NZtGhkDmEPdo3Cq7O2n8ETYp3HiihA/cXLBWP06p/wWj5L9/EpW
        ke2p7bLbP5+7HsrDgE3x1qe4/5cDVUaNg89DNyh7/EKSevFJh9aHzQJrq1ZL5e1L
        qzzQRhZygTXHRqYc/m9QXyAIwJYtPrgoMlkXxIAD6mPFg8yo+F6Dq4c9XnvFLrfh
        rmhVG0+kVnRRXxERJiaYfAGLer2sEcm7s0ImMcJpBd31gntY70qiZDszTlw1Lp4+
        IqRMT5zOPqlSgVgNyE4FxjEqhpBcGuA/BmbKA+Yemr/qjLPxFGNP36ON42SRPGTQ
        +u/YF5PZmnHeIvaFS8BBh5j8JIoXcrPNtTA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FpMcBsr02Kcm for <linux-ide@vger.kernel.org>;
        Wed, 25 Jan 2023 16:24:15 -0800 (PST)
Received: from [10.89.81.12] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P2Lzx5GMHz1RvLy;
        Wed, 25 Jan 2023 16:24:13 -0800 (PST)
Message-ID: <86de1e78-0ff2-be70-f592-673bce76e5ac@opensource.wdc.com>
Date:   Thu, 26 Jan 2023 09:24:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-2-niklas.cassel@wdc.com>
 <bd0ce7ad-cf9e-a647-9b1e-cb36e7bbe30f@acm.org>
 <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
 <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
 <5066441f-e265-ed64-fa39-f77a931ab998@acm.org>
 <275993f1-f9e8-e7a8-e901-2f7d3a6bb501@opensource.wdc.com>
 <e8324901-7c18-153f-b47f-112a394832bd@acm.org> <Y9Gd0eI1t8V61yzO@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y9Gd0eI1t8V61yzO@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/01/26 6:23, Niklas Cassel wrote:
> On Wed, Jan 25, 2023 at 10:37:52AM -0800, Bart Van Assche wrote:
> 
> (snip)
> 
>> Hi Damien,
>>
>> The more I think about this, the more I'm convinced that it would be wrong
>> to introduce IOPRIO_CLASS_DL. Datacenters will have a mix of drives that
>> support CDL and drives that do not support CDL. It seems wrong to me to
>> make user space software responsible for figuring out whether or not the
>> drive supports CDL before it can be decided which I/O priority class should
>> be used. This is something the kernel should do instead of user space
>> software.
> 
> Well, if we take e.g. NCQ priority as an example, as that is probably
> the only device side I/O priority feature currently supported by the
> kernel.
> 
> If you want to use of NCQ priority, you need to first enable
> /sys/block/sdX/device/ncq_prio_enable
> and then submit I/O using IOPRIO_CLASS_RT, so I would argue the user
> already needs to know that a device supports device side I/O priority,
> if he wants to make use of it.

Yes, absolutely. In addition to this, NCQ high priority feature is optional. The
host-level RT class scheduling works the same way regardless of a SATA drive
supporting NCQ high priority or not. If ncq_prio_enable is not enabled (or not
supported), the scheduler still works as before. If ncq_prio_enable is set for a
drive that supports NCQ high prio, then the user gets the additional benefit of
*also* having the drive prioritize the commands from high-priority user IOs.

> For CDL there are 7 different limits for reads and 7 different
> limits for writes, these limits can be configured by the user.
> So the users that want to get most performance out of their drive
> will most likely analyze their workloads, and set the limits depending
> on how their workload actually looks like.
> 
> Bottom line is that heavy users of CDL will absolutely know how the CDL
> limits are configured in user space, as they will pick the correct CDL
> index (prio level) for the descriptor that they want to use for the
> specific I/O that they are doing. An ioscheduler will most likely be
> disabled.

Yes. And for cases where we still need an IO scheduler (e.g. SMR with
mq-deadline), we really cannot use the priority level (CDL index) as a
meaningful information to make request scheduling decisions because I think it
is simply impossible to reliably define a "priority" order for the 7 read and
write descriptors. We cannot map a set of 14 descriptors with a very large
possible number of variations to sorted array of priority-like levels.

> (For CDL, the limit is from the time the command is submitted to the device,
> so from the device's PoV, it does not really matter if a command is queued
> for a long time in a scheduler or not, but from an application PoV, it does
> not make sense to hold back a command for long if it e.g. has a short limit.)
> 
> 
> If we were to reuse IOPRIO_CLASS_RT, then I guess the best option would be
> to have something like:
> 
> $ cat /sys/block/sdX/device/rt_prio_backend
> [none] ncq-prio cdl

No need for this. We can keep the existing ncq_prio_enable and the proposed
duration_limits/enable sysfs attributes. The user cannot enable both at the same
time with our patches. So if the user enables ncq_prio_enable, then it will get
high priority NCQ commands mapping for any level of the RT class. If
duration_limits/enable is set, then the user will get CDL scheduling of commands
on the drive.

But again, the difficulty with this overloading is that we *cannot* implement a
solid level-based scheduling in IO schedulers because ordering the CDLs in a
meaningful way is impossible. So BFQ handling of the RT class would likely not
result in the most ideal scheduling (that would depend heavily on how the CDL
descriptors are defined on the drive). Hence my reluctance to overload the RT
class for CDL.

> Devices that does not support ncq-prio or cdl,
> e.g. currently NVMe, would just have none
> (i.e. RT simply means higher host side priority (if a scheduler is used)).

Yes. Exactly.

> SCSI would then have none and cdl
> (for SCSI devices supporting CDL.)
> 
> ATA would have none, ncq-prio and cdl.
> (for ATA devices supporting CDL.)
> 
> That would theoretically avoid another ioprio class, but like I've just
> explained, a user space application making use of CDL would for sure know
> how the descriptors look like anyway, so I'm not sure if there is an actual
> benefit of doing it this way over simply having a IOPRIO_CLASS_DL.

Agree. And as explained above, I think that reusing the RT class creates more
problems than the only apparent simplification it is.

> I guess the only benefit would be that we would avoid introducing another
> I/O priority class (at the expense of additional complexity elsewhere).

Yes. And I think that the added complexity to correctly handle the overloaded RT
class is too much. RT class has been around for a long time for host-level IO
priority scheduling. Let's not break it in weird ways.

We certainly can work on improving handling of IOPRIO_CLASS_DL in IO schedulers.
But in my opinion, that can be done later, after this initial series introducing
CDL support is applied.

-- 
Damien Le Moal
Western Digital Research

