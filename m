Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636FDC7EE29
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 10:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjEWKWe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjEWKWb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 06:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBFB18C
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 03:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 918C663056
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 10:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866BDC433D2;
        Tue, 23 May 2023 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684837349;
        bh=7f43QGRVafYVM5O4WvlxBwlcasQOd9AZ9UA+Xk+tknw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qMrFHcsPAoftcJy/2VsVODrAovpqpQSgdLMLRf3wndpNKlBCwLS542Vi3Bqh/UIMj
         O/m/Yvaq7Gbkwo88sEJ0F6dViydruR1MEgEGv89bvyuyQZMwYp69KXoxCmoJsU1rlG
         7lYgdMz9pMLjVgBSndL53KJSgPoTPdOwc6E/lD8SlRfIfCQG39AQ/x+D/fBJezDH+a
         lRvjAwic9tJpulGMyNtyEO7Buld8S81xxiDFpxKiwBekBcTZSeTOfreU2KLWm9V4W0
         hu9gdJ0hvLgl8KioTqJ04O3Qr59l/NqRmtFSDh/R8Htdmb1D+BsxMGXvnDjAKBsv8c
         kheiK6HsfP0JA==
Message-ID: <af5fffde-252a-b18f-d061-1e2b5122b75f@kernel.org>
Date:   Tue, 23 May 2023 19:22:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org
Cc:     Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
 <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
 <4a48966b-c193-06c7-54b0-d175a9009de9@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4a48966b-c193-06c7-54b0-d175a9009de9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/23/23 18:23, Jason Yan wrote:
> On 2023/5/23 16:29, John Garry wrote:
>> On 23/05/2023 09:04, Damien Le Moal wrote:
>>> For devices not attached to a port multiplier and managed directly by
>>> libata, the device number passed to ata_find_dev() must always be lower
>>> than the maximum number of devices returned by ata_link_max_devices().
>>> That is 1 for SATA devices or 2 for an IDE link with master+slave
>>> devices. This device number is the scsi device ID which matches these
>>> constraint as the ID are generated per port and so never exceed the
>>> link maximum.
>>>
>>> However, for libsas managed devices, scsi device IDs are assigned per
>>> scsi host, leading to device IDs for SATA devices that can be well in
>>> excess of libata per-link maximum number of devices. This results in
>>> ata_find_dev() always returning NULL for libsas managed devices except
>>> for the first device of the host with ID (device number) 0. This issue
>>> is visible by executing hdparm command, which fails:
>>>
>>> hdparm -i /dev/sdX
>>> /dev/sdX:
>>>    HDIO_GET_IDENTITY failed: No message of desired type
>>>
>>> Fix this by rewriting ata_find_dev() to ignore the device number for
>>> non-pmp attached devices with a link with at most 1 device, that is SATA
>>> devices on SATA ports. For these, device number 0 is always used to
>>> return the correct ata_device struct of the port link. This change
>>> excludes IDE master/slave setups (maximum number of devices per link
>>> is 2) and port-multiplier attached devices. Also, to be consistant with
>>> the fact that scsi device IDs and channel numbers used as device numbers
>>> are both unsigned int, change the devno argument of ata_find_dev() to
>>> unsinged int.
>>>
>>> Reported-by: Xingui Yang <yangxingui@huawei.com>
>>> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> Hi Damien & John,
> 
> I think we may missed something. What about if we do this:
> 
> echo "scsi add-single-device 0 0 100 0" >/proc/scsi/scsi
> 
> Then in ata_scsi_user_scan() we will return device "0 0 0 0 " and rescan 
> this device, which is wrong?

On first review, I think it is OK because there is one scsi host per port. So
when ata_scsi_user_scan() with ID 100, the shost passed to it corresponds to an
ata_port that is for that device ID 100, and then ata_find_dev() changing devno
from 100 to 0 is correct.

But that "one shost == one port" seems to be correct only for pure libata, that
is, AHCI and other SATA/PATA adapters. For libsas, I am not so sure: the initial
"ap = ata_shost_to_port(shost)" in ata_scsi_user_scan() seems totally bogus for
the libsas case, while it is clearly OK for AHCI... Hmm... Needs more digging.


> 
> Thanks,
> Jason

-- 
Damien Le Moal
Western Digital Research

