Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A816FC74A5B
	for <linux-ide@archiver.kernel.org>; Wed, 29 Mar 2023 22:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjC2Whw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjC2Whs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2023 18:37:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479915B93
        for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2023 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680129455; x=1711665455;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8mC4BypXl60HzEDMOes6JdsHqZokNKJxPcubhfSExuE=;
  b=Fn91QA0KUUU4nGgjcduK/ozTSccHi44lT5KOp9D5pXkRQZDYlasQRKjZ
   aK4xK4tqzb0bayd0Ecpn+uCGQHmTylnIZzHspEPYFOnLB3Oxp0iiXu/sB
   2LK582yISnsfxtDXT1xTn1sToDzvRY8UB8X5pwdKUUxw82RIEw1ghIeIy
   +DYWzD/QUKVW8w7Csyl8FbUwmJk6VdNwKMy42KGJkJlwBcCM2n6yYO88r
   9JmRO7nwRAfHHHcPdqDWnPkZ6p55COEjyjso0Sv0JtFX9ZpJJKNaomNUW
   v8AVO4ZeV6NxXBMq/s0Obm67teV4hu2yBIi8DwiGhzNMEKCCow3elv2tp
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226645313"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 06:35:01 +0800
IronPort-SDR: 6Mt7BoydC8g3H/rcHdZ+VUYKeECOn9Sf8F2kgoB+qF694FPVKKo1JAcLXDqJq8jAxuhnbICKL1
 vpgfFeS6nXPXVma3huADFsLukhYepq1ebQXYpWmdoGL6tI3Fv8ks6zLLlIAeTWyg71Hb6a5taW
 /miOy8TnKA0hUkjgDpfpEm+C0S0FofuggBqKhjDe5V/Cp6DYqYVxkWfaWDUn5s3+KpGBjgnbb6
 0ccjCULZKjJboZddf20zig8vhUwrzOA5IT1UYN3+EI2gsJHs+u+4nc+jYD+viR7D/N8+s3sZuT
 Xpg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 14:45:29 -0700
IronPort-SDR: v6tZWZDmLHZIIUE79iYbnAda7htowKRWWIdPmVY/zrMgCehCgxg6tj+NgO/JDFlKzrycpBnfU7
 02mz4H12R7qsWU9N0s40xWcFKwIh4Nw49Z95o7Y/eHg2Fq2Yi4TF3uMCSd1dqyLn6XkdQbZ7I1
 cym8PZwN1d2zMxFLrFfntXyB6p7jV2dYZAdf0nAmAi+gNmrpAL3mw8jElVakmHmkpW6epnlRGU
 8C+6M3OFqXEHqWkvpotQzZ+NIlG1kwvv9ZeBmt8avV0TEr0rwAViM+T6mF1W9N+V4CEnCoyGCS
 qlo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:35:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn1Zs199Kz1RtVp
        for <linux-ide@vger.kernel.org>; Wed, 29 Mar 2023 15:35:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680129300; x=1682721301; bh=8mC4BypXl60HzEDMOes6JdsHqZokNKJxPcu
        bhfSExuE=; b=Zok4WYhcroENZvLPiiffuiL0wIhaaRMSE93p6mIUiG5P1+ftd2L
        q1g4BSW3yDCKYTtjxpyxP4yTyI5aihR+osGu3NHW33Fq3jncg3Qe7xNY4F/zwHCv
        etW1Nmc+YdHa6MKI4hd5xELhEGqsNDzfy7V+nuAUqZ9fc7RzMMfrtfJiNcSB4ANF
        pv7W16xNgr9XsLPJlP+2wNhoirGRaSfwNKtWLeK1SbCOjj5Lw5yzhhURWBT08bOc
        VuNZw5622X4vF6VjgAxro3fJgQJCUlPlSKztiYuxIJWi6gMTBHsKGitpZ4T4QUfn
        usPw+D9cS59VkGHy8R3Zh6mURJpGmFM4MSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QWVE6lpCIeoY for <linux-ide@vger.kernel.org>;
        Wed, 29 Mar 2023 15:35:00 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn1Zq4BbJz1RtVm;
        Wed, 29 Mar 2023 15:34:59 -0700 (PDT)
Message-ID: <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 07:34:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Multiple undefined configuration options are dependent in Kconfig
 under the v6.3-rc4 drivers directory
Content-Language: en-US
To:     =?UTF-8?B?5a2Z5rui?= <sunying@nj.iscas.ac.cn>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org
References: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/29/23 16:52, =E5=AD=99=E6=BB=A2 wrote:
> It has been discovered that the following configuration options are und=
efined in the current latest version, v6.3-rc4, yet they are being relied=
 upon by other configuration options in multiple Kconfig files:
>=20
> MIPS_BAIKAL_T1 is undefined, used as a 'depends on' condition in multip=
le files such as drivers/ata/Kconfig, drivers/hwmon/Kconfig, drivers/bus/=
Kconfig, and drivers/memory/Kconfig.
> MFD_MAX597X is undefined, used as a 'depends on' condition in Kconfig f=
ile drivers/regulator/Kconfig.
> MFD_SM5703 is undefined, used as a 'depends on' condition in Kconfig fi=
le drivers/regulator/Kconfig.
> ARCH_THUNDERBAY is undefined, used as a 'depends on' condition in Kconf=
ig files drivers/pinctrl/Kconfig and drivers/phy/intel/Kconfig.
> ARCH_BCM4908 is undefined, used as a 'depends on' condition in Kconfig =
file drivers/leds/blink/Kconfig.
> MFD_TN48M_CPLD is undefined, used as a 'depends on' condition in Kconfi=
g files drivers/gpio/Kconfig and drivers/reset/Kconfig.=20
> USB_HSIC_USB3613 is undefined, used as a 'depends on' condition in driv=
ers/staging/greybus/Kconfig and drivers/staging/greybus/arche-platform.c.
>=20
> If these 7 configuration options are deprecated, it is recommended to r=
emove the dependencies on them in the Kconfig files.=20
> If they are still useful, it is recommended to define them.

+ linux-arm & linux-mips

What about you send patches to fix this ?

>=20
>=20
> Best regards,
> Ying Sun
> Pengpeng Hou
> Yanjie Ren

--=20
Damien Le Moal
Western Digital Research

