Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF77C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 14 Apr 2022 01:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiDNBWr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiDNBWq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Apr 2022 21:22:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892F15A19
        for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2022 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649899223; x=1681435223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NVFAzDnsQ354GyXuIYltrailhp4dGLh0c+RSUtV89r4=;
  b=k+xrhR6o+MTdjEBG1pql5DUdU1IbXkvMPQATYN30zLvH1DebjFsiDkxU
   kP8i6sH6j3GLKULipRD0UcqlUHb67HaqkuyeRb5XpW+70pH/aoYSvTRgU
   rEMyalUGcyixUcShIv2fYXlcK46l/jUIngVNIewJRsjt18EqU/kZRXp4z
   bECWuQUG6ZH1B4kl4D+saK7Hjl2NPcmgRtffAldZPhO3EFEfpHjHcniXE
   0h9lhoPFWxARth/CLDePaVBoBa6ftNUErn/waEogtXbcOz7FNuZ9AUGNX
   ujWlJwzKTE9iIG9EfbcNb1AdS50dpDGor4IRY6UMdhLiWPozCIkAr0T/k
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,258,1643644800"; 
   d="scan'208";a="309830318"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2022 09:20:22 +0800
IronPort-SDR: hZ5egLU9eScVM6LeRd4O3+SkFRSOn6ZGLuveR7tNmkmgkJkVV+Bsb7ZqMJbkNq3tcLy/pewMC0
 +A499SXOUtF/Av5cttHZ64G3yyMYMLm6fMk32y6RXBdNCgTVsv06BdcSZH/skSqg8UJOq2ckdz
 4tWvAnS5/b2ffG0ZmrmGHoIxXpio6eFHpjoFInmi7AbntXjE/PECZOOck7neS9yHfW18Gv8A22
 LMOB1DrHhVqvu8RlrsbhMH45ncvJr1dK66LukEYTyhhIJufCY2OXPqgf8mzCPYw7iakhOhGn+n
 dP0RyfHZVqd7NPpEDOpwNcZM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2022 17:51:35 -0700
IronPort-SDR: Kwmr/KEhalM9k0MY4MIeABH1fBCqKV3/HP2eeowK9hsPNtkunKL4+PgB7GLpa3a+rvlSdRE6TP
 QPJUuB7fsfkt6qxyMxRYrOWS08bGMznRYNDUxM9Uvfxxa/r2soVQ3nJ/DS+Ha8Wi1t/lUaBLmH
 vDCAtHUuP8LI+Q88HCfwCJRCDGz3ZwnIcQrMWk7U/gKAOghEU1xCyim6VcObg2emp+Lby/ofkf
 1rhB3g1laBM32IxuHDP35pH8IzFbV1vzqbGqENXir+ZFgKVE+vzHrj6h1/NNA0AwXxfWVhtRlw
 g3U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2022 18:20:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kf1q95Zdrz1SVp2
        for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2022 18:20:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649899220; x=1652491221; bh=NVFAzDnsQ354GyXuIYltrailhp4dGLh0c+R
        SUtV89r4=; b=QR0L4tUNj/fPH0QWrHgWs5PvNLZOlWcAJblSDDgryZgy40/w7jv
        I3siQwzB0M/U9kw/WeHrz/xB87pRBJLR05SpUmCo+hkfdI4FLmbzy1AgdxtD7BK5
        355CzD/siJ4isBCNJDPJ85NlKdP8TB1BEsbIM2stPEEj2aWuH/Ljg3fj7nkATDLS
        xZ9Sii95lwbJpTu2DU0WIz6TkSQISFLUhUNm0p3xRjQwNB03rBSK7eUiTWWht3ZW
        hCT1K3cS0M8SnT/08/9URXqtTIvfmIH1+lfdTXMS3xT7txtIE2SdDfTLT7jJyqXx
        o1H7RRW4SxhaAzmz6SmUCWvyXbMOafLFmNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U-Rep0prlz5a for <linux-ide@vger.kernel.org>;
        Wed, 13 Apr 2022 18:20:20 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kf1q70qcxz1Rvlx;
        Wed, 13 Apr 2022 18:20:18 -0700 (PDT)
Message-ID: <c7f6dba6-e721-b907-0597-27f636d25a32@opensource.wdc.com>
Date:   Thu, 14 Apr 2022 10:20:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WARNING: UNSCANNABLE EXTRACTION FAILED][PATCH v2] dt-bindings:
 ata: renesas,rcar-sata: Add r8a774e1 support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
References: <5861565a79a2bdadc07ae84e23e6d96dbb764823.1649680949.git.geert+renesas@glider.be>
 <4716ac8b-acee-da06-5fa1-34eed07ba4d0@opensource.wdc.com>
 <Yldzw63tIdKhhtA1@robh.at.kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yldzw63tIdKhhtA1@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/14/22 10:07, Rob Herring wrote:
> On Tue, Apr 12, 2022 at 08:05:42AM +0900, Damien Le Moal wrote:
>> On 4/11/22 21:43, Geert Uytterhoeven wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Document SATA support for the RZ/G2H SoC, no driver change required.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>> v2:
>>>   - Add Acked-by.
>>> ---
>>>  Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
>>> index c060c7914cae6573..c4e4a9eab658056d 100644
>>> --- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
>>> +++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
>>> @@ -26,6 +26,7 @@ properties:
>>>        - items:
>>>            - enum:
>>>                - renesas,sata-r8a774b1     # RZ/G2N
>>> +              - renesas,sata-r8a774e1     # RZ/G2H
>>>                - renesas,sata-r8a7795      # R-Car H3
>>>                - renesas,sata-r8a77965     # R-Car M3-N
>>>            - const: renesas,rcar-gen3-sata # generic R-Car Gen3 or RZ/G2
>>
>> Rob,
>>
>> Will you take this patch or do you want me to queue it ?
> 
> Please take it. If I've acked or reviewed it, I'm expecting others to 
> take.

OK. No problem. Thanks !

-- 
Damien Le Moal
Western Digital Research
