Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98161AA782;
	Sat, 23 Aug 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957338; cv=none; b=F3m5illEwci4xeYI8x9yukaMrjH/7IVKMOMzdsT+GbuZC1YF48hWR7wfNyAcKxHQA44eW69kY3inRaZMDW1EkzlGTffhVmtWGCnmKaYsyGY2WeyJlbp20QGiWtBtIPvRlb8c77LbGPzYnZYQUrJponMW59LlEDHfFio0Pl1sxGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957338; c=relaxed/simple;
	bh=1T0fJy4TvGOpZexytt/epjie/nm9x21/rlLayQXvLO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZGherTIphxmO3CnqFhYZmFRURFULwT/aG2saBPPo3OozzZaOaQphYmOlULQfdjf8yIT8+looektJsHnhhcvotcwga1v03DYw1agm6dSvGmVvUZCTG0rG9nB90TqjQ0RHy/SLAFiefUWWBy2td1hOTQIj+lshozJZlw+q68yTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJVeEXuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJVeEXuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55B4C4CEE7;
	Sat, 23 Aug 2025 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755957337;
	bh=1T0fJy4TvGOpZexytt/epjie/nm9x21/rlLayQXvLO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJVeEXuYP0RfDdZ8I11xlhEpOnFEBYrCOWS6zmC4Izeh5y8KFnokFMDIAAjg453/S
	 2mcISd/JW3UAmI1hgJe84KNkCW4A+u2+yH9EoXzovnfN5o0zUsfv1YtMl2shH/eYj/
	 SwmvSvZArkZRG60+37z5Qf4XvYA33PkvXEwpLlaAultwxObX5EzvwhQZTNd7KHcQYv
	 VAdj4zIajmyfIA2z8tSQy9H9/D7OYuQWjI6W04W9l2GuMJiGzVDoXNZcpzA5rml/LH
	 qguo2+hXtHn6fbiWg53/Hv+QklOgeZhFJqr+9CxeGw61+yO6/NgGHtkd1I+OsXOkBs
	 tb2Ab70qz2rcg==
Date: Sat, 23 Aug 2025 14:55:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: ata: imx: Add a reference to
 ahci-common.yaml
Message-ID: <20250823-altitude-scone-fe104905ff48@spud>
References: <20250822175830.91682-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YLXhgs2GKkKicSJM"
Content-Disposition: inline
In-Reply-To: <20250822175830.91682-1-festevam@gmail.com>


--YLXhgs2GKkKicSJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 02:58:30PM -0300, Fabio Estevam wrote:
> The 'target-supply' property is documented in ahci-common.yaml.
>=20
> Add a reference to ahci-common.yaml to fix the following dt-schema
> warning:=20

Same here I guess, you're allowing a bunch of other properties now, what
of those are actually permitted ones for this device?

>=20
> 'target-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/imx-sata.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Docume=
ntation/devicetree/bindings/ata/imx-sata.yaml
> index f4eb3550a096..c60866544a53 100644
> --- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
> +++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
> @@ -88,6 +88,8 @@ required:
>    - clock-names
> =20
>  allOf:
> +  - $ref: ahci-common.yaml#
> +
>    - if:
>        properties:
>          compatible:
> @@ -112,7 +114,7 @@ allOf:
>          clock-names:
>            minItems: 2
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.34.1
>=20

--YLXhgs2GKkKicSJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKnIVQAKCRB4tDGHoIJi
0iBGAQDReLY3tpmUuqLBQMcKz7vUM1f8lnHUeNMEF3oRrAbavAEAwcUgyKhkYkBR
dJvbf3GpZ2x1GJh+9ETApiZdzccG7w0=
=6rlV
-----END PGP SIGNATURE-----

--YLXhgs2GKkKicSJM--
