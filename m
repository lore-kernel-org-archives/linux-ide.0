Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBA37C928
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704945; cv=none; b=YvyvthcQ2mk4YagpdIbtkz8yJ6BbiFcgEJqauj/MHSpBXrOk3tUHh/57zw+DcY9345H+HLnV/z5ySlxGyGZdP7Wg+3HsbRy0U9C2ekpUoW4/j2VNpGXQL02s4k99JXj08W+KUg81iMMCCfrwIaBmlzYO9J3RlLUZ+HxkllhW6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704945; c=relaxed/simple;
	bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzDOwDHx74ha0314NuDz9xj/oK+XARPm8E7BiA4Bnf0sRP81jwjolghCU4V1imLasUgXpJNL8KfnJc/JrWUZghY4UaHRocqsmDjFF5yb6jAh+ND/JJ6ModUmUdS7by3PugNWCt5fOqMTu2CjjAhdILpMPCS7NKdMkQXd9LT7DG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cD4UFgoA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cD4UFgoA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48375f1defeso59006885e9.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772704940; x=1773309740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=cD4UFgoAocJuZT5S6/FT4tLvo8eHic6win/PVVlM7THi42GfYkSi1TmQKp9oFjEvC9
         4DuAmh8ioVJ3l0t9cfDz1F4uH57IMEgeY61EKqf0J4hgzotd10bzAWeqkIY3qxwq+gtt
         KyD/BEhAcZymLIC+jEV+iqZhfRlSpIO7G5fxOWyrn6ZeoxUBzXJNaGNiXGXdwAwygc++
         SJ3ShMbEL/2wC0WJ/VhDdOAftX90PfAz60BcupIG8OAGaPrCOCMIA27aaK++isLH44Iv
         ENO8y4ePFW102JPN00G4qmjO8l3H2KXaQyAiU4DD52kTRmizIQUzeyakkq8kcPe749lH
         0MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704940; x=1773309740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=oKyWp6SZLIdAEIEewPNIS2ADJZ6KiOLq2MJ9q7UGVBFLX8VkjsVMFWs1tPUE1QsS70
         ClIB/h3WfW3mBTYnhf9YMT/Cop3cZCWlxWa+j2OKYOUi8aFBgj+nob+Iee4YQfZZyh7D
         PBueFzug3wWZoG5s6soAps/Cpw2OpJgRkblkyXF3Il/EOnl8AW98ZV0G9Dhv1Ebe9qhG
         YIh/0NtpLhCP01YQMHt9uBzNTNRUdrFwd59Tn2DpZDKmTUfBVCgptLYcwkh/e7wONlFH
         JlMNKU6UtxuwpDuDB7PgBLO0c/IgSNi3hJnhVa0VEYejJ8ktA+n0eSPrTgnux4xVloun
         QJVA==
X-Forwarded-Encrypted: i=1; AJvYcCWg7tKQvxsuDlbSUeBzHRNyIdRxZj+IcmyG2pCRoUgDsi74QePwRVXNJn+2+Og2Z+jwmU4O6JzUDoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZBCB7GAsy6QMB1zN28wAPvczjMC+xe7UGEbiIEv3IXzXqFLB
	C4luzh+jVq+EZ0qafWIrM6P9HTO0XJCrUet2WoqO/KEyycIZ0Yn1RgHqBdKVGgfhM50=
X-Gm-Gg: ATEYQzz1s48e/FTpwPesrR705/923kCuO012EysrfYAW44SHIR5kPav241o+2v6Q0YP
	jgQSiK6fao4NANHKZQ2MSrhbqvHsa2BdG1dUsL9bAlpfM17gRdB4F6sIpNTHS04sZdQ19Yy8IZH
	Pin7YltrsbFG6fe1C4zHDCJK42Pz6IE3k9QViEIwqvS61nE1ASmWtHgHaWlwaDEacvnnH9K5ite
	uL3BF1cTy99wdHUQh6nAkcJKutLfggFHzWapK4D2J9+W2IveAzRVbcJAZ5Se1gsW6bOtzDjz6Ua
	I2CWXx2JghMv8c0T1bWdJ8GcUzEEvDN8JIplQMKooVQUeOJBJG6GgaieHnB75ONaXQ2EPVOxGsB
	WGoow8KlDWatCxoTt0lgaMXsDLj75GFRBdvMV0XbTKGwr0FVZI84D9x7Lcef7C7Rf2BeQusxvLl
	8t+3IIljkYf7wZBDg5BqVOIREnjyR8
X-Received: by 2002:a05:600c:a07:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4851988f31dmr86977045e9.23.1772704939633;
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Received: from salami.lan ([212.129.84.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fade9fdsm59453655e9.4.2026.03.05.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Message-ID: <030737fd255a49288349f06e8c1217a126ea9081.camel@linaro.org>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where
 missing
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, 	dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 	linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 	linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Peter Griffin	 <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>
Date: Thu, 05 Mar 2026 10:02:16 +0000
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
	 <20260304175735.2660419-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 19:57 +0200, Vladimir Oltean wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>=20
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> =C2=A0drivers/phy/phy-google-usb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +

For Google:
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
