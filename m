Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45605C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 13 Dec 2022 11:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLMLiP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLMLiO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2022 06:38:14 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFA9B09
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670931493; x=1702467493;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wUEJFW+KogunDNViPWGylhMvmGvySw/HVUJy3WREWvo=;
  b=Kk84dwWD0SQ6Pdl93F39zysl36zwjSyyIcSw9fzVVwNthqepTNjQEC+n
   dvTjW8SMAcnNpiUnfhDqdWxsLjcY812aIAWfy2drBxtPzj7O9F8o6egqw
   NDJ0nB3HXDoW95jMTSd93KpWzn12AqPTmE0yO/ujxDPtINmlCU9t7W7UF
   jIxQEovy9dS6Dapdr3neFyNf7mTBqS+jbTXkF0ABt4tLhRAfYeXoCcZc6
   KAiemuw1BaN+kMFMduQfsrCm+EkB47TMOOQ1f7++ZZsP7rx0qAdxInvVq
   2rVJ4sIgEXO8Dlej08bDDgo3/iFYFEX1c+Rcw1CinjMIa8deW+CeSXgkb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,241,1665417600"; 
   d="scan'208";a="218531914"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 19:38:13 +0800
IronPort-SDR: EqRwcZRFLFJm1PG9/jhOuNbJGczVa25JY2H/4wS/H2AhOWcI8ZtCO3oAb7fugaZc6w93QAkGJq
 mGnOIANACiBa5rFJJQP56piWbqJdu8BY231HaPo44U+YhzVvaDZTdymIn+jcggLMPhnJ63DWkK
 9et+JyS9meE1NAgm1DVPj7h7pxeSBApujKf8PW5MhpIpUhxayaJ+Bv0F57tf+WzY3/NtplTUCZ
 Okey3/B6akZaZfabajD5RoJmfb78i6jM3R3zlOiUS5uFk6PzMj5ZmcYPV1kJXWTn1t/MLB7b0A
 vNQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2022 02:50:52 -0800
IronPort-SDR: cVwkYLwhaQVpzcxyaEjLS3utWPSfgj2SanczYZj9CEQLFU7FeBfOa0A1cYp+vZ6WYJw/Em49Fk
 EgD2KZtGS0oxyDMYHX9T4ZCqcOZQP20qIqG3Hw+m3QLz0+BeZzIITsvQCXhruwGO4MuA1vM7d0
 5xJNKrZAWrBw7cBdBGukKxHmAlrHlJ945TQkEvqK52xtnVWxx6QezRlOg0WWZD7TzzNt/ZxvzJ
 zq/6nQj1fzIWLpY1Xol5Wmr9MHPjd+fvByJaYZmCOmc4G48AziimzvaGDeW9JgRzW9PVxRyV1s
 WJ8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2022 03:38:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NWc1w6TMTz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 03:38:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670931492; x=1673523493; bh=wUEJFW+KogunDNViPWGylhMvmGvySw/HVUJ
        y3WREWvo=; b=AGE+S7l6X2IZ7gL5HyxTSBhF1Sd0OFWdAHeTNLBr6ThkcCV1iDn
        WIiktmBMoJTdlQ5R2Re8adLkGXnUR3+OlTRXt/M7BTMC8SN6lVDT/lbhyYUlBA9h
        zjdQkbelTv+Zp1QEG0zxKvgJ4Zc6Y/B1VWo22TRpy0yZ423MRUHb3khnFU5A+r8v
        2Jwd1jbbzaUvNoa0YONO+Z5zSAWbjCaoliAUrnoxYvYeHw8gYVFZQGzKZlY1a2hQ
        qx1NZvLhfCVHZW+DhD0iOVVRWVcIEyxnKt46nYmAF74Rbc7LWSZ7ntTfGGl7wtac
        EM8EAWUYudyv1NUe3WamjZwPRl1jvWm7AlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id shkatpEcjSwX for <linux-ide@vger.kernel.org>;
        Tue, 13 Dec 2022 03:38:12 -0800 (PST)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NWc1w1QM2z1RvLy;
        Tue, 13 Dec 2022 03:38:11 -0800 (PST)
Message-ID: <ada4443a-0c80-b689-936f-93cefe06fb2c@opensource.wdc.com>
Date:   Tue, 13 Dec 2022 20:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4] ata: ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     Adam Vodopjan <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
 <yYZw0u5_0qQf-imEIyKpbp2kriN50kP7Ig_mWjSDAUNHfPQaRlmcBdz_PLuf9vAR6EmuwLWvr15o2duq83yeE7wzcxs3TIVvWQU54-xZfWU=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yYZw0u5_0qQf-imEIyKpbp2kriN50kP7Ig_mWjSDAUNHfPQaRlmcBdz_PLuf9vAR6EmuwLWvr15o2duq83yeE7wzcxs3TIVvWQU54-xZfWU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/13/22 19:37, Adam Vodopjan wrote:
> Damien, have you seen this version of the patch?

Yes. It looks OK. Missing the Cc stable tag, but I will add it when
applying. I will send this as a fix once 6.2-rc1 is out in a couple of
weeks (merge window open yesterday).

-- 
Damien Le Moal
Western Digital Research

