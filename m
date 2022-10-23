Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64949C433FE
	for <linux-ide@archiver.kernel.org>; Sun, 23 Oct 2022 22:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJWWnS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 23 Oct 2022 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJWWnQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Oct 2022 18:43:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C561106
        for <linux-ide@vger.kernel.org>; Sun, 23 Oct 2022 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666564995; x=1698100995;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=JiVf7tTAUIo6+w69Pt3MFGZguCkRYTb2fsa6haF8SGQ=;
  b=Y+96xBhSikbX7s+31uiYdFrHtgBwm/lVGOcz3r9ce2nnqSHoE6v86qXy
   2Of+AK3frBxnXEVHyWX8EjxLlYK439ltxqGTcfFnoQVNGqnFS0UU0QS0+
   WwhTgI6SMHYF9GxNkgF1muUABGNWeUaESQX3ejxaNbqmjBa27C1wNuNaO
   vMl3QdnKccakC+wQV3hjWwdpticHN3m9EjCIvDbcUl/+z7UYvxoDXnVFl
   ZmwAOgEy/SzS9DFP5H1Ephzb8dV9icOYaVZ0OJooLNbmHpUAKmc9u+zOt
   uA8hUYZGGgrXDFgHOrPxoBUcNLD5gWB5KRbZpS6PHpSA9qszwI0EqkJo7
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="212855924"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 06:43:14 +0800
IronPort-SDR: Nlko1Zz9ioitSzNiQebJ+uJcpDULSpg9dCBL0fNQadbITfj5i2zfKt2gXUqsPi09KGD9FK8BvR
 o3C3ZZ7ajklCmpfG4iEMAMftKlak0x26qn35HPOIauOW6gqWKGwRkNl+eju5Z8vV9M3kr/wj/8
 7FdiXC6WVcyxdfenZl3v2Fja0U3eHYVDV6H42YcceCgS47ngwzkQ/A/QSiLBEYrktZF+hxHTbc
 T5I170N0qFdSsfzUgZiVh/Qghp7dMCn/JAGpFPlCwIeABIRm0ciDSAJmdGHfp3CQGkFSaexnA0
 bznOYESTbhHabfIJxCnx85dS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 15:02:39 -0700
IronPort-SDR: wfS003I9+Y4GHHKwir6qepmbyuE+SeKubUrpf7ISkkRDwdeY8zt45AQrcmkPK4C7YsoqT2P0Ob
 UCoaE4sfTYIS6uOkta8xa1e/rG9FLiuJh7+Mw686dDVaUVJ/vBBIxYE+0FIwba/kFUVzCCg9J+
 PvNsQn9qYy/myBj/lnCuEjHWMQ3SW88h6F0BLAWiIiKzN9WBeyHJ6Ho7Kd2WCiSfbnVZOx+8+D
 90YL3msZupFBm3zc7FUFKAZt2DgphJKI6ADw+2bAKi3+8AUbvGW49HBkXipQjZHEnRyDyi6bsG
 MBA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 15:43:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwYBn5DMWz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 23 Oct 2022 15:43:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666564992; x=1669156993; bh=JiVf7tTAUIo6+w69Pt3MFGZguCkRYTb2fsa
        6haF8SGQ=; b=k8HehEGTPpvMsMTyAjfIHlsTkJxJzPV4G50QJ0Ox274++M0sw1+
        Wzbs31nHl3s1IqCLoDomkdkK3/VXeuGbXa5YAVMERMYISkdjLVopXH7hIN12NG2a
        hH4Z6u+M1wrAdDBD/k0TzqLCxuH4KnA+Wt1BOpC2tVTDAELqQi6YEwCpYoFxAR57
        G5VevmifspbmVd847XNYvUcqFMcPbX7Ke3nkiv1+8uH8mEQNlCFkUxX9/Z7IRRIE
        AmWMH0WeONOL/Aw43DHkGwosA2YKmeOvo/QmsaUgDKePG2PWuFwVeUJPl/tx6/Wt
        t02wF+j1iu1ezqfhuCCu0kYSGqGVSyopmCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lNRlfn5FSu_G for <linux-ide@vger.kernel.org>;
        Sun, 23 Oct 2022 15:43:12 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwYBl2kymz1RvLy;
        Sun, 23 Oct 2022 15:43:11 -0700 (PDT)
Message-ID: <33b942d9-e589-34b7-2967-bbb939fef121@opensource.wdc.com>
Date:   Mon, 24 Oct 2022 07:43:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 09/21] pata: remove samsung_cf driver
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-9-arnd@kernel.org>
 <d458f39c-9927-33e8-b200-51e7cc09f2df@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d458f39c-9927-33e8-b200-51e7cc09f2df@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/24/22 07:41, Damien Le Moal wrote:
> On 10/22/22 05:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This device was only used by the smdk6410 board file that is now
>> gone, so the driver can be removed as well.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Arnd,
> 
> This patch does not apply to the for-6.2 branch of libata tree. I can fix
> that easily, but I am concerned about the fact that this deletes the
> header file include/linux/platform_data/ata-samsung_cf.h, which has some
> function declarations for gpio used under arch/arm/mach-s3c. So If I apply
> this before you queue the other patches for this driver in for-next, we
> may endup with build failures. No ?

It may be simpler for you to take this patch ? If yes, then:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
>> ---
>>  drivers/ata/Kconfig                          |  10 -
>>  drivers/ata/Makefile                         |   1 -
>>  drivers/ata/pata_samsung_cf.c                | 662 -------------------
>>  include/linux/platform_data/ata-samsung_cf.h |  31 -
>>  4 files changed, 704 deletions(-)
>>  delete mode 100644 drivers/ata/pata_samsung_cf.c
>>  delete mode 100644 include/linux/platform_data/ata-samsung_cf.h
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 6b446cfc3455..3b8cb7a29efd 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -1136,16 +1136,6 @@ config PATA_RZ1000
>>  
>>  	  If unsure, say N.
>>  
>> -config PATA_SAMSUNG_CF
>> -	tristate "Samsung SoC PATA support"
>> -	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
>> -	select PATA_TIMINGS
>> -	help
>> -	  This option enables basic support for Samsung's S3C/S5P board
>> -	  PATA controllers via the new ATA layer
>> -
>> -	  If unsure, say N.
>> -
>>  config PATA_WINBOND_VLB
>>  	tristate "Winbond W83759A VLB PATA support (Experimental)"
>>  	depends on ISA
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index 2cca9f500649..4ee5c0761d90 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -109,7 +109,6 @@ obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>>  obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>>  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
>>  obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
>> -obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
>>  
>>  obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
>>  
>> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
>> deleted file mode 100644
>> index aba1536ddd44..000000000000
>> diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
>> deleted file mode 100644
>> index fccf969dc4da..000000000000
> 

-- 
Damien Le Moal
Western Digital Research

