Return-Path: <SRS0=gGcN=7M=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D87C433E0
	for <linux-ide@archiver.kernel.org>; Sat, 30 May 2020 06:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228AE2073B
	for <linux-ide@archiver.kernel.org>; Sat, 30 May 2020 06:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgE3GSd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 30 May 2020 02:18:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728657AbgE3GSd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 30 May 2020 02:18:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC5D7FB11EB59DE3554F;
        Sat, 30 May 2020 14:18:30 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.224) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 30 May 2020
 14:18:28 +0800
Subject: Re: [PATCH] scsi/libata: Fix usage of page address by page_address in
 ata_scsi_mode_select_xlat function
To:     Christoph Hellwig <hch@infradead.org>
References: <20200529063251.14665-1-yebin10@huawei.com>
 <20200529124807.GA23222@infradead.org>
CC:     <linux-ide@vger.kernel.org>, <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <5ED1FAB3.6020609@huawei.com>
Date:   Sat, 30 May 2020 14:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200529124807.GA23222@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.224]
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2020/5/29 20:48, Christoph Hellwig wrote:
> On Fri, May 29, 2020 at 02:32:51PM +0800, Ye Bin wrote:
>> index 435781a16875..d674184ed835 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3723,7 +3723,7 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>>   	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>>   		goto invalid_param_len;
>>   
>> -	p = page_address(sg_page(scsi_sglist(scmd)));
>> +	p = page_address(sg_page(scsi_sglist(scmd))) + scsi_sglist(scmd)->offset;
> This also looks completely buggy on highmem systems and really needs to
> use a kmap_atomic.
> .
Thank you  for your reply.
  As in sg_scsi_ioctl  function allocate bio memory by kzalloc. Maybe 
it's better to give
the caller more freedom, and at the same time, it's more robust.
>


