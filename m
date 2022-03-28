Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5FFC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 00:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiC1Aj0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 27 Mar 2022 20:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiC1AjZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 27 Mar 2022 20:39:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A14ECD9
        for <linux-ide@vger.kernel.org>; Sun, 27 Mar 2022 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648427866; x=1679963866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1TF4VA8quiREm1FQHyiut+4zTzxjbm3Uliq7TS0u9NM=;
  b=VN4ZLQDFpUo+/WJrNI5EFj1dg+K/xF/b6OiZ2cKM3inyUIgR+3NHXdGK
   IoOZPBuY1toZnIMVpR5y6PujVGh+SjasT5eH5pUpst6tDfxZvlgwOhARy
   PMKXyx/EQNJP/OhcG8T3qY0tfxJcWfYlXJy69j86aAZcQabFqk45XsFmN
   /JSLn+hTLVUvSqfi1qAOTMwuX3JwyYpfOqQKfscSsT5YelAnYpRaZw7s/
   Lk7rasTfHp1QrlU/utw3ARhYpS2QL+IHC47RoekMg3Da3G1y340g3YJPw
   Gin9zoAlPHs2th7BGoTglvj6fdOq75AnrS++knsrxhGjklKKFfADET9dW
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="195287872"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 08:37:44 +0800
IronPort-SDR: 7KzqLwsiRwzBOV+8Ylvn9LcM8czMmEF2jYrLDSkD/m0KlQaZWeUQwGF5PH1sRwwC4tSIkd6KSK
 eFW3J8O01Yr2tzrQePqoqHzsURSgr2XXa/C1vQnaNUNFyxd/1y/jULyxP6R8JMCHAS2YTBrHBn
 OxBVU9cdo7/e4J9o1ZxM5c1EDf3gS1QisS/I8A3iPLpb73j6kjpwX+vt+XP3dJGWiwWznuprkp
 IMpaXZ0NHukbxcNaODsQX0l1hYXAw+kZCcncJpi+9wfMOUretxB6gsi289pigSe6nNTVrgmMb5
 B6TJTtdEXfeuz7q/3ElcCTrO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 17:09:30 -0700
IronPort-SDR: ZunIIBVmfTGYjLcOFGh48orglxfhkq0SKnGju534mWp17N/PUaUzjwmUfXtoYTYFr3Gb/lGcj3
 lCdI00mOvmzSwN9RZBgJyEPD1KopJsiiqmNM4irW61G0UWbrSja9sFRFdnuqqX5dMLWQwjqBgM
 WUsQk4EceQnkZlEAxqUxN10Pp50Mf1ckzYjVDhx4OD/l6OTFnlxPEkGJrrRjERY7N8kHSK5iSg
 Bt28EMTaV1sEegmrQtab1DtYwG6px7wiDnjWPiLvtlbfZ/fKfFuc2pnJwPSFINPl6ChKqdA21D
 tmk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 17:37:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRYgr1L3Wz1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 27 Mar 2022 17:37:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648427863; x=1651019864; bh=1TF4VA8quiREm1FQHyiut+4zTzxjbm3Uliq
        7TS0u9NM=; b=pjbgTIcMSMWIFByW35wNKP75c5I8RgtwfhwJoezZHoZ/lcE7QBh
        YWU2SmjjhDCjUdrLGigmGLf/VfqdQHcLa+6guLTXkXym3Z+zXos2/OPdT0YUMuGt
        qivcfy9yPQZHjNZF1uS7pbvKwFasX0p6WhO/ACikL/fEosN3PRAeObyMkR88LKtp
        cf+gaaMqJNGgGBn1A/TPbevHyWZlF0xH7ijlzIm2pP9BvyvnyF0exDsdCQ1vZLce
        GFHFtVTdp1KPfAXtNyRxsafn4BTQP0JDVrm+9YIewhWLRGxFY0Pa7UynE+u6E2CM
        XwQWIHFqwIO5zzowxiR8dM/j8vkX6wWxEIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SnDoV4QCSEff for <linux-ide@vger.kernel.org>;
        Sun, 27 Mar 2022 17:37:43 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRYgp2wVNz1Rvlx;
        Sun, 27 Mar 2022 17:37:42 -0700 (PDT)
Message-ID: <b9dc8838-1272-5c7e-121d-768e7feed290@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 09:37:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220324145905.4176-1-mario.limonciello@amd.com>
 <YjyInz126lgomIvW@infradead.org>
 <BL1PR12MB5157132871A3CBD381E7F072E2199@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157132871A3CBD381E7F072E2199@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/22 00:09, Limonciello, Mario wrote:
> [Public]
>=20
>> -----Original Message-----
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Thursday, March 24, 2022 10:05
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>; open
>> list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "=
3"
>>
>> What about just reverting the rename of the config symbol?
>> It is a bit misleadin=E1=B8=91, but so are many other option nams.  An=
d they
>> really aren't the user interface anyway, the help text and description
>> are the main user interface and can be changed at will.
>=20
> It was the rename that prompted us to give it a closer look.
> I think this patch should to change the default should happen either wa=
y.
>=20
> If Damien or Linus wants to revert the rename, that's fine with me, but=
 if
> we land this patch then I think it should serve the intent of most peop=
le and
> distros.

I am OK with the change of the default value to 3 since this is what most
distros have today anyway. Nevertheless, I think we should fallback on th=
e
safe side with this and also revert the config name back to
CONFIG_SATA_LPM_MOBILE_POLICY to avoid any unintended side effects.

Please send a v2 with that rename and the default value change. As
Christoph suggested, the config option help text can be broader than what
the name suggests. I am thinking of something like this:

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index f27b12ba2ce7..ee3f96b5be70 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -125,14 +125,16 @@ config SATA_AHCI

 	  If unsure, say N.

-config SATA_LPM_POLICY
+config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
 	range 0 4
-	default 0
+	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-	  for chipsets / "South Bridges" designated as supporting low power.
+	  for chipsets / "South Bridges" supporting low-power modes. Such
+	  chipsets are typically found on most laptops but desktops and
+	  servers now also widely use chipsets with low power modes support.

 	  The value set has the following meanings:
 		0 =3D> Keep firmware settings



--=20
Damien Le Moal
Western Digital Research
