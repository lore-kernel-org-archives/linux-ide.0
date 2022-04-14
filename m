Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E1BC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 14 Apr 2022 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiDNB0C (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiDNB0A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Apr 2022 21:26:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AE52B09
        for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2022 18:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649899417; x=1681435417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTiDrR+9+HtrXE6ySpJjfWH7TrMfuwUMNxxOhskx1yg=;
  b=r6roO7YWZ82rUjf+HQR9gvzHHlplnLMUWP6pqX7Q+tHio3qUz/oLpERk
   lQlzEX9VdTI4Ywx/OYDUeKTXJo2Gu4q4ni73cfEg+GU2dunw7ihoQytBL
   BBvhSrFlsJMrkpAgSjg0zEy3A3hvCuSuzX8ZruuSZUlfHQUEJAUhN7yTI
   yIEL5Bmq6NgPP5LVIoOHPJ9tXqqDH503an/17JySVDs9TBjBH9RE72cQT
   8+LAbl0N0FNP6WyGkOXCy2Z3YzjwDlieg0JWx+MhZ4DKaALub74kQDMmy
   ivwLVfrKhAEwEFjaaiNaTmyMHfglcof4IXrzXEKKAlgv8vSAWDVLvIgve
   w==;
X-IronPort-AV: E=Sophos;i="5.90,258,1643644800"; 
   d="scan'208";a="197870343"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2022 09:23:34 +0800
IronPort-SDR: AzNjWc02hn/MG6dpnVhfUqSwzixA1kWRxMF4rZ18svnsXHRzaTFvlQXlgqadF+Vtt1jHN8Nfn1
 ddJtlNGAm643Sa2nA6cBS6iHcZFQ0zpZWSduE1hWQ3BFj9DjtlhRfYmrIAQbk6hnI4fJxcRXf7
 /GO3JAMiL1ZgHSNnu6IxeA5ma9YH3tIr1Esu52Du9cdvZmJHsi3aQZMzHgVMngG59+4cH3F3LL
 bhnu8Z9s0yfYntJUwaVUwp4gjzFKSOxLqVAAX535V18Q/xBUd3BMoLAQLfPbxJWN1+W1aRV38y
 3hFdsZqjG1QBWWRIoAm2q/a8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2022 17:54:00 -0700
IronPort-SDR: 9KmYML+O6T+0Ngi+nSwSY/qjvXoqMudUwfVypYB5aDfWNPiJyDqOuCmqjKBO04gHZgedclI2QE
 c32M8GpN1r8UCG5BcKeJnhahy5cHodL8wHTwuoCPTOKFFGPWecPRjDdXR89trAu7PfWx1bPFz1
 nybO0WUq/zETATdjv6HwkNsWCzwxJmR5ezhjRypv4HeCnuE26LrZ+uN4x5xNB0Io94NH/Ox5DU
 SdSbnZC8qreyucU/H9nGzwc9d5XCeGSq5EaiEFYcAZ9mxbTjHVBElo4oWwMG9+38OhWFfvQqYd
 BoY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2022 18:23:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kf1ts6SpPz1SVp0
        for <linux-ide@vger.kernel.org>; Wed, 13 Apr 2022 18:23:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649899413; x=1652491414; bh=gTiDrR+9+HtrXE6ySpJjfWH7TrMfuwUMNxx
        Ohskx1yg=; b=dgQLps56fZW7FKENltVyV6c2ImBMbpr2Gd//Mb1NOGbu3vE7NZ4
        wk/ZVv5EjehGDxAa6PfKLqLgl3rYFaYP4bEym9Yx7BbSWcCVlVkHyEGc0bAaNJ6n
        FU+RvrTdZ+0jfG+O66/SlIYxNKyCc55fesCu1vmMW7sg3R5MMqsVQeGXiPgnxw/6
        wxu5gS4ZW+TKRogkkTuzk0ty4SVxu5N+E/FBiw09mgPhrS4omYnz7qqjMnO2QoSv
        FNY1rZsPP7Y9AbLdBnSVKaLvmXJ1YE0JR7HiZf+/2aWWiepNl4GygvWjgVIp3lEw
        sgw1+llmfQrx9FT/nM2kM1zWIhkty82Bp9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 51VwFSRaIRM5 for <linux-ide@vger.kernel.org>;
        Wed, 13 Apr 2022 18:23:33 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kf1tq37zQz1Rvlx;
        Wed, 13 Apr 2022 18:23:31 -0700 (PDT)
Message-ID: <95580a26-8595-1fa1-5e3d-112ceb767ae6@opensource.wdc.com>
Date:   Thu, 14 Apr 2022 10:23:30 +0900
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

I queued this is for-5.19. Does it need to go as a 5.18 fix ?


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


-- 
Damien Le Moal
Western Digital Research
