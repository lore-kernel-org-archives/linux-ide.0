Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1985FC4321E
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 10:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKHKth (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiKHKtN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 05:49:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5843AD1
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 02:49:04 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N64b72jVhzmVjF;
        Tue,  8 Nov 2022 18:48:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:49:03 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:49:02 +0800
Subject: Re: [PATCH v2 4/4] ata: libata-transport: fix error handling in
 ata_tdev_add()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20221108075209.2434888-1-yangyingliang@huawei.com>
 <20221108075209.2434888-5-yangyingliang@huawei.com>
 <ad7f4ad1-cded-8a09-6a7e-da6b91ee04b2@opensource.wdc.com>
 <e519e85c-1253-6c09-ddab-bc13a4634aba@huawei.com>
 <19fc6795-9322-6228-abc5-45a70d2705ee@opensource.wdc.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
CC:     <yangyingliang@huawei.com>
Message-ID: <dc48e8d3-15fc-e42b-95c1-87c60ed71c07@huawei.com>
Date:   Tue, 8 Nov 2022 18:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <19fc6795-9322-6228-abc5-45a70d2705ee@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2022/11/8 17:33, Damien Le Moal wrote:
> On 11/8/22 18:27, Yang Yingliang wrote:
>> Hi,
>>
>> On 2022/11/8 16:03, Damien Le Moal wrote:
>>> On 11/8/22 16:52, Yang Yingliang wrote:
>>>> In ata_tdev_add(), the return value of transport_add_device() is not
>>>> checked. As a result, another error after that function call leads to
>>>> a kernel crash (null-ptr-deref) because transport_remove_device() is
>>>> called to remove a device that was not added.
>>> This was the error pattern for the previous 2 cases, but not for this
>>> one. For this case, transport_configure_device() would be called for a
>> Did you mean transport_remove_device() ?
>>> device that was not added, no ? so where does the backtrace below come
>>> from ? It does not correspond to the code this patch is changing.
>> Yes, it's correspond, ata_tdev_delete() is inlined, so it doesn't show
>> in the call traces.
> I meant to say that the commit message explanation does not match at all
> the cod echange. Totally unrelated explanation and functions mentioned.
> Please fix that first and simply put the kdump trace you see if there is
> an issue when calling transport_configure_device() after
> transport_add_device() failed.
This patch handled return value of transport_add_device() and go to 
error path,
and the previous case handle it in the same way, I am not sure what's 
the difference
in them.

The only difference is releasing resource in error path, this patch 
calls ata_tdev_free()
to free device, and the other two cases call put_device(), did you mean 
this part?

All three cases will call transport_configure_device() after 
transport_add_device() failed,
there is no error trace, the error happened while calling 
transport_remove_device().

If I missed something, please correct me.

Thanks,
Yang
>
>> I make ata_tdev_delete() noinline and reproduced it again,
>> ata_tdev_delete()
>> is showed in the call trace:
>>
>> [  140.120952][T13603] Call trace:
>> [  140.124359][T13603]  device_del+0x48/0x3a0
>> [  140.128713][T13603] attribute_container_class_device_del+0x28/0x40
>> [  140.135226][T13603]  transport_remove_classdev+0x60/0x7c
>> [  140.140783][T13603] attribute_container_device_trigger+0x118/0x120
>> [  140.147289][T13603]  transport_remove_device+0x20/0x30
>> [  140.152665][T13603]  ata_tdev_delete+0x24/0x50 [libata]
>> [  140.158152][T13603]  ata_tlink_delete+0x40/0xa0 [libata]
>> [  140.163724][T13603]  ata_tport_delete+0x2c/0x60 [libata]
>> [  140.169294][T13603]  ata_port_detach+0x148/0x1b0 [libata]
>> [  140.174951][T13603]  ata_pci_remove_one+0x50/0x80 [libata]
>> [  140.180689][T13603]  ahci_remove_one+0x4c/0x8c [ahci]
>>
>> Thanks,
>> Yang
>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>> 00000000000000d0
>>>> CPU: 61 PID: 13969 Comm: rmmod Kdump: loaded Tainted: G
>>>> W          6.1.0-rc3+ #13
>>>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : device_del+0x48/0x39c
>>>> lr : device_del+0x44/0x39c
>>>> Call trace:
>>>>    device_del+0x48/0x39c
>>>>    attribute_container_class_device_del+0x28/0x40
>>>>    transport_remove_classdev+0x60/0x7c
>>>>    attribute_container_device_trigger+0x118/0x120
>>>>    transport_remove_device+0x20/0x30
>>>>    ata_tlink_delete+0x4c/0xb0 [libata]
>>>>    ata_tport_delete+0x2c/0x60 [libata]
>>>>    ata_port_detach+0x148/0x1b0 [libata]
>>>>    ata_pci_remove_one+0x50/0x80 [libata]
>>>>    ahci_remove_one+0x4c/0x8c [ahci]
>>>>
>>>> Fix this by checking and handling return value of transport_add_device()
>>>> in ata_tdev_add().
>>>>
>>>> Fixes: d9027470b886 ("[libata] Add ATA transport class")
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>    drivers/ata/libata-transport.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ata/libata-transport.c
>>>> b/drivers/ata/libata-transport.c
>>>> index aac9336e8153..e4fb9d1b9b39 100644
>>>> --- a/drivers/ata/libata-transport.c
>>>> +++ b/drivers/ata/libata-transport.c
>>>> @@ -713,7 +713,13 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>>>>            return error;
>>>>        }
>>>>    -    transport_add_device(dev);
>>>> +    error = transport_add_device(dev);
>>>> +    if (error) {
>>>> +        device_del(dev);
>>>> +        ata_tdev_free(ata_dev);
>>>> +        return error;
>>>> +    }
>>>> +
>>>>        transport_configure_device(dev);
>>>>        return 0;
>>>>    }
