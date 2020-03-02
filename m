Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB512C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC022467E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EnKaUIDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCBSH7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:07:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60702 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbgCBSH6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:07:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302180756euoutp01169cb5e1f02222fec98150182b6cdaa6~4jvrMhI6w2590625906euoutp01H
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:07:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302180756euoutp01169cb5e1f02222fec98150182b6cdaa6~4jvrMhI6w2590625906euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583172476;
        bh=Svm72GR8hNY9dUBvhmhyggIhPiN2a9zV2VKGqHQlmsE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EnKaUIDhTv53zA82oJPJ/YBgdBgLKnmvwUkiCh/V87h8h5YKOHT3OC4B6NgQyoh8Q
         MiqAXDC4jca2MCPkAGiOhdpfy3VUZ0A6+DfFtNMQfmR9i4w1n55lZQxSPuvg6YQkOV
         QAMkH7TvgTUja6HRenTNS4OeSXmjsp+K5yV5CdA8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302180756eucas1p26f29d365ca09dcf2e995914d5489dcb2~4jvqz9q4j1371213712eucas1p2N;
        Mon,  2 Mar 2020 18:07:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.7D.60679.C7B4D5E5; Mon,  2
        Mar 2020 18:07:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302180756eucas1p29aee569249e084f628006daf6dc77db1~4jvqh41b31288212882eucas1p2-;
        Mon,  2 Mar 2020 18:07:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302180756eusmtrp2ccf4f5989e2b0c71b527b29b71e8919a~4jvqhVErq2560325603eusmtrp2C;
        Mon,  2 Mar 2020 18:07:56 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-9b-5e5d4b7c534f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.4C.08375.C7B4D5E5; Mon,  2
        Mar 2020 18:07:56 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302180755eusmtip1a33f72b457c83985ec84387fd9a1edba~4jvqQzpG31690216902eusmtip1Y;
        Mon,  2 Mar 2020 18:07:55 +0000 (GMT)
Subject: Re: [PATCH 24/42] libata-sff: drop DPRINTK for the HSM state
 machine
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
Message-ID: <9eafa67e-e4dc-b745-9471-391c2f0c28c7@samsung.com>
Date:   Mon, 2 Mar 2020 19:07:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a687fe23-2cab-0b2b-b9fc-8c0c617394c3@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7o13rFxBndeilisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugStjx5/brAWd
        khUrnp9laWDcJ9LFyMkhIWAisfT8P5YuRi4OIYEVjBIHd02Acr4wSqx+9BTK+cwo8XJjFztM
        y5S9/5khEssZJa6em84E4bwFct59ZwGpEhbwlzhw/TgTiM0mYCUxsX0VI4gtIqAk8bH9ENgk
        ZoEIiY0b1gLVcHDwCthJXFrKChJmEVCR2LrnGxuILQpU8unBYbA4r4CgxMmZT8DGcwrYSyxY
        3cECMUZc4taT+UwQtrzE9rdzwI6TEJjMLrFixQsWiKtdJO5teMQMYQtLvDq+BeobGYn/O+cz
        QTSsY5T42/ECqns7o8Tyyf/YIKqsJe6c+8UGcimzgKbE+l36EGFHiV+LX4GFJQT4JG68FYQ4
        gk9i0rbpzBBhXomONiGIajWJDcs2sMGs7dq5knkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGpp
        cW56arFRXmq5XnFibnFpXrpecn7uJkZgYjn97/iXHYy7/iQdYhTgYFTi4Q1gjo0TYk0sK67M
        PcQowcGsJMLryxkdJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgs
        EwenVAOjGHOQkY6MvK5ysG3/haTda9+9Df3Mtffm8vkdryzv/qz3lFl3vXzF0ZVZHxRY3li6
        1T1Y+ixtH4v73Nap+sc/7xW9qN1qG+97T6gz8yLj3DVxa12a2Q4UK7/PPxQzb9PDtccMdor+
        YdTJXnZJuuz3RLu0I2H5j+qyv5645LDBQfxA1PIjk38vUmIpzkg01GIuKk4EAKB72tsoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7o13rFxBk2tbBar7/azWexZNInJ
        4tiOR0wWv5YfZXRg8bh8ttRj06pONo/Np6s9Pm+SC2CJ0rMpyi8tSVXIyC8usVWKNrQw0jO0
        tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY8ec2a0GnZMWK52dZGhj3iXQxcnJICJhI
        TNn7n7mLkYtDSGApo8S+KRfYuhg5gBIyEsfXl0HUCEv8udbFBlHzmlHi2+O9bCAJYQFfia5L
        q5lAbDYBK4mJ7asYQWwRASWJj+2H2EFsZoEIie5XZ8DqhQQeM0ps35IIMp9XwE7i0lJWkDCL
        gIrE1j3fwEpEgcoP75gFNoZXQFDi5MwnLCA2p4C9xILVHSwQI9Ul/sy7xAxhi0vcejKfCcKW
        l9j+dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2jb
        sZ+bdzBe2hh8iFGAg1GJhzeAOTZOiDWxrLgy9xCjBAezkgivL2d0nBBvSmJlVWpRfnxRaU5q
        8SFGU6DnJjJLiSbnAyM8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMH
        p1QDY8SllZJyLJW9DVWrb7m5mB8PXjfXu1CLU1b4701rllfnI//s71C6orRVZpf11SPT/z37
        4ndm6okt7tvKDCQY7eJKTiZsyGwN32XYNX1mnS8779voc2s2X+Iw+LOXlSvqS9Oy3Se+uHry
        SkjeObp2ifCdbw9YNY+LKbKbVn1se+wT92budZ5fiUosxRmJhlrMRcWJAOTUNHG4AgAA
X-CMS-MailID: 20200302180756eucas1p29aee569249e084f628006daf6dc77db1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7@eucas1p1.samsung.com>
        <20200213095412.23773-25-hare@suse.de>
        <a687fe23-2cab-0b2b-b9fc-8c0c617394c3@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 3/2/20 6:57 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 2/13/20 10:53 AM, Hannes Reinecke wrote:
>> The information is now logged with tracepoints, so the DPRINTK
>> calls can be dropped.
> 
> The addition of trace_*() statements should be in patch #23 and
> this patch should contain only the removal of no longer needed
> DPRINTK() instances.
> 
> [ Just like it has been done in reset tracepoints conversion. ]

Alternatively:

(since here are only few DPRINTK() instances, unlike the reset
tracepoints conversion)

please merge this patch into patch #23 (just like it was in
the previous iteration, sorry for the confusion).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/ata/libata-sff.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 1078b621d47b..f6a54b574b25 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -660,7 +660,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>>  	offset %= PAGE_SIZE;
>>  
>> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
>> +	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
>>  
>>  	/* do the actual data transfer */
>>  	buf = kmap_atomic(page);
>> @@ -723,7 +723,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
>>  static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>>  {
>>  	/* send SCSI cdb */
>> -	DPRINTK("send cdb\n");
>> +	trace_atapi_send_cdb(qc, 0, qc->dev->cdb_len);
>>  	WARN_ON_ONCE(qc->dev->cdb_len < 12);
>>  
>>  	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
>> @@ -794,7 +794,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
>>  	/* don't cross page boundaries */
>>  	count = min(count, (unsigned int)PAGE_SIZE - offset);
>>  
>> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
>> +	trace_atapi_pio_transfer_data(qc, offset, count);
>>  
>>  	/* do the actual data transfer */
>>  	buf = kmap_atomic(page);
>> @@ -976,8 +976,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>>  	WARN_ON_ONCE(in_wq != ata_hsm_ok_in_wq(ap, qc));
>>  
>>  fsm_start:
>> -	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
>> -		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
>> +	trace_ata_sff_hsm_state(qc, status);
>>  
>>  	switch (ap->hsm_task_state) {
>>  	case HSM_ST_FIRST:
>> @@ -1178,8 +1177,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>>  		}
>>  
>>  		/* no more data to transfer */
>> -		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
>> -			ap->print_id, qc->dev->devno, status);
>> +		trace_ata_sff_hsm_command_complete(qc, status);
>>  
>>  		WARN_ON_ONCE(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
>>  

