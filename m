Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256159;
	b=jXRCDwhA14uYJ9N18V6/iE+8a5KcXOk05nU4cEcj3HSzoXw+1NiPakWNyaRo6ILgEgX/
	 NT5UmXSr6oozTUgvqFgA3oq+EV3RMKIQB6u0UQIJro/axphbOD3gsuXLbJO+UiYaQN3HP
	 0hYhwYMpz2hhJDQoRynRsJg/194VtBQnKxzbMx0xF+R/7RUsiN8gtfJ07jNvhCX0aYthj
	 ZY+JysZdPqLiNp0NV7yOGzmw8ZTYcnVPVuiKifUATwKncIntTzjCmSfB8rSC7+Hj4cHvw
	 qDQKBB3m49v81Ta+riIp6rw+DCZqFI8zR78VPGWxED8Nsxc3dRFXMJFv5I94ceTRndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256159;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=70C6YLYaSbwkBVETAJmiY/sjVR/6nhSMD58Ef0FDHT8=;
	b=OMNFbwI14J080+Un03u+iTQgMZKVBfuQy9sKneumUzA4HEFYzfqZ/HMtivS7vKdSGlvF
	 w2P/d10TyHW3O4SrqIY8ALZmVkreDAPgrT+9ew0uIRAJNEa/JR+5gfJi9Pee8dlvy7LGM
	 etxlR4OyWhpRzPnILW/Zg+H0QJcAEHAxi/fjsSOPcKTjQBnjWOTIaJPELEz2feTqNPT0L
	 yTYDkrKXd1MfPhnOhIBiN3IMl20klKW7hC+TMSJv55y59flkqoEss88AVIMKolGum12C/
	 ENT5RWu9qrQOrm4uBnIsiJsZHS2JVEWOGFkoMsJQZ1B3xb737j+TbSIAm+ALfiuggiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDtn2F1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDC606A325;
	Mon,  9 Nov 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDtn2F1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088B1F008A1;
	Mon,  9 Nov 2026 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256159;
	bh=70C6YLYaSbwkBVETAJmiY/sjVR/6nhSMD58Ef0FDHT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gDtn2F1L5YTmV7pHGa2GdU5f6A8viCyRPPUxOKFVGMXyhk3E28E/YtkssiMxOADHB
	 vp41HKg+ybMxHogZB31EMvKv8axVTTh/2wRRhUxgO9N/Ho/vM/rAn/PMHCWb4pvNJo
	 +nm2CalSZcMWZ1Ik0j4iHNT12E7EE3lNHR6HYu/z3+LoDYpoyxl/FkdaOyJn05Y8T8
	 WR9UbBecvKUiFrC/uCP9HuuPgJNB+sWVaCAru2GR02tuwI20uKcnkCAROT37XRxn0M
	 v71bZy+sljtbBC3WTEB4DMQ5eko6fGkEzI+CXNNotBSBa4wuzPaxtY15FCAsWkXrB+
	 qzAScJFGWOKNQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, hansg@kernel.org, linux-ide@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
References: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
Subject: Re: [PATCH 0/3] ata: remove dead checks and redundant code
Message-Id: <179425615780.1643572.14054800803860937480.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 21:29:17 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 04 Nov 2026 21:14:32 +0800, shao.mingyin@zte.com.cn wrote:
> This series removes two checks that the surrounding code already
> guarantees and folds five duplicated cleanup paths in
> zpodd_get_mech_type() into one.  It was found while reading libata.
> There is no functional change intended; every patch is independent and
> can be applied on its own or as any subset.
> 
> Patch 1 drops a test that is constant-false at compile time.
> SATA_PMP_GSCR_DWORDS is 128, so "SATA_PMP_GSCR_DWORDS & 3" is zero and
> the loop already terminates every fourth dword with a newline.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/3] ata: libata-transport: drop the dead GSCR newline check
      https://git.kernel.org/libata/linux/c/f6e285e1
[2/3] ata: libahci_platform: drop the dead error check
      https://git.kernel.org/libata/linux/c/54bd1984
[3/3] ata: libata-zpodd: use a single exit in zpodd_get_mech_type()
      https://git.kernel.org/libata/linux/c/3a533a66

Kind regards,
Niklas

