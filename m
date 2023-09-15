Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF2DCD37AD
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 21:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjIOVLb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbjIOVLI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 17:11:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520AA1;
        Fri, 15 Sep 2023 14:11:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B632FC433C8;
        Fri, 15 Sep 2023 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694812262;
        bh=X+2/0v9oqmsp8dmvgOqx0HzLC/TGDMHJZN4BepOEpgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPFNbQ4XwtjWP21gVSjr2ZSIxbCnw4wA2Vw7GPKfl7i3+nWfkRdoVy7PK9A5d6khA
         MlcDnVwKXwaXC7lJ9moyfFDQiccYWihse5kCgtM2Cjm4CnbSMrahkYnBAF75AV14Db
         vOD/BvL1oK5C9IkBSMucc7OjWFLARc3hoefWpxyLN/KowJ7i6Hka0ahn1/Vxxm+Wey
         GJ6EWggXzIhdi2o9jPqB0UTtsPNfx6YnbKfXDnQcKWsfHgtbZbyVsdLr5t0EZNFUDX
         KE9jO0ekjdlZYZ8+oY1B6w9tw2yu0FWx+8pj8POswWKlGmL2sKVb6invHmfATA6ysn
         K7MZM028QV1Nw==
Date:   Fri, 15 Sep 2023 22:10:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: pata-common: Add missing
 additionalProperties on child nodes
Message-ID: <20230915-boxing-scoreless-c0122ce3591b@spud>
References: <20230915201626.4180606-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="URaUg4q1ZuoWvvkY"
Content-Disposition: inline
In-Reply-To: <20230915201626.4180606-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--URaUg4q1ZuoWvvkY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:16:20PM -0500, Rob Herring wrote:
> The PATA child node schema is missing constraints to prevent unknown
> properties. As none of the users of this common binding extend the child
> nodes with additional properties, adding "additionalProperties: false"
> here is sufficient.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/ata/pata-common.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/pata-common.yaml b/Doc=
umentation/devicetree/bindings/ata/pata-common.yaml
> index 337ddf1113c4..4e867dd4d402 100644
> --- a/Documentation/devicetree/bindings/ata/pata-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/pata-common.yaml
> @@ -38,6 +38,7 @@ patternProperties:
>        ID number 0 and the slave drive will have ID number 1. The PATA po=
rt
>        nodes will be named "ide-port".
>      type: object
> +    additionalProperties: false
> =20
>      properties:
>        reg:
> --=20
> 2.40.1
>=20

--URaUg4q1ZuoWvvkY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTIYgAKCRB4tDGHoIJi
0pNIAQDzUW3P1K7UsEwSRjyW67b7+Fp55WzSLVGP60AxsPJqqgEAxkojoyZ4bUAI
8zMbWvQrr/JjeYcdN3yeufK16wOpLwY=
=y2h4
-----END PGP SIGNATURE-----

--URaUg4q1ZuoWvvkY--
