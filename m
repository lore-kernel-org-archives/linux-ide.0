Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AA187FE0;
	Thu,  2 Jan 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843495; cv=none; b=iW8x1OHWEPhmoVsIvh6Hcii3dKV8dwXVBWfs2G/7cW+5S6wXM3ePNvItl9fb+XbAc+SWOE+JNpjORaqLeVE+5FwyOpCnZuNKY57G8TxFLmV+QPSquSRPr5o8nx0dVf4+xd1QJGkzwyyEbz+TFY9Nft1+KQciP/xMUR7sk69mPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843495; c=relaxed/simple;
	bh=hpqHInndrX0iGC8mDRVxX2kXaaLKhzvItMvT43SHJpY=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=X+IqII7klxlFIVtM4XC5/+MlZzDgInWcqi1kougRE2uh4/QkQKdDiAXgoDsG2i+eFyd6L1XyrG9LTXMRjok71/lK0rfZ8tkuPVIkkzJ0Lc5LEaHJUaFW/ghUNjjQLFQK8DOUj7I5K0vAz+9OPCCepuYAIHaYcSHBUTJSEOS1RPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=czAnAfJv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="czAnAfJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1735843472; x=1736448272; i=frank-w@public-files.de;
	bh=hpqHInndrX0iGC8mDRVxX2kXaaLKhzvItMvT43SHJpY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=czAnAfJvyfCPY7k+3SedOX+5j22KgAuZEKbaogkJxYEYfQA/xjJqscTgdVpSho5y
	 yr8sFi26elQBD+v/y1QIZakF8LS5+2pKYpqfXCLPFTfontfOc6IhCF+0AIEcti08K
	 wgqiEfWU5kf4QENHTAXMkRIfR7js1Hv2ey9UgSS9pLy28kTOkGt5f/pONkTY3TeS6
	 N93hpSdS7o9Nn8/EMLXhYVLPzrGO9oYi4sw42saGpzYvUbFvPlSrToBnpmOgIZQWo
	 pP6ps1EI01YgbsWjGbm2ZXe7I6htsBSNAifY9bpS6CRPGlBC806XD7tIuAyYDh2Fk
	 UiXebI6pDnzfq8gfAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.146.33] ([217.61.146.33]) by
 trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9 (via HTTP); Thu, 2 Jan 2025
 18:44:32 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
From: Frank Wunderlich <frank-w@public-files.de>
To: frank-w@public-files.de, robh@kernel.org, linux@fw-web.de
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
 hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Aw: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf
 conditional failed
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
Importance: normal
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org>
 <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
Date: Thu, 2 Jan 2025 18:44:32 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:LKNy9zKfnIlsz7NUTXXOtEKLalixuZlk+xPaKuoJSdmQlGlsQx4AHf7aFI2bc2+IWYKZR
 dP6v5jF8yrLsEik2VIZBAoJI6iXtONPhog/afX5jes7stZx8sYst5CG4v8dE6nR909gcT81UTMGP
 muBoR2ei0nmBt/xWhWjMlcwn/HFd/0XygDl8os6f2mJ+U8hr+Uq3KK9yHgsbN9NoI1yGxbSw5kda
 sFn2HAuqTFnvNa2a5pUQHLSxJ6NRCPpOeen1zr4OWmz3aKe/c0d7w19hXa2MBLWS176NVRrAaMKd
 NZB9O25GEgJfAcmTlXF0JxZN/NaXL0DQzRsig9JsqPBe7JDIGVinhzRCzn+WZYFvas=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NLFJFR0ukHI=;pAc3xJgcxNOAej0dcvwuoRTuUqw
 1pXdfaPiyFRb177kwNNvFaXNQis5vPl70fEA1hQxWxxzxV3eMDgyTaiJT/zpPuW63KNfwHD/2
 4vh4TZyQeQEfH9kYItPXqtshaHji+C8cCb26+rEpDQ4o/0SirJYUyiG8A2vdiq9ckmbjlWwYt
 o9KgKf3fLjLf9TaA23GtlUeAJRvg6DSVVE643BMiz+gULt+XbPBKcOFW9F+nPmOl6Ajy83LYY
 ocqQJhCGV8v5xPvqZ5nTTlAxFTZsUdmbMfPB9Jk4qVsd6Lg7GU4EAUea7ETU1i1J1u15jHMgk
 FiDFMWdQqvCMgAngn/kjzbBs0cCj33F28HpFkQbPPwfCs1kIJ9pbjUlRU1TSl9sWgeN2d1vMl
 nd1fK3Jp5zfux3kI3KVZBbwVkn/VWI7gqhTPv6F9mj0Yf3R88+NkyqViwJmNpTKgCPDqR3FLW
 KX1jxaAuYRsGNAUUesZCz8bCFeI7zXcTpZDlczZ8vuqa4wrBG2ds48eUNJvoyLTk3GgQeifK7
 l6rto32iHMAuSctbrivr7zbk/UXJ+kAKuFodVNdlLwmqPhZPOJV1/xw0JFlFcj5KrpXBgGX9G
 E3Uvxkwpv6FNkiizlFTUvv8ZIRy7LADHWT4Ik1j4jY79c+oocjQzQT9TuUPzW8C0qlJVUSE3M
 I2y5m7+CAB2gCldHije/vJwNeV39E2Ko6SrqpOgrFPC/sqagG2foKayKXlCkn4AZzCkBruwvt
 1qRylPM+VIcKIEI0uamK38nYa+jvBgQC4EiuKuXh/cN8meNTjFyyvfos2brJNcCaTKHXfCn/q
 imFVU24Ihh1XUGykyxR/L4bcIqVcfustZTwqXOOKe3FHolpPvNZbrhb8fdFg+q8j6ZrmEkUGA
 e9mpJv9S85uXfH43HxZLA+U9KolV7hXelIiM=
Content-Transfer-Encoding: quoted-printable

is there any new state here? got no answer for my last 2 Messages

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241109094623=
.37518-2-linux@fw-web.de/

sorry for the html-entities...they came from my gmx webmailer, it is repor=
ted multiple times, but i cannot do more here :(

regards Frank


> Gesendet: Montag, 2. Dezember 2024 um 12:19
> Betreff: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf condition=
al failed
>
> Hi,
>
> just a gentle ping to have it finally merged
>
> regards Frank
