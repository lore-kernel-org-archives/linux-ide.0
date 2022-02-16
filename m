Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF2C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiBPHU6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:20:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiBPHU5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:20:57 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B3EA379
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644996045; x=1676532045;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=X0NY0a6YpTtJ4fZwapVFaRMSCmitIP8Nu/8M5EU2oZ0=;
  b=UWgivtuIJRNYAiOfH+25PGbyXLoSxSPGC/SzaFhh7FD/hcGJaZmvd+wd
   CpJhXEK6VxOC2yFRvLAwuvUMYYNx4HcKbSXgNi8FBZ5MsouWiOFm2yBj2
   rIkW/38LCBpQ1zB7H8xZWT3ECU6ADtWpqNxvN1GWc3ZsgKB5T1Hd9H1xx
   Tw1AAZhT6QLlGrcu46TqzQOEuUMGFUdH50SLaMRGnCt1rcMQbvtRSCkRI
   42/DqWzP3qVge3pzEDHzQCQbMZN4f2ePPduIzi+3ZdBx/1mTSIqhYvD5t
   X4ACf6huvU+dqnZFgAtybzHN3qFhwVBa76dhZRaImiduHP+ek8lzbHmWz
   g==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="197895678"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 15:20:44 +0800
IronPort-SDR: 3U0lcN1D94RO1lSrlsOnuiTzMnwBOAp44NBXVKWn0znodByMJgxUbMhKUrpJgcrwrlPRC7t6nu
 tvhB1V3dmDdRwRbLWLpkPwJqV1Y6sicUNIBE7HKM0sgB4O6+5oCTDh7ngaQlQbSIxPZPqFDsdm
 kkvpesmrJSzzhfRAJykncFucMfEhEy+YqAyb8/wlfQSJg1Lhc4ZmgBmN/RN/bVc9yUWFzbLM+a
 DWDS0uKOFFcVlbfsERXOo1m/nHanE0mmOZoXt8a9t/a4pmORGbsRy5T5V8XA3DBOlety78j/8k
 q2q87/qDpBy6ENN1auSV9sHJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:53:33 -0800
IronPort-SDR: rHnPfI1qMIRWlznpc+Q4m6kTW11X/MVVvy0XU+U5AU7Ci84wJl5In0+yWtB7NY6Pwhm+mdEOgQ
 yubni2nvPVrFx8rP0Hr6+GtYqm04kHpvQQtAx4itss+6oQtK7nBggd2DQu70fMM0KZA9xhM1L2
 iDa0RluX39+n04yhY4fHOCF9E9bqoPDV5p3J0bum7RfCio38YroVXJIcF6nBnzYEbIK6u9aZBI
 KHSwRu7JLxun0fiWl9HUsw7BNrLRPO+BOr9IowuO9JHYlmDmSv2ZU2AnncD1rkX42PCSqJjoHa
 we8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:20:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz8WK0MjZz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644996044; x=1647588045; bh=X0NY0a6YpTtJ4fZwapVFaRMSCmitIP8Nu/8
        M5EU2oZ0=; b=pYz/8k1bnxvNC8bcVousdaIM6yNgmMUX1goZtSmrWbUtPuC8Dzx
        JkovKlOSvU+tu88OPcfAPZelPbErNzSSvwq9ucZeSVY3DPs6pnbw7pcyyhoeYoUB
        TdJX/qslYWxTk4Em56x2qZK44KuWUHyVjcrKwW3OqsrBEYuP23bpt2pGFxuV3lmJ
        XD3/vaxfZj27W2Wefv14gezs8HVjSDqmHa0d4vfIIhk3ndgm0MrOx0+dJPdG3n6M
        jpPWIxTvfUy5s0Sm1jN4wQB8CJ0XbJv3Zu2HkoDexGZeYfcriLIslWBrTZBmQw1G
        jtlDlsRwVpoB28xwh+p+O1rWrSG+uDcG0fw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o69JuzHbtden for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 23:20:44 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz8WJ3BZPz1Rwrw;
        Tue, 15 Feb 2022 23:20:44 -0800 (PST)
Message-ID: <69253da4-064d-30aa-c630-7d04846ca92b@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 16:20:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-scsi: use *switch* statements to check SCSI
 command codes
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <7440bd27-b841-c3f0-2b47-4ab3f0ac0c83@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7440bd27-b841-c3f0-2b47-4ab3f0ac0c83@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/15/22 05:14, Sergey Shtylyov wrote:
> Replace strings of the *if* statements checking the SCSI command code
> with the *switch* statements that fit better here...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !



-- 
Damien Le Moal
Western Digital Research
