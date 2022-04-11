Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD9C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiDKXIE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 19:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDKXID (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 19:08:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0460CC
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649718348; x=1681254348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wuv82C+NThJ2LAyrvMNDY/iIjAzWwWVaRV90LnNl2nw=;
  b=aVEj2ROh8py6s654WV2lHawT7grHAhKSMdHc7+J+5boqp2L2DYwTbhxL
   xFAOXC+O+VFV+r3+Sdt8m+3lLEtIAhazG+jzTNRXr7fcbZmAjCAXIe4Tu
   blSMtzAQ3iIK6KZ1eGUyNXFv1Q9bOBDdVno8ZrW0gZ4krtpYeDnK64KwU
   R+L70DTWDrDATMcTJj5rovB2oNQkQRKpitPdQzKBUy+T7nlT8iGRHQdpl
   gjL6H/pL6JTtyMI3vLPD9cdzHu1fSaFGtzkrV8LO2KVbjXIxSxEIS0m8o
   cvcPc4+M+C/Vc2uHk8Ttg+Cdz9N+gEcf0rEVV6utH/6a6Kjm0iAfLeCxb
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="198568475"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 07:05:47 +0800
IronPort-SDR: iRkn+8YUKgJ+gV+qjzIn691kKJyIa8BPeaF8rmI8htG1oNj/T0//LuJF+AKBipIng83qjiQsMY
 5iMunMy9Qr3wM4gOyaRTquuFA+kNBX/A97HEuRUdVpFyI1fL+AyFviMmH6NsvYkde5VmSwBRV/
 voPGfE1TCWlnCVNOPFjJdeYH9p9qeJdrafVLjqC6i77qDGzFhmP+IkN1QA1rlT6f51WISam3Kd
 /kLK1h4pXEJmGdh1SlGDPuypEhysZ39rCZSmb45CRWANdPMTlJB0cLp1J9i02HYD+N+G3IS58j
 tzHPESW7u0dUrrZcAgigC2RS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:36:15 -0700
IronPort-SDR: OmGElyyBiFWRf7hOBSHv2LxqTLN4/03N35j74Z+uE3L0hckXLl9WbYhvFy6DDJo0w0lplVBlWt
 5Ag0hckcrJ89aVfJPrL4SNP/cq0BYl5Q8DqAEIPu7++U2q8EFw6TLEJB0s0gymFNT9Qo7exsfB
 IqbSSHq5RtFdrZp/k5VO9t0/iF7d++xwU/JLBUX+Tznzfe17SUqSXVlhIo+ZlgbimrHcAsuTmL
 /S2E9JCMn7pueEpGIHVjvMZ0O/CvMKH4M7wqMP/W8HHcfii9Wc36vPmjkHFuGfGJEZ+quiClz6
 lTQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 16:05:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kckwp0vsYz1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 16:05:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649718345; x=1652310346; bh=Wuv82C+NThJ2LAyrvMNDY/iIjAzWwWVaRV9
        0LnNl2nw=; b=IzT1lVoemoVGtrP39rzKF5oNCmsWW7TP0fPaOwcx4bhWNZV9YVk
        y/HCqgVVG8eUEWd1slLrWl5ZW96xMz/6M/BnNEa6gsDPULtvagk4LQfWNGNejHIA
        3lCWOcMjQy3dp1zlD8TgrAt3dxl+6/BcJcQ7CRj0gPDFW/3hNqlm/E9yNckD/L+8
        pKH2d6fXyr3GU/WM+Ohex10z5TjyKmLpxsay4FK9dWe4gJ+slu4FYsAVaTMtgREL
        KGWOpjGXFYgPvnmAuWSF2m+tPVZWb4z0CxHYqq/kv1Nl+Dgku1GeAcFKAAnS280e
        Rm5VTbwLnch294YMOIhR8GHj8lxqGfIbhxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C9wqZ5hAM9SZ for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 16:05:45 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kckwl70RLz1Rvlx;
        Mon, 11 Apr 2022 16:05:43 -0700 (PDT)
Message-ID: <4716ac8b-acee-da06-5fa1-34eed07ba4d0@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 08:05:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WARNING: UNSCANNABLE EXTRACTION FAILED][PATCH v2] dt-bindings:
 ata: renesas,rcar-sata: Add r8a774e1 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
References: <5861565a79a2bdadc07ae84e23e6d96dbb764823.1649680949.git.geert+renesas@glider.be>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5861565a79a2bdadc07ae84e23e6d96dbb764823.1649680949.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/11/22 21:43, Geert Uytterhoeven wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document SATA support for the RZ/G2H SoC, no driver change required.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
> v2:
>   - Add Acked-by.
> ---
>  Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> index c060c7914cae6573..c4e4a9eab658056d 100644
> --- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,sata-r8a774b1     # RZ/G2N
> +              - renesas,sata-r8a774e1     # RZ/G2H
>                - renesas,sata-r8a7795      # R-Car H3
>                - renesas,sata-r8a77965     # R-Car M3-N
>            - const: renesas,rcar-gen3-sata # generic R-Car Gen3 or RZ/G2

Rob,

Will you take this patch or do you want me to queue it ?

-- 
Damien Le Moal
Western Digital Research
