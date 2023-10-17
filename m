Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABDECDB474
	for <linux-ide@archiver.kernel.org>; Tue, 17 Oct 2023 10:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjJQKvI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Oct 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjJQKvF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Oct 2023 06:51:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F7711A;
        Tue, 17 Oct 2023 03:51:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7994CC433C8;
        Tue, 17 Oct 2023 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539863;
        bh=I+hZXCRSadJ6Ma6lmW3r6cYmgD3Kp3hZpu79EC10yHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCSzJHabUzcbY0Ftxmk3DZ934hJeRo43luzPuEcl4P6rQyrO5+Q/M+JTXRGHLpT31
         9w5+DxCbryRStjrKzka2iSyCYCSfjUyh3sWm7f2Dcotq3qz4hBytpx3LYESSzNUv1h
         6bZnXgGbsTdGPzV91qkyvlG5gRshzbQlRk4hxe5E/mboxjAcMD8WX1ud+07KdDnraq
         hus+MJuWPEDOnS+tA97VidHfGhdwMtfkvVNBNLC//7pzkE/sUzU4ErnZVoBr24qw7h
         byBUsQ6PvuI+f/0eM0DXyAgsqTBNeKAJn5RltNAYAOH2JfyRsmgsbmiY694Sdn0Hu8
         YI2tSSJp9wvzA==
Date:   Tue, 17 Oct 2023 11:50:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: tegra: Disallow undefined properties
Message-ID: <20231017-headscarf-reenact-0a5f589cc0a8@spud>
References: <20231016155555.2974051-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D+7CrOTvugCnq/Gc"
Content-Disposition: inline
In-Reply-To: <20231016155555.2974051-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--D+7CrOTvugCnq/Gc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:55:54AM -0500, Rob Herring wrote:
> Device specific bindings should not allow undefined properties. This is
> accomplished in json-schema with 'additionalProperties: false'.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml=
 b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> index 3c7a2425f3e6..a17297cbefcb 100644
> --- a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
> @@ -151,7 +151,7 @@ allOf:
>          - interconnects
>          - power-domains
> =20
> -additionalProperties: true
> +additionalProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.42.0
>=20
>=20

--D+7CrOTvugCnq/Gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS5nEwAKCRB4tDGHoIJi
0qzPAPwPTStgsGxo3i7fsXQp2OINfuKyEV3O6xG5wvRqPuUZ1QEA0a/b4tlrqCso
Xdvq0NzJCTV9apOqJbMlYt7JIXavZwQ=
=lhzd
-----END PGP SIGNATURE-----

--D+7CrOTvugCnq/Gc--
