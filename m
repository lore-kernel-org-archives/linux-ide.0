Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E5C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  6 Apr 2022 22:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiDFWaa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDFWa3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2022 18:30:29 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9A21D070
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649284111; x=1680820111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yg83I+kC50RMwR1HRe5Jn4Gkhm6UoCyb88aTHqcfQX4=;
  b=M3FfLAaJCx87mjF3hkxZ2fjmqord/PKP4/wQKe8qSk9Y89BCcYsA/Nbe
   5M6H/mr/B5GsPa+9CqEevmfLSRnIvXGLGpjlMAsw6jU/BPclRLbeKPWXU
   8XwGTObbTsIBQxS0sBeuZRa0yCDdiHUIpmYbUNvHOuhebwJUAVDYytr79
   4TgwUaz6olGC3QD3dCUJFOPVyC3NSabXlJXXxqIUJy+cQitYX9TbGAm4P
   6AqdN/RNm39kX5BvgKz11vwEAt4WlMQ+By9vAKCnML1RMNMiiPB3/3qAr
   /SDKZgFJhSBAV/QqAQ88hycklWY/dC6AuGQKegf3vZPDp1rePd9HTvm/k
   w==;
X-IronPort-AV: E=Sophos;i="5.90,240,1643644800"; 
   d="scan'208";a="196154441"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 06:28:30 +0800
IronPort-SDR: cqqXNOu9oCZeubIx8LiitOK+bjXr/c3M3Y+w/GNhgsaxS/uTvqajTaVG31vpRsoY4n9fFk+u0y
 rXh1Ej3hoL94QCUgrckYWOTuxGac5gyXLCnshC33kaAL1xMsSXGVtm9vI+8uXXZ4PAtjju9ggu
 iVH3tyUIhQOPG/542XulDqrHAvBRa1BGbJ0BLL5AMsTBUGfer4gt28WnGbF6QXDvQrQgqyfQBD
 c2a6JFluDqrL2wdna+HVzLc6vWApxkQaQgpdiBADHjSADWCnpXqfcn/rtKYxFTZks7XILzD5LL
 m1YzOH/LFdhXQbc0yp8R4Ddl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 14:59:12 -0700
IronPort-SDR: fQq4ST8J3a1exP5FKJcSVkUUaPPDAKNt/5Hux51H+8FxIssUFLZTAfBOqbF6ep28pnroX7Ag73
 737aecsHlyIh5ot9pJgKCS1FiV+dQw+vn7lkqa6hXZPgeeXKzVKy8NoHVFPoTJCltdDrj47u7p
 NkCfnScxb8mosT1qij5BXB1EcDnuGepH2TwHVL6LM3WVKXUjLRxcY1z4QPRYDnSFPsmtkYyuDx
 2so3O9kg0zq0nn8kVTeiqj/ktiuArnq2i4JnTwh9kxDEzSDq+86t5Zi3531ao/IRTra6o+bjZH
 pbg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 15:28:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYfL648LDz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 15:28:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649284110; x=1651876111; bh=Yg83I+kC50RMwR1HRe5Jn4Gkhm6UoCyb88a
        THqcfQX4=; b=oWUbqePfU5rE68CCMr4kKzIzl4+YlyOZ4kJexsSm+d/yBECGtbx
        ixe84XRmjeI8ggZ2ZFlCOVKJAQLubPELnfJC6cPDRfWFNfDDm8Y1rww2Xz9IME+y
        Pix8rSLs7yvmPF3hq0o2Chs5GvA+T7GfzlEnChe4sG9mLR7uOd3FfoOMQ555zv+G
        QE8wmsS9CkJvtx2blYZaKY2quJ6ArSJ2u8z4DRNaMQOWXeLkzDyhXmC0zXkV6N3I
        JA2WPUdGwFPaT3UkSE0buvgZEKAzxHskUhzy7shzlI4m5qQrzAi8pLY8Zu8bAV5v
        p/7ivHVBTki9ptKaNEnOVsunkwFN+VfNPIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZQzgdPm8Kd26 for <linux-ide@vger.kernel.org>;
        Wed,  6 Apr 2022 15:28:30 -0700 (PDT)
Received: from [10.225.163.4] (css-nuc-sbp2.ad.shared [10.225.163.4])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYfL52w07z1Rvlx;
        Wed,  6 Apr 2022 15:28:28 -0700 (PDT)
Message-ID: <835cf881-56ce-93b7-3182-ae35eda2691d@opensource.wdc.com>
Date:   Thu, 7 Apr 2022 07:28:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
 <da15b34f-2f13-6c97-29f1-9f26c8ec5a3d@opensource.wdc.com>
 <BL1PR12MB5157C86CA05C4F64435152DDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157C86CA05C4F64435152DDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 01:59, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Sent: Tuesday, April 5, 2022 21:11
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
>> hdegoede@redhat.com; Christoph Hellwig <hch@infradead.org>
>> Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
>> configuration item back
>>
>> On 4/5/22 05:02, Mario Limonciello wrote:
>>> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to
>> CONFIG_SATA_LPM_POLICY in
>>> commit 4dd4d3deb502 ("ata: ahci: Rename
>> CONFIG_SATA_LPM_MOBILE_POLICY
>>> configuration item").
>>>
>>> This caused some pain as users would invisibly lose configuration policy
>>> defaults when they built the new kernel.  To help alleviate that, switch
>>> back to the old name (even if it's wrong).
>>>
>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I applied this manually as the "default 3" is from the first patch,
>> which is for 5.19. This one is queued in for-5.18-fixes now. Thanks.
> 
> Ah I didn't realize you were not going to put default 3 in 5.18, otherwise I would
> have re-ordered them.  Sorry.
> 
> Which branch did you push what you've applied so far to?
> I checked libata/for-next and libata/for-5.19 and didn't see anything yet.

I pushed the patch to for-5.18-fixes and will send a PR to Linus tomorrow.
The for-5.19 and for-next branches always are in sync and currently based
on 5.18-rc1. I will rebase them on rc2 next week to have the name revert
in and avoid conflicts.

> 
> As most of my patches recently touch the same code want to me make sure
> any more follow ups work from the right base.

Use 5.19 + the name revert patch for your work. That will correspond to
for-5.19 next week.


-- 
Damien Le Moal
Western Digital Research
