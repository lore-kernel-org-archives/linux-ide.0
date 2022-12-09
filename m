Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4EC4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLIB4U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLIBzs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 20:55:48 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C07D05B
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 17:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670550869; x=1702086869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hnnJefGOEbanYyLY2oNygmUXo2NPSdyA4tdhMgHSjus=;
  b=cLAqaB3nXqulQs/TvaQuYvZcx1TVPdc+qxz/DIatFfoWFEYxV14Z1LtP
   pumQlJAUe+oNd+R7Wa5QfKUMGbqtvvpMPtorxh/5Rl5Ghtih6YkIelwy0
   y94Xl1g6xBJ1rFRmUza1ar84EkOoWIFai328I7/hxxC58i1xqO8ARsbT5
   giTewggKuTtsqC0D8MbyE8Ah0d7DgRt1EuUnpucY1TdqIyFa3+WSRoJQa
   5CVnF+eM4IkDVFhaSRqKEPW8cIvv3/b7xhhG8w2BAzeLNAOOKnyigoEiR
   JzbhePHiQXdAcSJRNJ1CI3qSgbXyfDXDY0dPQW4jHJq9CuaW3WwPMMa9v
   A==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="223393338"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 09:54:23 +0800
IronPort-SDR: eSXAlDjLvAZpFhYGrLTKcnJ2q960+pyPx8fArnQbcMHhb2R7d40BKxVec24cFo9S0xHV8EIs31
 CIVCyXo/zjlWcRZhnFeNmXrd0Z5xFt4G3r2xqtjIabLhS1POPWrNR7r+hh8q9xxMwvTUdTlHwx
 wlIAqBJ1JCQRFLjDxiDpjF3EpjOQcDPiP+y7resiRniZBTlfx06Kj/nj8qjekcZuwS9OtNE35g
 sWSlLGrGd56+/QMcb3Ak3x2NQMxEhjOCsbolYOxhLMiaLySdGlbKBv7V6ppxLxdXeWCGqEo9Ql
 sbE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:12:52 -0800
IronPort-SDR: iIdcKNq7FnZUSC7w1F5QstDkrskQaqN1WUr6SGcJqu3dYPhCmiofhK6M3gGO5WQPQHMeD42ivF
 owfL/AqZTlT5Z9/Jhm2g6Gl5OLjvZRfzXgTv1c9w/S3H03IVXIkBXPNV+yauxohY3g7Qe5knGW
 3uHOxqYT6tuIs6uvutaRsUIi2TBsvpzQtPtchmXvlELt6QoogwDWWJVY+QD5bS1EhocZTOOvX/
 xzBZ6Se69SIHVXjAV+PffmEyZZyf6b0apYNKvzdn57gQy9h9lXucbPIFwTlJEYDe1+jJEBYb/F
 9ss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:54:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSvG72srZz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 17:54:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670550863; x=1673142864; bh=hnnJefGOEbanYyLY2oNygmUXo2NPSdyA4td
        hMgHSjus=; b=HYQXdeK+A57ttB1vkP82uCjzHKAAyP2Q0gqjmexl7Bawzvfs60h
        EG6eb4bzdCJcKP7RdVRXigWMWecQVSQjV1kixp9dSeHa3nfInVeYdMWDBzqdDmlK
        4ybqmZu6Kt2t4JAGOoAne0mfROBfdzOJBm5nTiM3UbcTMlJhnFam9On05UIwUNIX
        26s08FM5sk/6BoaeVz34nCr1KU4C3m+vsQdN+i5lEmWq78Ww/wMi6qVhG3SbsAts
        G08K1ud2Due+CaW+qSUCo1FbM4VozSXpEddsPZwZAdOENUCYtS62NC55uupJcMn4
        L3mDV1uGkh+2AFUZ5qIljQmMhnQ1MVtOdHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7pQddn8WM-C6 for <linux-ide@vger.kernel.org>;
        Thu,  8 Dec 2022 17:54:23 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSvG64Bqrz1RvLy;
        Thu,  8 Dec 2022 17:54:22 -0800 (PST)
Message-ID: <2964a457-4b27-82e2-57a8-646370f0a4d4@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:54:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     marius@psihoexpert.ro, linux-ide@vger.kernel.org
References: <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
 <20221208212616.ghplickz23h3iv3y@pali>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221208212616.ghplickz23h3iv3y@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 06:26, Pali Roh=C3=A1r wrote:
> On Tuesday 06 December 2022 15:08:33 Damien Le Moal wrote:
>> This essentially disables the use of ahci_mvebu_stop_engine() function=
 for
>> your adapter, that is, it assumes that your newer adapter is not subje=
ct
>> to errata Ref#226.
>=20
> Just to make it clear, errata Ref#226 is for Armada 3720. Armada 385 is
> 32-bit and is _older_ product than 64-bit Armada 3720. Marvell naming
> convention is... well unintuitive.

ah ! I thought the reverse :) Indeed not intuitive...

> In my opinion Marvell tried to fix A385 errata Ref#FE-8889968 in its ne=
w
> A3720 product but broke something different which introduced a new HW
> errata Ref#226.

--=20
Damien Le Moal
Western Digital Research

