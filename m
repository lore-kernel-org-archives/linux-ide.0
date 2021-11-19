Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415BC433FE
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 22:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhKSWEg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:04:36 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41111 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhKSWEe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 17:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637359292; x=1668895292;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OdxXeZc9sbBp9v4WA78i+3jlsImrKmJzYHwNOAwmIcQ=;
  b=hwWI6AWornGWPtJual30XVvfe6a7kUiyfhIIzEqy4HdgEwxJWo+sntS1
   7wHWNSwYRVCTfZOiz/5CuyzuotdggYIfAIDayHyO+3X1+7OFL7NnYaGzT
   19m39MdQUrlrkFNygeYahpeO/sxVAsBH05kwwuNrHS3rQ4dmO48Vd59sQ
   6fz/TdLNYfCkzmNKTXi+w3zohtuFUk0Cux1aSf06Hlkw28LpQvEswlpID
   dWKwhHwLA+a4q2jhH2qeEQkw+/aNPUKoyQ2ARdQylOlJsI5L0V8nJ+pqS
   cHX2qjOiyzF+pdfFYwX9xMaZ4ncIjOgM/u0IexOf8YaqLfnXq9AzvNPWC
   w==;
X-IronPort-AV: E=Sophos;i="5.87,248,1631548800"; 
   d="scan'208";a="290072446"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 06:01:31 +0800
IronPort-SDR: xpWMHwwhvFlfcFpfxwtO4hCEebjlUIGJ+qmmGVkGlm3dBKtpibXKmtGbWoJWjjhYXk4geeh0tz
 RamvYP+rE0ywYUznh7qLy6QctSvWypMXO+KNNo4Z8AuNdBuelrxK/ZitxPwL95r91o2XJsGM1p
 PflpC8dtsVv2jj2/ywd3jIQOCvui4zdxDmMrG2mM8YCfNBhrC+vw5aM2y9c0lII2IZwmSZ6ytu
 46YkhO5clVJipppZ1nGrF1aSbx/n2DtP2toKE2zp0vsozX3cIxNM/G9O3X3eAbzaNm14mAG5CK
 fLKBWmWrbmXRTqa3e9LPBNq2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 13:34:58 -0800
IronPort-SDR: JYBhW2uPnqpoElt1WrqfBZ7ftWP+Fw6bVFfqchyz1HHWk0j4M179f+alSerZ3818g9hO8o+hdw
 LyjLjAUfxrw1ktgW9f8r1u6GdS86b+sPVOLUH8wHu5gqeS8X1MOzexh+M5wNAHFK1zwFZpTKP4
 zsM02TnPMoxIOnmwHcTXu0LyxuN3gmWaf3Hx6o7KFDTFXrYkE8ZDCJ1OIO7081IAwhFLOlPjyk
 ivCgLdaXSh9B3bmYTZi8M+tq8OctsP8aJBa+F9z82WUwdvBo8Am4sXO2Tk6JhTMMPNynyGPSPR
 ao8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 14:01:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwrGg3fmYz1RtVn
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 14:01:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637359290; x=1639951291; bh=OdxXeZc9sbBp9v4WA78i+3jlsImrKmJzYHw
        NOAwmIcQ=; b=pnV+ZnLhEqUIXVxRUBCQlW+pi3RPxjs00DCPiuCO27tHhu61u+9
        uPi/2zoAHIM6b64xpN6Rwvy1vT5ITqXxlcErwQ8fToQX5WRbni1DaXI7TwIlDfVh
        NDTegQ/RlXfx/tFz35TpMcvkQLeALi6ajv9YmiIx5t7AfJ33aFG/a6cuSlvXhSi2
        6tngIRrBzEITEnTXosCEjIWArcys21muqXVoaZ730BhflVlYjxK49uLL4HlZGsgA
        jg8g0c2687o/HxkKqzX8NEzszli44L1LjFssKCbn/bxih/zTwPimhX/jMRbThXOl
        T3wF6UlxEUCPkemTx1ivop0Sqlk5x1qvTsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qM7IXJ5GzKQ1 for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 14:01:30 -0800 (PST)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwrGf1sgTz1RtVl;
        Fri, 19 Nov 2021 14:01:30 -0800 (PST)
Message-ID: <1425f812-85fc-e7f7-4c23-16061e96aeca@opensource.wdc.com>
Date:   Sat, 20 Nov 2021 07:01:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
References: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
 <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/20/21 00:46, Sergei Shtylyov wrote:
> Hello!
> 
> On 19.11.2021 11:49, Damien Le Moal wrote:
> 
>> Linus,
>>
>> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>>
>>    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>>
>> are available in the Git repository at:
>>
>>    ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc2
>>
>> for you to fetch changes up to 6873c30c1b797997f302fe1707bee9a7f247dfe2:
>>
>>    sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl (2021-11-19 13:57:18 +0900)
>>
>> ----------------------------------------------------------------
>> libata fixes for 5.16-rc2
>>
>> * Prevent accesses to unsupported log pages as that causes device scan
>>    failures with LLDDs using libsas (from me).
>> * A couple of fixes for AMD AHCI adapters handling of low power modes
>>    and resume (from Mario).
>> * Fix a compilation warning (from me).
>> * Fix sata_fsl driver problems on PPC64 (from Baokun).
>>
>> ----------------------------------------------------------------
>>
>> Baokun Li (2):
>>        sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>>        sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
> 
>     At least this one needs fixing! You were too fast at merging... :-/

Arg... And I did read about that function to check before applying the
patch. But I missed the error check. I am going to drop these patches
for now. They can go into rc3 after fixing.

>     Well, I guess this will need a follow-up fix now...

I will request a V2 to the author so that it gets tested (I do not have
that hardware, so I cannot test myself).

> 
> [...]
> 
> MBR, Sergey
> 


-- 
Damien Le Moal
Western Digital Research
