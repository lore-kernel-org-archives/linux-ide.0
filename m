Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F6EC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 12:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjEWMlr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjEWMlq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 08:41:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F92126
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 05:41:44 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QQYmR6Lq2zsSSY;
        Tue, 23 May 2023 20:39:35 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:41:42 +0800
Subject: Re: [PATCH v2] ata: libata-scsi: Use correct device no in
 ata_find_dev()
From:   Jason Yan <yanaijie@huawei.com>
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
CC:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523023219.291253-1-dlemoal@kernel.org>
 <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
 <301a5198-9686-e3b5-74d8-4e5e85e6fc08@kernel.org>
 <cb2d18ed-2b61-6d92-96f4-4c84429ebe74@huawei.com>
Message-ID: <aa549609-b156-cdb2-1283-27a1a34d233c@huawei.com>
Date:   Tue, 23 May 2023 20:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cb2d18ed-2b61-6d92-96f4-4c84429ebe74@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/23 20:29, Jason Yan wrote:
> On 2023/5/23 19:52, Damien Le Moal wrote:
>>> I wonder if you can change the type of devno to 'unsigned int'? At a
>>> closer look I found the user can control this value and may pass in a
>>> bogus channel or id.
>>>
>>> proc_scsi_write
>>>       =>scsi_add_single_device
>>>           =>ata_scsi_user_scan
>>>               =>ata_find_dev
>> Reading more about scsi_add_single_device(), the comment says "Note: 
>> this seems
>> to be aimed exclusively at SCSI parallel busses.". So I don't think we 
>> should
>> worry about it. But then I also do not understand why libata is wired 
>> to this at
>> all. Cannot have ATA device on a parallel SCSI bus...
> 
> The comment is kind of obsolete. It is not limited to SCSI parallel 
> busses only.
> 
>>
>> On my system, I cannot get
>>
>> echo "scsi add-single-device X 0 100 0" >/proc/scsi/scsi
>>
>> to do anything and so I do not see how ata_scsi_user_scan can ever be 
>> called...
>>
> 
> Did you enabled CONFIG_SCSI_PROC_FS ? I started a qemu and it still works.

Forgot to say that if you do not want to enable this config, you can 
still do this instead:

echo "0 0 0" > /sys/class/scsi_host/host1/scan

