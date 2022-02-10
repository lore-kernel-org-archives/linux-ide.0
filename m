Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DAAC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiBJMhG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiBJMhF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 07:37:05 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAB25EE
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 04:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644496627; x=1676032627;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=y9yEiArUjpAjewqWMkHBBdF9TM3jkkN5p7ru+mwOYeQ=;
  b=OFRktm0qGFIH0TJElg9F4haRxRNejO1LVfEk13EapKZoyCDvDR7Ghyks
   hryBn2ZnF8URWcP4R9c1SMllyl/FEdORkMEeRFt76Mg/UGG2NmdsSc6Hc
   9lR7HdhbeowvsDT86PRUgVgPPRnJg4xKtdYb9/k6DzCI9hlXlYZnTZyNc
   MNPU8IwpdgaQ+9r42PoAPVz74b6gZVtaWLQvSuYFYDWRXWsi0BSoS/HW0
   HySUopGyFWaJO3h8431hRwfR23K5onjKcp/Y9qsavyTfBrXug9FA2YJgL
   QJ7HzrdL7HCSTRY4yQDwHwJrIQOyLWR6vASTovOIFJ6zDxIdHZUbBwk24
   A==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="193578252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 20:37:06 +0800
IronPort-SDR: vR0iAKEJbSyECRD5ceLS1rtBLiq+udHnlbO9QSahPw4EtEnVHe1AtXhHYWGtrUJhGBzzJDh3Rn
 9mJYzgP+Cnv5xQm6IIZ9ABZF0p9C6v/duud69JZqHp3IVK+4Cm/YpqDl4+a0ypMSbVRGaAzKvg
 2G61yNYIutGCMOZrtUZxTUMR+SO2vhBeeTFtsfHbX/rXENYswbWnDxXuiBMxbqG5Rsh0RSX5AT
 kE6xXAWoHajL/BG4i3yEZAIe7caJJsW3kuAP48TQ6UTlliWI6qSKNqD1NZE0bDeXV5bDRcicYs
 5YgTyzmpKtLRW/YpHIbMPFbT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 04:10:03 -0800
IronPort-SDR: Ng6Yj6ZDxT64GfLNLw/qSyjDLbJgtwRzxgTZED118jg6DHkF4Z09zRIreQVMqwzhou0O+C1Eyi
 aJ2kphNe/abJAtpHnTFgM/Txy2eVLyr6oC4yZ4ZmTGojQmLj+Vahx5kPTVtM98zlUo42eq1UqC
 8R9VAMVSoejCt85hPqbZ0YU64x9DOMJOt6HOxSxcytWC/BuKLLUMclkwX5//I03S1IIp17HP7t
 P89RuMLkYvknFmTD6jCwgAqK5EzkHjeVwmFlxHAZMCUNtNUYbEIL+TEMkyyck3bJSWfBNRYmgX
 Xq4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 04:37:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jvbq61JYxz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 04:37:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644496625; x=1647088626; bh=y9yEiArUjpAjewqWMkHBBdF9TM3jkkN5p7r
        u+mwOYeQ=; b=C9et/oRpgJJd0bcexE4Mnxzm+sd8IkQvCdw2cOX5myrL5++b7AZ
        ov2Emyxa2rRYcnu2punR3xHfR3YWMNzD91N8wPMWHV4zjDJqFM3n2OzW+tqJvUy4
        PN9VCAxuTLqK4YGXM3hTAmSzlAXu7mV/9I5CYEWT8h7j3Nme/AUaJO1lgbXYg9Ko
        NiGLNipaLPq3j5rBJY+Gaotn1EwO1qxtJ4z71zzw+jhWzQV773+aadka8eCqLOZj
        rKtRlmEVHu7qG2ZVneugiDdRZdBMwkPPJ5rOuQbGhmc1bGWMqba8DrzHOSGkK68d
        fTnV5ZPKJUcfSnifoa5KiOqide4gjy3kteg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hr9F1kgmw4Li for <linux-ide@vger.kernel.org>;
        Thu, 10 Feb 2022 04:37:05 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jvbq5169Kz1Rwrw;
        Thu, 10 Feb 2022 04:37:04 -0800 (PST)
Message-ID: <092e70bc-5cdc-388e-d422-135ab4c2c395@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 21:37:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: sata_rcar: drop unused #define's
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <328ce96c-1212-33bc-5d13-4aec88384485@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <328ce96c-1212-33bc-5d13-4aec88384485@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 19:32, Sergey Shtylyov wrote:
> This driver has never used the SH-Navi2G/ATAPI-ATA compatible taskfile
> registers (the driver uses the taskfile registers in another location
> anyway), so drop their #define's...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
