Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4527C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 27 Dec 2022 02:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiL0CJx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Dec 2022 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0CJw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Dec 2022 21:09:52 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD11153
        for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2022 18:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672106989; x=1703642989;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Xf5uXD7bAhgQwobapLM0oFw5g/zG4CC3bJPveIzVTKk=;
  b=HKMQmKbBy6kezXQ5Dr+cbHVGxBu9LNFgZbcx17D2ohN+wx0UyZc/7mxg
   jkcZ2sP13ohy7blR8JdJMrw/QO2RKE5Jc3HL1GuhfbTE9xgtMzKVr7CKA
   1XrNU5VdUZWQHQCXtrRO5VJfflHcM9yXc/GcF46N/s4KB+p1/SEA1nbSQ
   SFML+XL+80tKeIyISvfdeswbpXwGnvNIfqzbhhD9YLiTXttw9yqoSTiYf
   aEYmXGpTYWC40R22iPKCdiBYkM4ad/I/rEmcOcMOa+WoOMMLlzySUBzT8
   6pVSL/K+y37vUEHVcpQEtiANY3JrhDlfPaoST19RF17Nz5ZQ52crA0WME
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,277,1665417600"; 
   d="scan'208";a="323829623"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2022 10:09:47 +0800
IronPort-SDR: cIzjbIwipZaJ19bFHMR8KPKSb79i2BOsu5rvfMh6qHHHZbK/u/o34k+rWZbdEcZG9NZJtyxAMe
 r2G0aVLUbFRqgnS0xmeywdtETQiFDrXP7qDba/ZZf9sVPh47sB1mSerfTKvjBVUoClRztn0X7i
 0u9cg2a+4BrzwZVh/sw6uBNBf567eVXAUg84v18KaNdX65wBKsscYT9TRlHQcXj+HI+/GYo5kb
 NR+7iIPv+OuCqggeofYsYK8DbpM5SoqMWX7AnebT4svM/1C+aj2SW9POAYj+lSmv0hJTrpvhAs
 2/U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 17:22:10 -0800
IronPort-SDR: jzqabDxpOpoE2kypTP7eq55OQ9Dm4Rmby3byoLRyMkzquRbBMip4BAmWTwbLPWRIvlAnQ5uicw
 in4ggltQYI3CnnAr5NpoMg7BTP1+ae+uYwVm1N3roFXMmSfyRpM3NDUd8XejonT3+kc9Fj7QOM
 JBXVEYocsr3vMY5BSC08/Y1RL4m1T+4Qkj37//Avk9IF6CkuTSP1L6RcauOWO7H5jeSkMdFWIo
 4FH27sK52AxRZUHInslZrVutOXApo7+5jILCtZ73aZKiWutWzjh7TTFbz76bqK4NLMLjtfttbS
 asY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 18:09:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ngylb5wLYz1RvTr
        for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2022 18:09:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672106987; x=1674698988; bh=Xf5uXD7bAhgQwobapLM0oFw5g/zG4CC3bJP
        veIzVTKk=; b=DlNuD/QIjzapCDG6zDHULt3Fioygqib524rSN36e/JC5ubsn4R3
        WftER/BgZZ1GS06K+T0C42gxMq6XS2zaXgqkhheEuqIS7sxx7Mg/bKPw2dY1DJCJ
        kazAbWYzauj0ewHepAhf7P11eYLfIeTNr9VXCx6GvI2DzKdRdPSKBNo2HKFbPt1U
        tp9j7pr4HqQyuOXSce07Zmt5uH2+jdg9NuxPdViLMVKQQ9k3N44iqIe1XKplZtnV
        JOCE52S5VAGxcHEmQ6fAwDTsAw+wDpqHIkeoqh2cJGBG0woZjCaV4twodLDIf+YL
        xvoRfadvSSy6z3vikxoeuMzWVbbqHwTXQVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vstSRMAqtkVc for <linux-ide@vger.kernel.org>;
        Mon, 26 Dec 2022 18:09:47 -0800 (PST)
Received: from [10.225.163.117] (unknown [10.225.163.117])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ngylb0C68z1RvLy;
        Mon, 26 Dec 2022 18:09:46 -0800 (PST)
Message-ID: <6f16a860-6d03-0e09-08b8-2f6a23331882@opensource.wdc.com>
Date:   Tue, 27 Dec 2022 11:09:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] ata: ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     Adam Vodopjan <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 18:26, Adam Vodopjan wrote:
> Since kernel 5.3.4 my laptop (ICH8M controller) does not see Kingston
> SV300S37A60G SSD disk connected into a SATA connector on wake from suspend.
> The problem was introduced in c312ef176399 "libata/ahci: Drop PCS quirk for
> Denverton and beyond": the quirk is not applied on wake from suspend as it
> originally was.
> 
> It is worth to mention the commit contained another bug: the quirk is not
> applied at all to controllers which require it. The fix 09d6ac8dc51a
> "libata/ahci: Fix PCS quirk application" landed in 5.3.8. So testing my
> patch anywhere between c312ef176399 and 09d6ac8dc51a is pointless.
> 
> Not all disks trigger the problem. For example nothing bad happens with
> Western Digital WD5000LPCX HDD.
> 
> Test hardware:
> - Acer 5920G with ICH8M SATA controller
> - sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE
> caddy. It is a boot disk
> - sdb: Kingston SV300S37A60G SSD connected into the only SATA port
> 
> Sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:
> 
> sd 0:0:0:0: [sda] Starting disk
> sd 2:0:0:0: [sdb] Starting disk
> ata4: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
> ata1.00: ACPI cmd ef/03:42:00:00:00:a0 (SET FEATURES) filtered out
> ata1: FORCE: cable set to 80c
> ata5: SATA link down (SStatus 0 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3.00: disabled
> sd 2:0:0:0: rejecting I/O to offline device
> ata3.00: detaching (SCSI 2:0:0:0)
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT
> 	driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
> 	hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Stopping disk
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET
> 	driverbyte=DRIVER_OK
> 
> c312ef176399 dropped ahci_pci_reset_controller() which internally calls
> ahci_reset_controller() and applies the PCS quirk if needed after that. It
> was called each time a reset was required instead of just
> ahci_reset_controller(). This patch puts the function back in place.
> 
> Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")
> Signed-off-by: Adam Vodopjan <grozzly@protonmail.com>

Applied to for-6.2-fixes with some tweaks to the commit message. Thanks !

-- 
Damien Le Moal
Western Digital Research

