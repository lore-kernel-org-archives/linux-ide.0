Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B893C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 01:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiBYBQf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Feb 2022 20:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiBYBQe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2022 20:16:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC12036D9
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2022 17:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645751762; x=1677287762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zdvd2Q0709AmZupOpNkadTOBcgBEF7TWXzo8lxEEpdg=;
  b=CQFaJCZVGeIJaEZedWbCZKnPpDSjR/RPMNUuyPDkrAF4eU53mkydmFHf
   ANAkKEWPoH5RxVfqybBIkDq4/UqCYiWYFfhw2cDThlQPDUCOTDlw/j+bz
   jyiTuaYs4MgmBrKRr2150Zl3zTjC6pyA1dD7f7oR/sRV4Vi9WK9IQM49U
   LHD74jEK43y1ZDof6/nW9K/jC9bGIfGEZLvy06tDwWNL6i2F8PVV4Ap08
   ym3EVnFR5xgNHaP+8XzHZ4JdnBnFua85TG7fh7i6XcPImBlHcCR+N19W6
   uSVRsMh/LDYKCJDMqMyFrDysBM+QmcYye6taLYdMqnMSq1NFVFVKtqieE
   A==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643644800"; 
   d="scan'208";a="305804122"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2022 09:16:01 +0800
IronPort-SDR: UkhdzlZfQJsXNxTrdpk0ejJX+FUN+2EFPeaEaCKf3h6LQZGDKgQH2wD+vY/VWK+e97p/qOyZj4
 gPgY46uF9oLhZ9WR7zaEwMjgFRkcwqugKCb7DsG2gvj7GVMEWBhKoZKb1VmnrdmwWw/K8k1qhX
 jlJxFMIEKJPXZGGFX7quxwGycqdfMZ7lVJrYaYdMIt//Nxob0vkiurVfsKutXf7DDyUwnLHYPD
 1YFBXhlcNVyWDgRDyN/IeNG6an1rWHw0OZVkSHptzYvBr13BkHnApPk/sgtJApyix89ti75Y9a
 BvzDXtNV3o1zLQa67UnAZctK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:48:35 -0800
IronPort-SDR: mW8I2a+9kPpilyskSTQ544s+1QSR/kcIY2DTVKMwjXv5MEzPy6FOtM3sNAHXXHOkQH6ancj/LW
 TWBe14mrjHoF35oQ2lVvH6Pm6diJxGW8QilLVuaTO1uFwEMKTDDvoXzCZlSGGxSXphANvfutNm
 7YBmZ86AgEug79Xlm2raghoXi5YCiIkbkZkqqx7dLSCaQAR1lPB+9Bzr8EavjJg+W3DxW9GzVM
 p9R6fPEjtiijmjqb6d8hPswhUawl+PxQMwLiRC4kcV2ldBPicrW2IEAMx2F5IVlSeHFSvRWnZK
 WhE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:16:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K4X0J739Tz1Rwrw
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2022 17:16:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645751760; x=1648343761; bh=zdvd2Q0709AmZupOpNkadTOBcgBEF7TWXzo
        8lxEEpdg=; b=fAi9GotyaUM7Y0WqpR8UhoI+apkflZYJ3kO+ro3WObnGbkEjjwe
        C3/3cRuCrRHuCc6c6/HblEJQBYArUMMXgy/k1oc5OgFjkWv2BChr1xBZ0gInYlGQ
        daFJ0LahqrhdABSX5ZqIbP8K3CaXz5cIpBmfT7jL6WKJpzSaAwpyx01b1F0a9Kqd
        fI/Ok75cRywkERY3bWWAM/+sZDKI7vXC1Zo6EQc5f9AqMJkFev814L9rPCNkvZ2/
        HoIrtc23lQKUf/0ACYRzshpKXkZNTXw4KmnFsDbIibrXKOjvqlM2Eo7fWb1TV7Q7
        xIEPf8OdOj+Zf6tFdpZLM1gsfEv4UpYvJbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ep7xyfYBKKhI for <linux-ide@vger.kernel.org>;
        Thu, 24 Feb 2022 17:16:00 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K4X0J11L7z1Rvlx;
        Thu, 24 Feb 2022 17:15:59 -0800 (PST)
Message-ID: <63ec50f7-8e21-3549-6c37-804863d38adc@opensource.wdc.com>
Date:   Fri, 25 Feb 2022 10:15:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
 <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
 <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
 <5cc9bb8d-e228-c11f-feef-5cfba631057a@opensource.wdc.com>
 <036507f3-91bb-6480-7252-ff100a282ebe@molgen.mpg.de>
 <7187af82-3d35-0094-f998-7d20bfc5192f@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7187af82-3d35-0094-f998-7d20bfc5192f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/24/22 23:34, Paul Menzel wrote:
[...]
>> Thank you for cooking this up. I tested this on the ASUS F2A85-M PRO 
>> (AMD, 1022:0x7801), MSI B350M MORTAR (AMD, 1022:0x7901), and IBM S822LC 
>> (Marvell, 1b4b:9235) with no issues and the expected decrease in boot time.
> 
> There is still one issue I noticed. The MSI B350M MORTAR has nine(?) 
> SATA ports, and only one is connected to an SSD. For some of the other 
> unpopulated ports a delay of 100 ms happens (although in Linux kernel 
> threads, but still in serial and not parallel). Unfortunately, that 
> system uses LUKS encryption, and as things are happening in initrd, I do 
> not know if the delays would hold up the overall boot. I need to do more 
> tests.
> 
> ```
> $ grep sata_link_hardreset 20220220-sata-hardreset.txt
>      0.706289 |    0)   scsi_eh-70   |               | 
> sata_link_hardreset() {
>      0.718497 |    0)   scsi_eh-92   |               | 
> sata_link_hardreset() {
>      0.728425 |    0)   scsi_eh-92   | # 9927.978 us |  } /* 
> sata_link_hardreset */
>      0.811159 |    2)   scsi_eh-70   | @ 104870.3 us |  } /* 
> sata_link_hardreset */
>      0.811329 |    2)   scsi_eh-72   |               | 
> sata_link_hardreset() {
>      0.920672 |    3)   scsi_eh-72   | @ 109343.5 us |  } /* 
> sata_link_hardreset */
>      0.920915 |    2)   scsi_eh-78   |               | 
> sata_link_hardreset() {
>      1.024618 |    2)   scsi_eh-78   | @ 103703.7 us |  } /* 
> sata_link_hardreset */
>      1.025027 |    0)   scsi_eh-80   |               | 
> sata_link_hardreset() {
>      1.128589 |    0)   scsi_eh-80   | @ 103561.6 us |  } /* 
> sata_link_hardreset */
> ```

This looks like the delay for the link stability check in
sata_link_debounce(). 100ms is added (more for hotplug case) to ensure
that the SStatus register DET field provides a stable value.

As mentioned in another email on this subject, I cannot find any text in
the AHCI and SATA IO specs that mandate such large delay. Still need to
dig the history of this delay and why it was added.



-- 
Damien Le Moal
Western Digital Research
