Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAB320393;
	Sun,  2 Aug 2026 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785700658; cv=none; b=q24T4ZILMsm3WvyvCdDgJsvOqOFH/Gs3fB36Csjkm2iT8F8OPNI6wJR71lzJcHRBrd2amYDQIKgfnRZbUU1yZwldzWLx767KPCiH3FlVJFo1TNK+SYpWzh+tPuTopf3EbKblWCgg+EQRj7OTBQ0stqtpzPM+AXEgxx5WcqC5M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785700658; c=relaxed/simple;
	bh=NBki2fPqAF3R2oubXThTUCCPv5CPCuWt3NszO2YLnfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cu+fx+huATF5eg6IxMVX1iPJUq/HLyzGDuLO2tImuocRN2XmuSsJIc+HHrRhfcUeuOnaIIE7g13egWeQ4oV3b9yNrDlU7It/B/Wv5uLwTmHWtF+L5z0PpNGmZqo77oz6Hb852qxStaULxxYisHlMenDT0zlpyTHoKstklQuro/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGVicfUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGVicfUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325651F000E9;
	Sun,  2 Aug 2026 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785700656;
	bh=2FBnVorze0mGUMFhKixNlw0OLeUgjg1WcovYGQUNhYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IGVicfUI034aLZprr4H9yVgrVI4h7PadJhcG7/gUz84EjmB4LnuUI8SFdKrubjxKb
	 slSeoEP0N0VyQwV0wt8dxozRxL5Q0ghXKWshBGKSw6XjzOQUjzMQp0rUIsgrldDDzz
	 Yq+c4ZZz5qG0VfvgNJWjqF+O05zUs9gezi5rX92nIV1rDoF0zWKmoM4/314D8ZKwjJ
	 HixQsGdkdSWgzSMWG84bbcVBwWKwBy5nmA91SE4gOLl9oXeptqOdbTkealwCduUC7d
	 NV0dnqxjheTjivV7j0qAlYEFRdyKicKSM1kpVv9CdY8244Ssr3WOPNNNMzdGoJInUt
	 Wym4Ya/zT/KFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Correct white-space style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, cassel@kernel.org
In-Reply-To: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 19:57:35 +0000
Message-Id: <20260802195736.325651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

> Correct a few white-space issues, like double space after '=3D' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801195613.2354=
30-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

