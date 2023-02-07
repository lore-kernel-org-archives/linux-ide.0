Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1488EC636CC
	for <linux-ide@archiver.kernel.org>; Tue,  7 Feb 2023 23:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBGXkA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGXj7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2023 18:39:59 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D611A4A6
        for <linux-ide@vger.kernel.org>; Tue,  7 Feb 2023 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675813198; x=1707349198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=agx6aD+epc1rntXGN4S99jNi82Mbgtupro1Viu14DS0=;
  b=Dw6GkPVtmgedWpfHi3lnSQK+rSN7mIoPFjtFbVH5+zEk+scIN3KMfd3N
   iYxgUy7goZE9Y2dniVA4d+Sg4uTeml7d13U1p2JfYGXxJ0k2g/Cjs9268
   xsYqYC+er+MKUkzRAOezxHJxgUYmnzjpD8WIGBiVIFyXu4yUZZBp0aDYq
   ZWt8zK4mmb24crV1D6r7CGAoQjrnkRyL7ZcVMIVD4n3dQK1fSDGc/AeAl
   Nmoo7zUF6RQIUZqqLBhvEfIfuTuwDpoh/5fW7/jrrSLQxNiMkrsIkF3I0
   m3zppJ+VocrkeJmTaTnw4iXglbVw+nKzKyvhtyEcj4J4jnDThlpUBbM6L
   w==;
X-IronPort-AV: E=Sophos;i="5.97,279,1669046400"; 
   d="scan'208";a="222792170"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 07:39:57 +0800
IronPort-SDR: +80U9vIbj+bp8K8RmRkjL3gWVfJWJ82CHjqX/KFQAGc2fmFFhSCNvmORfMhqFHHtJ/HpI4HIRc
 9T/IlK3zAfKkPm2WnQyW9v7zvjFoZVvTRk4jtbjbMaRfclgvFuTBNhYCm8CNPJckT1dQY9qirA
 46bWqusUV9165GOOC16XbiHhNi9OTkN8YPF5J95tb4Or9cG0/V104GmKVFJbXRI1fo/MQv+/if
 UtJgBAqerFmfEe6bLd+USH3bWJ+Kurx3jGQoCHwFgM4CF+F1tR+BjhscNXZpPT3lcoSIBFUmv+
 p1g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2023 14:51:28 -0800
IronPort-SDR: C0HqjWmgYopYHqrb+DuFE+hknX0r76lNkct9pAX2w9P4eEPX8UfXDPLuWWQ7upyvS8QqL7W0ld
 OJE3LGnzpTnTbp3N3cEueQmrTZfSn0qml0Ww1ttuIpVYZjMlW6dJipSjg/vN7x4Sg2DGQCvdoY
 c18XZBMOdVqzD4+w6ZS4LX52y9EJDvJItyKs7bGGSNEER6+tjn4ssCWb8/NFuK/jsVFszVO8Jj
 6gvhLdrebEc/Ig6DHUPvD17qkI/rmF636Dzfhvb4RgULfIUFWMsSF7QO1TYvj1XcCjhT4DqBIe
 kX4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2023 15:39:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PBKNs3SNhz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  7 Feb 2023 15:39:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675813196; x=1678405197; bh=agx6aD+epc1rntXGN4S99jNi82Mbgtupro1
        Viu14DS0=; b=mZsi58yOkGRg68mBmKN3ClmjxG6ALOz5bXxEYJeYjDpm8KH4m+I
        I4Ig1hmqCa4VskW6hw2+obbeEfjZ1VB1lzEPrxNFP46Ult6N6jfq3H0Cj1QhaoWP
        +RKBZBLdWliqlCdss1re5cIt2M04hNcFhCylGUCR9zZWlhAwnxhPuwKy3Ale4E5u
        XY6Xgq6Qo7K51beTnmdEYiV6VZnSpjdxS2gMDTE1ZZWJRtV3WeZ/c/ivlSeO4X/U
        5bTDJgSGWhHODKYlLyuORYNFNZWikpnS9Idwaxn4vP8FBgd7ffGdYpQK4MjyO8fb
        p/Z8ZovgCNwRmRLuEZ1/s2ODD488L7Wqe9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2UjFkvN9zvWp for <linux-ide@vger.kernel.org>;
        Tue,  7 Feb 2023 15:39:56 -0800 (PST)
Received: from [10.225.54.64] (unknown [10.225.54.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PBKNr2Hcsz1RvLy;
        Tue,  7 Feb 2023 15:39:56 -0800 (PST)
Message-ID: <023692b9-d980-82fd-26b9-01a734bd649f@opensource.wdc.com>
Date:   Wed, 8 Feb 2023 08:39:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <1e069565-a391-0f33-0714-ba9cc3792a42@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
 <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/02/08 3:40, marius@psihoexpert.ro wrote:
> January 31, 2023 9:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> I did testing on Intel & AMD machines with different adpaters/drives/pmp that I
>> have (AHCI, ASMedia and Marvell adapters). Everything was OK on my end.
>>
>> The tag is for this kernel only. If backporting to 5.15 does not solve the
>> issue, we will need to take that separately and redo debugging on that version.
>> I would like to send the patch to Linus by the end of the week...
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> I saw that the patch was applied to v5.15 too. That was probably not a good ideea. This weekend I tried to test the patch in OpenWrt kernel v5.15. It doesn't work:
> 
> --- RAID box connected ---
> [ 1772.100899] ata2: SATA link down (SStatus 111 SControl 310)
> [ 1772.114132] ata2: limiting SATA link speed to 1.5 Gbps
> ...and these two lines repeat forever. There is no "giving up".
> 
> I tried the workaround "libata.force=2:1.5Gbps". It works, but with a delay:
> 
> [ 116.705772] ata2: SATA link down (SStatus 101 SControl 300)
> [ 119.175752] ata2: COMRESET failed (errno=-32)

EPIPE is supposed to be to tell the upper layer to lower the speed...

> [ 119.180133] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 127.205713] ata2: limiting SATA link speed to <unknown>

...which here ends up not looking good as the speed limit is still UINT_MAX, so
unknown for that drive. So I guess that for 5.15, we need to fix not only the
current speed, but also the speed limit.

> [ 129.475703] ata2: COMRESET failed (errno=-32)
> [ 129.480084] ata2: reset failed (errno=-32), retrying in 8 secs
> [ 137.445667] ata2: limiting SATA link speed to <unknown>
> [ 139.715666] ata2: COMRESET failed (errno=-32)
> [ 139.720052] ata2: reset failed (errno=-32), retrying in 33 secs
> [ 172.645529] ata2: limiting SATA link speed to <unknown>
> [ 173.585525] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 3D0)

And then here, automagically, the libata.force limit seem to kick in... Very weird.

> [ 173.591831] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
> [ 173.600838] ahci-mvebu f10a8000.sata: FBS is enabled
> [ 173.605977] ata2.00: hard resetting link
> [ 173.937078] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 173.943563] ata2.01: hard resetting link
> [ 174.277073] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 174.283555] ata2.02: hard resetting link
> [ 174.617075] ata2.02: SATA link down (SStatus 0 SControl 300)
> [ 174.622787] ata2.03: hard resetting link
> [ 174.957074] ata2.03: SATA link down (SStatus 0 SControl 300)
> [ 174.962785] ata2.04: hard resetting link
> [ 175.297075] ata2.04: SATA link down (SStatus 0 SControl 300)
> [ 175.302784] ata2.05: hard resetting link
> [ 175.637072] ata2.05: SATA link down (SStatus 0 SControl 300)
> [ 175.642781] ata2.06: hard resetting link
> [ 175.977071] ata2.06: SATA link down (SStatus 0 SControl 300)
> [ 175.982781] ata2.07: hard resetting link
> [ 176.317063] ata2.07: SATA link down (SStatus 0 SControl 300)

That is weird too. No point in repeatedly resetting if the link is up. So the
patch really screwed up something for 5.15.

> [ 176.322839] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA/133
> [ 176.329758] ata2.00: 976773168 sectors, multi 0: LBA48
> [ 176.335595] ata2.00: configured for UDMA/133
> [ 176.339944] ata2.01: ATA-6: Areca Archive, 0100 AX, max UDMA/133
> [ 176.346160] ata2.01: 23437498368 sectors, multi 0: LBA48
> [ 176.351830] ata2.01: configured for UDMA/133
> [ 176.356303] ata2: EH complete
> 
> So probably some other commit needs backporting before this one works. Any ideea which might it be?
> I will try another bisect when I have time. Any clues would help a lot.

No clue either. Will have a look.

-- 
Damien Le Moal
Western Digital Research

