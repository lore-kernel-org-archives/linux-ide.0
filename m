Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C5301484;
	Mon, 25 Aug 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140256; cv=none; b=Z+Bg3aVI5bYWpmvO1+q3HpwdmMzXrFfJ5DpznB8EdTgOolWGyEc2gL3P/3dTR3y3zBQa56bwJQ1oh0lzf/budSMBAy1ROkNAZm65nyQ8ONi3GooRHNE8iShCtxkNHrcDyfae+i42ehp0MY7bcvSaV0ZUmfdjCZcxoUmAH60AYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140256; c=relaxed/simple;
	bh=o55sJGzHZ4HMGyKiCmD2WHrQuV9GwCfSRdmeyoJ3czs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvkiGeVtQwfIMVuRQKFqw3CBbFg72DzeGbgyUxspayTdA70ipZBg7sedsxQ17oiysvGxT7uMauOSDL2GKZE2O44b2TC0PiFlT9TPiF2l5z86J1QdyC0GaLJZNK1PY6SMYXO6TLlM867w9BJ4BeindqMN8dCagm+J9MDlkG+vpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORDUHqVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORDUHqVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58868C4CEF4;
	Mon, 25 Aug 2025 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756140255;
	bh=o55sJGzHZ4HMGyKiCmD2WHrQuV9GwCfSRdmeyoJ3czs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORDUHqVSr4ML+Dgl1RLMXK6x/3VSGm5v1Jt0TWaraG0yYkE33CTd9NZ402hCF5ErU
	 ie4E0dKicJhGNHpNbQTpnRhcuKQfgCF2DoiFeKpYbpzjH3wZ5ftGTIbUX97ezazeUJ
	 BAuMcboVOGlR4XWcIbQDashDlyoSkykww133YchJ6w6H7NUC1rvJlofWQZ9Kq4lAdv
	 3yt87AtMgZeDyyoi4H6qH6Ft1tj82mXb19XKTEcWQKce/URauowQ96m5HVjcXtMtWF
	 S/LNDGpY8oO6YDidLSeuJOLVIfS4lEIls5cXQvL9Vr6Iev+4+N7oLU2n4XUWhJJKxf
	 cbgyzNZ/8yjkQ==
Date: Mon, 25 Aug 2025 17:44:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org
Subject: Re: [PATCH v2] dt-bindings: ata: imx: Document 'target-supply'
Message-ID: <20250825-overvalue-staging-a2c7a2980346@spud>
References: <20250823195021.300488-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Cg6cIXLlPNl3oFo"
Content-Disposition: inline
In-Reply-To: <20250823195021.300488-1-festevam@gmail.com>


--5Cg6cIXLlPNl3oFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5Cg6cIXLlPNl3oFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyS2gAKCRB4tDGHoIJi
0iSTAQCmYAIuWaqF9QfbaEhh4asarDd4ysMGdUPoR09AnxSW6wD/Yj/CpQM5uuOf
Cels5vrJadqlHDsn3NKzXqC2i11I/QI=
=olb2
-----END PGP SIGNATURE-----

--5Cg6cIXLlPNl3oFo--
