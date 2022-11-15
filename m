Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB92C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 15 Nov 2022 08:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKOIK7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Nov 2022 03:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKOIK6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2022 03:10:58 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501126306
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2022 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668499857; x=1700035857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2ftrW8zl5Jydq/L5riUlSr41wjfkSo28ylObHMgyGg=;
  b=js3K3HGAF5UQ/crPM465yaKnfE0YPnDTJqAznXdyNK3xMLqqGUkJxUda
   Sq26XxqeVK9kXVmx0Lim7xbIg2lKAJrxmx2EjQzK6qy2/Rb6Nq1nI4clV
   OTImbNtkre2ixwkbFlAnUGMwLjQ8rUlP9jN2thX+mRZ7R2TY0zr+dOV/E
   Oifbw5BmNCUwoZQOCkwtdLrBsFT0XjtsBc9PDJhdjuRLfXPplYXNF3z0N
   TzBLT8vhUEXryTvUrkUNgtIuyrvXVAqlYF4ThOGA69FhCWxD9Z7Bf4BCW
   TYdkgR8S/AqVgWAiTOvLMviVoh/F1+LFv2F6G5kFRjJe5DLypbS882pXh
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665417600"; 
   d="scan'208";a="320640015"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 16:10:56 +0800
IronPort-SDR: vpvwByciyo3l7uDyXc65r+FWmZlAD2TE/SuJ3fZTkeEbF8PsCaPOSDzlWbfuy1HIRBQKdHOmmS
 CTKL+ABlmhlOUKSGNsYASbSgCmKBthMXoasIvCGxZdAjJ45u6fSyOcOcVdUr9Qhw1jLcsOZx8S
 Ah1EuDlkwtwWkM+ZYbW5OkaBzzQQKnalTXkQ6ebMs2jiJXeiAsDy2lyy+ioc7uHuDY7dMQuIB8
 Lmt0LGrbANoKh8aPXPRHRYh3pWHRepIXzX7UH9pXCqz4S0Z7kiAOBDDC5OYF4PiwPsg+Jw3OXy
 HPc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 23:24:09 -0800
IronPort-SDR: gws9cIRHE4NtF7Mwn1UutDFf3xC1BbK83ppcN5fBbuPMd5GFOIpBHPX/dZqKwSo+sJDaKqvJi8
 08BmW9yVHU43eYKnSo5JEF8ynhRMW00z89YCtbz7OmhEI2Ue+89CvQtPBXEYjLOyfElfOtGzQ7
 CHj97Gyaz7MGFyUPTEaEsx5Kw6DWNmA/T3IhP0BbcwWkQpXM12os8DOVjQuo3jYU7+GpjiHfst
 mUA92DRK8NER9jCVNGczgLm31qGrsXMBHs9yW3XdD1hMe/OdaJ3yqL8upAgwNQ27xYpF/GYRZ1
 yYM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 00:10:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBJlh33mWz1RvTp
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2022 00:10:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668499856; x=1671091857; bh=M2ftrW8zl5Jydq/L5riUlSr41wjfkSo28yl
        ObHMgyGg=; b=PcMUqixXLpwr1eAFNA9YGuFKPmrmzK93dMsUmo++IoWoqtfrmDh
        +JTKietYEOiOzMsiyTnzIIeDe6Xq3a2FaK2rO9fvRP1h/Bzp012I4+B/Coodw873
        W1x7amOaVN6ZQScZbMtUq1La8DvACfq+Aq0ll8Q7gdWcqDSJaPq2PZCiaYGqCMGo
        bFmY81xW42+qaCkWPMpzjowje02d77cypcgpPvSJUJlVzkI4sHU0iOGNcx7Uhbu7
        h31G9QfG98FfUc5wHo8OElz9Is3s6N4L1yrZeNugZZlCMASOr2E25n7RCTzU0qvq
        69nqC/LhmwkyMmsASXv8cGYYEMKdXNETYAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mb59cZToEugM for <linux-ide@vger.kernel.org>;
        Tue, 15 Nov 2022 00:10:56 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBJlg5J75z1RvLy;
        Tue, 15 Nov 2022 00:10:55 -0800 (PST)
Message-ID: <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
Date:   Tue, 15 Nov 2022 17:10:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/15/22 16:28, marius@psihoexpert.ro wrote:
> November 15, 2022 5:02 AM, "Damien Le Moal"
> <damien.lemoal@opensource.wdc.com> wrote:
> 
>> So something is going on at the hardware level here. The register
>> value is not stable... You could try playing with the sleep interval
>> (unsigned long interval = params[0];) and duration (unsigned long
>> duration = params[1];) to see if anything changes. Especially try
>> reducing and increasing interval. -- Damien Le Moal Western Digital
>> Research
> 
> What are the defaults? Are these defaults the same for all sata/ahci
> controllers? How much can I increase them? Will anything break?

Nothing will break. No commands are exchanged during that link-up. It is
only phy initialization. The defaults are defined by
sata_deb_timing_normal or sata_deb_timing_hotplug at the beginning of
libata-sata.c. The names speak for themselves: normal timing is for device
scan on boot, hotplug for... hotplug :)

> What could be the cause of this? sata cable? Power source? BTW, while
> doing the testing, I saw the same error with the laptop HDD. I
> disconnected the cable and then reconnected it, and the second time it
> was detected OK. Unfortunately, I wasn't capturing serial messages and
> I couldn't make it happen again.

Could be the cable. Try to use a good quality short cable if you can.
Power source can be a cause too, but less likely. I have seen lots of
issues with bad cables, but they generally manifest themselves under load
with transfers with bad ECC. When it happens, the errors are obvious.

Could be the plugs too. Check for dust and/or lose connection with the cable.

> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

