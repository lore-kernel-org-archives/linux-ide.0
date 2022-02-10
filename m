Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B7C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 03:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiBJDGk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:06:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiBJDGj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 22:06:39 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4012B274
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644462401; x=1675998401;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Wkaxieic4C/3hIpQY5ab/ILj75Fw0FDNRoHlTowzVZs=;
  b=fCMxARwltI+QRLXZUnisCimlx3uhuhvM02yGQ1odx7pPvod7FAxnJqDn
   /cPqPsKX1AGklvsgthD33hOUnqoUv/FQ8YIaToJA0wB2wDDX/iT/uoRVC
   LxRLyQQtOncURH6nP2Qdig0DoRkf9FDLpoHJYSHFzhd9Kb+cvSqcBiENL
   GhHqP4Qo2REksZkhnPi3oZzqmY5tNIB/lSJhtBYw9IfVe5nHpvXR+dq/t
   IThr6fbt9k6Tj3QgxoQ1+DaJk9mbRsmlHamcQC/t1zvUl7DxjQ0f7DzzO
   dDtECVrdM4oER4XlSGtJibdjZkJWMgn5v9m7Acun9M5aaH1iMtRK6ppmw
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="193541330"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 11:06:40 +0800
IronPort-SDR: tvm6KGAKKRQGgej/HwF198rrY7sVM9IUCLqxaaFzR/604LH+YhxvZMUalQP6CnpGP28+Gk89+J
 Ht3vvdRrZg57pb8iMhB2uY2hPJGdnEy742pbtDog8MJnJ0jBGSTQkXSfB0f4aXCKxGdAjSXctY
 VQhMwM1BgPhQPDBOdbQnoHwNTO97uKhz0AJmTuMFiMJX5Oq93ynEnrfgAJP5rKMa5s1OEwqLnU
 tw5I7KMuSOrbLoCkoDmf6ygkqGDrpW0BWWbFsfmeIYpHIDGy/kg/eahsa/L1wOU0zfaEuNzodj
 mHPVBUm8n3qU3U2nOLUNAO7K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:38:26 -0800
IronPort-SDR: l8AekQRbuA4fo2y5d6255ExgN4hEYydNMrPrWsYedg+MYd1g3vMoVjuDeu1rCO0oC6oqV+Fpcp
 gunM/xP7shLFcWY8dvW9irbNxuGzzkcNouRG6NCh4fHFUMn8ZkaVAt45Rlui0mxvJ4B0UcQqh0
 y3HtesGgW5ThtyrtUrD5r9ZY2eLMRFwWHH3pomn6IZIqOvf3N3Yj7/Aqq8LIRtoGX6DgzOXvtB
 mdUHfOckvn7DHaKWsUEs4qXKsstOQzwRF6PglZj3mIn4oC/ABbXSRQpD61WSPyB4gVafhK5Ckz
 ay0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:06:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvM8v25qvz1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:06:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644462399; x=1647054400; bh=Wkaxieic4C/3hIpQY5ab/ILj75Fw0FDNRoH
        lTowzVZs=; b=UqyZFo67pUDiMN2RaiGBcqGbHh1+4w1/F2qyZb76yEHvrSKVCJ6
        dX1QNXeGVW9IkMq6t3/BFswaH6FxsydalUEXpTlxxz9ubZWLt0fH7ouONcaeNeHb
        0/5RRlagD9z16yWnxh4GylkIzUhxZEJbAbzO9p5mZWWtaT5hza2Bxhyj6vYRH6yP
        aIkCCmsrl+1e3n5RPIur2CMFg6Rm4IyoYyqeAU+8W4X7A4xM7ZedlURDYqX/svvO
        FNbxCVJE+rL6fDuaEIuMpwunqX8JLHuBCS3RT1JquTHhIHSX3aFHHiE15PRhBYN4
        06Nd619e2jJoUP4SSZpANqou4mdHfyALU0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jcvAJdzwVVAN for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 19:06:39 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvM8t4QZJz1Rwrw;
        Wed,  9 Feb 2022 19:06:38 -0800 (PST)
Message-ID: <9a9c5fb7-904a-5066-fd30-6288d7cfdff5@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 12:06:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] pata_hpt3x2n: check channel enable bits
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <062c3834-da7e-273e-177b-d7aea4b1ba81@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <062c3834-da7e-273e-177b-d7aea4b1ba81@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/7/22 23:26, Sergey Shtylyov wrote:
> The driver's prereset() method still doesn't check the channel enable bits.
> The bug was there for the entire time the driver has existed. :-/
> 
> Alan Cox fixed the HPT37x driver in commit b5bf24b94c65 ("[PATCH] hpt37x:
> Check the enablebits") but forgot to check the HPT3x2N driver which has
> the same bug. :-/
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
