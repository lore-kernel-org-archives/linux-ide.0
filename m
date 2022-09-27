Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1369C07E9D
	for <linux-ide@archiver.kernel.org>; Tue, 27 Sep 2022 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiI0Ot6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiI0Otc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Sep 2022 10:49:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC664B48C
        for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2022 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664290042; x=1695826042;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eIjFG2QjGniZp+G5vDqdUNv6hmPMAe5D7wALVX7IDMc=;
  b=rqw46ef8MWoh5fHWUEarAKE6ri38YJ+34PW3y7joq8tjxAEMKC+IHPL1
   kU846fZ2hfmR1BM9d0DB4A+1C2UzlHZYsQNQbIyDMjeUAPBKTrsDeeWRi
   Yh7pTUy0uPu4FFepZlrTI6GFF2mc0NI7CO2C77ToAsIYe1tlSJfY+YXmu
   oj+4rvU73AjcN0elPDlpDAH1C3nDgA+9G99Tw7XnHiDidbQwZCZyQwU+v
   8FqOnVPAYi186x38aJ8euK+cGPzWOxlUt+fwz624pEUFlynZJ2JNDxH3X
   WBJbfyc1ETY6GjKYmuCc4pCzGZKzhfVSpWa+uxrWj3VTqUSjhkEY3SQqv
   g==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654531200"; 
   d="scan'208";a="212806028"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 22:47:19 +0800
IronPort-SDR: Z0twSa8dOUOe5lDrS4T6ENblModQ1crgc+yEv7e3/w2WFZhClIPJeYxzbwQyESuq3483my12me
 Yq8OliQQl7bDCbcg5/BRZ8nuUg+m6slNRqkqUpSST9zWA5EylG8KRoUCUwMEH4Ry7QR2FWqqTL
 TpsJ/GczOMxEy1xM8OMFdF1rjPJoemdNRsT2DVP9JnJCDRGbo1AP96iBNOP9u4eEkjePqb8Kxc
 T+6XREvhg7MkqEyFR8oQsjGH04J1I423eEuofuooPO/0r7nJlIdu66QPqjmwgjpNeqPxKTYSGk
 2KQlifPwJNGLM0ekwVpHlbrI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 07:07:16 -0700
IronPort-SDR: j3+3KRQFCa5Q82zIfdcaUFeXXKmRfhBzO+348j09JUJ9WrraVHYp+AZK3Wim13+Rwyh9yYzhjM
 5jWdLEY3enB7ip4AEGWcXCQglhDOUMdYA1b+ui72yX6U5jsUzhP3b79FAxuiCQEKKt9YcKubCC
 iAbE9dKOs3MjY+a4J0zsRu5AT0rHUOzu3ZClc6E828uFg2wS8eKeZMUYp88twPp3YkpsW0lqVf
 35NpA7+sSkGJ2E9VOBOocSwiKN107QmWOGqWAMBDXYJUBfTlFWMFmRUdEDO3S2h5LOF6BlFTFx
 4to=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 07:47:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4McMsg0xXyz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2022 07:47:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664290038; x=1666882039; bh=eIjFG2QjGniZp+G5vDqdUNv6hmPMAe5D7wA
        LVX7IDMc=; b=LwzVBpZx1CesCw1BT/Gk0y+8ZW3sjem6IfiSnvNK9JObswYPWqj
        SdgajpXBLDXZX5cWeRsOUr14K0ZK6YDSZ2ERFvbWVy+7eaOvjIjLiscJ6ERcgsMK
        jZ/wkQ6UdkYRaH6gDB16wtbePpY5vZD7SeGv9zM5a1dqR/FsP/yuK5r8TNEtCRot
        UGsHxS3UpoV/p7BQX6yauuv19fIAufVwlhX/lj3U08CxRY3igbsaPnIdYLHit/Fn
        TsZ73K81w9sp981bgxlO5gSMPXQOfW5h6hM6oCrUYUJS7EfeFFK+jSchEHeCwTw9
        t0+9KZtNYkrWTYFxXBE3GRsyBhdExEUnQZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VmnfZABQjnWj for <linux-ide@vger.kernel.org>;
        Tue, 27 Sep 2022 07:47:18 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4McMsf09ZYz1RvLy;
        Tue, 27 Sep 2022 07:47:17 -0700 (PDT)
Message-ID: <b69343eb-617f-04bd-df07-b62a445fbe77@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 23:47:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] ata: libata-sata: Fix device queue depth control
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220925230817.91542-1-damien.lemoal@opensource.wdc.com>
 <20220925230817.91542-3-damien.lemoal@opensource.wdc.com>
 <5bab7eb9-7b91-8c06-e8c3-f2076bac78dc@huawei.com>
 <92d87d6c-9bd0-0cf9-1ced-bac104ea2d66@opensource.wdc.com>
 <f3e90970-5153-f6bc-5be8-c2c379be0d7f@huawei.com>
 <60721293-14e2-98be-37af-ce7c1b227f44@opensource.wdc.com>
 <d2c4a043-e998-db98-1fe1-47b53516d7cc@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d2c4a043-e998-db98-1fe1-47b53516d7cc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/27/22 18:47, John Garry wrote:
> On 27/09/2022 10:28, Damien Le Moal wrote:
>>> Sure, we can use sas_to_ata_dev() to get the ata_device.
>>>
>>> I am just suggesting my way such that we can have a consistent method to
>>> get the ata_device between all libata users and we don't need to change
>>> the ata_change_queue_depth() interface. It would be something like:
>>>
>>> struct ata_device *ata_scsi_find_dev(struct ata_port *ap, const struct
>>> scsi_device *scsidev)
>>> {
>>> 	struct ata_link *link;
>>> 	struct ata_device *dev;
>>>
>>> 	ata_for_each_link(link, ap, EDGE) {
>>> 		ata_for_each_dev(dev, link, ENABLED) {
>>> 			if (scsidev == dev->sdev)
>>> 				return dev;
>>> 		}
>>> 	}
>>> 	// todo: check pmp
>>> 	return NULL;
>>> }
>> I see. Need to think about this one... This may also unify the pmp case.
>> Are you OK with the patch as is though ? 
> 
> I'm ok with your patchset, but let me test it and get back to you later 
> today.
> 
> We can improve with something
>> like the above on top later. Really need to fix that qd setting as it is
>> causing problems for testing devices with/without ncq commands.
> 
> Out of curiosity, are you considering your patchset for 6.0?

Yes. But I can send it for 6.1 with cc: stable too.

> 
>>
> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

