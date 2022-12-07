Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78343C4708D
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLGWvP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWvO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 17:51:14 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B495CD09
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670453473; x=1701989473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zigoZooDR00g17PMT00E3FfXEz7ln39CAkVaph3qc8M=;
  b=kqtiOdLRdz3cXrv0EZOnQucGslKg5zekXNr9Ec1NbFHMKWGopv8xX8r9
   zC9DVo/pzWnCPW1U6ZEW376BorFmK6q1UE7U2wXPj4ynpviXl36crd7QE
   Hd5HobsBdD2V9c3dw0RgVBodCYBZbyC/8YyU+5+eh24ew0ib5chcYqIsl
   kdyw58rn3KR6JltgSvQDUN0SKqPzeHGlp6+SY6/tSSdKsd4qwTfjF/iMc
   20UY7h1pQ6hC1pl39iXmFJowBSTICOSAmLvxZohZIbGpkVnyQwg69EbpF
   H6v3JfYNPDt3WYS+0Lbusdu0/mSxOy+HGsyv93XYDGphIi/Bn0Zk+URoh
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218402608"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 06:51:12 +0800
IronPort-SDR: DWbKkYmvIal3NkTsPE5PQpRA7ahrNUnMlTNRsK1lFJM7tm+JOkymvb95UaxJdh6nrBpFPDjkpM
 SAbHM2WXwci/MOLVJj52gcK5Prt5HWy2XIGe5+Ckrkb0geVoiZLK+MpE1R77xK/Zcwuie8a2iC
 Geo/W5WNqvDdQMn0oTH6EMdIGB7PaXbLL9Qfb+7qEvmlp3uf1ZaH6XGW1BIl2U7jcls+xk1zhW
 BhwTthb9HHaCIP8ziH60wyuctteA8Ku79MV3tIivi8n7hzWY5R0zOHoHkeM5SDKQZXgjFzuPjH
 KK4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 14:03:58 -0800
IronPort-SDR: Jh6HSB2UVjzuy0/oQOvyUpP/I8ez7O8hpojtJtMmZwxAsgOflETQQG8RIqp/EKj1WPWUji+tMt
 eNULHdqMUpYZtcqqql8K6U/jD6iceiFyCJmN0wgMKdWUjYIuBOI3yxeQDF3gAaYGFOk5g3WpXP
 zJoIcvT9vZfaTMWANO8EbNlhAxtZHp4dFyTO2arbc2H8z0GKS47pzBZkreR6vsVYmvYIMKzwY8
 Qkp5QnNhEB6j13Znly73vX4nJkjqhR6WhATSmsy3I2bZ6B2dOAIDW/RFCaTrjzYEYheh6y6eaJ
 WPI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 14:51:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSCFD2c2zz1RvTp
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 14:51:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670453471; x=1673045472; bh=zigoZooDR00g17PMT00E3FfXEz7ln39CAkV
        aph3qc8M=; b=HFXW1rNBqvvRCtwg+W3I+CW9d0a7Tq4iq1PKr1PpTRa7RxTL8zw
        wA0fz9MfjGtz1pTGxrzkQH9Y8oe9RPPcud7jinpXT6QN3BrwMM0S3ZujF1sxox0o
        RRnUZXKdBRI8ezRXi8/D7BLlkOn6XdvVVu/fnchs2AeGWe7R0L/GwBhpaO0cLkJI
        ClsMv+h9zTefeGzVGCke+MNRDBiHUcHT4OiN+CEu523y/AWM1NlvkUdR+jsfqqJ1
        YSvixSJQ+wjCUDuJMMoph82TfR7cUwHJM3mz+JmYtm38dN/ZN4iIyG2ms8JV9okF
        DrtSHDjsM3y163jZFd1VeR0CIXfaURWY+zQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7sQ_iXWDImhE for <linux-ide@vger.kernel.org>;
        Wed,  7 Dec 2022 14:51:11 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSCFC318Xz1RvLy;
        Wed,  7 Dec 2022 14:51:11 -0800 (PST)
Message-ID: <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
Date:   Thu, 8 Dec 2022 07:51:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
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
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/8/22 03:27, marius@psihoexpert.ro wrote:
> So, is this a quirk of the mvebu controller or the Areca DAS? BTW, Areca uses some mvebu SOC too.
> I'm going to try the Areca DAS with a few other controllers. I want to see what happens.

By the way, did you also try a cold boot ? Switching off your router,
connect the pmp box, turn on the router ? Does it change anything ?
ATA hot-plugging tends to have more problems, so worth trying. The
ahci_mvebu driver errata is for hot-plug, so this newer SoC may have
different issues with that too.


-- 
Damien Le Moal
Western Digital Research

