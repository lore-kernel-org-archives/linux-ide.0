Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADA16EB4E;
	Thu, 11 Jul 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736804; cv=none; b=QOLcetGt7ik5hQ/P7PAMgXzUW5O3ZlD3D56fUVqmTQkUzeBeU6kV79OCsIOeQE7pQjJ6cqAt+6wIONo/DCXct6qT/BT4Zv8KfGwg3ohWUEF92GLWIgm9kHtgHA5LxlgjQcJSI0KGPZzbl5BDhHFVzdo4+0GeuHDNLHQcykfWV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736804; c=relaxed/simple;
	bh=O5Lu1SvgEihQTdfVuAhZT7Z5p37GJ0Ldh17gb9IRAW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY4e0fqFBLhq9MXFU9pvEBHG91YZbkDONn5pOIW6sTWGLXeLqIjv3soJOr8ydobEkU0+Gg0ZWGACF8KcbumOoJHxnhkWBXkIEfGaYX0DWSsix8h8Q9E1YVAckYZfr3tgTnuzGUMnSDwDiQkzm57Q7AWZtTRP+F/tQ9H9p/FAICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEf9jkbY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEf9jkbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB34C116B1;
	Thu, 11 Jul 2024 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720736803;
	bh=O5Lu1SvgEihQTdfVuAhZT7Z5p37GJ0Ldh17gb9IRAW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEf9jkbYDuMVQz9Ezn5AA5EljEEh4wcYuw1bRiJU03abdJvLn90YXcjuG6Tcm+pXl
	 aNosTejMAsIw/V+iJvkv1w26AgKBQsVU9pqymjNRIJwQYh2KekiWmebxBcTAXPK2AA
	 bQmSE4iHCR0BoWA63EUjtyPZO7DYUd1ZlnvoedfKoOTYNjL9nT5I0XedfcrTpKkRgP
	 Nmrr8aWJM3wgqpbFn+lcVC31Z1GIOpWlbxCzLT+Q5wdSFoTIdyvS4+PubjNdYkywQq
	 5MsdkPaQ2GsjerIVqwo6hVG+i6kfC8B5So/GaiR9vth1CjJ6jDH14Z8pQDigZ541vO
	 kccbH+sOYDl2w==
Date: Thu, 11 Jul 2024 16:26:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: shawnguo@kernel.org, festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	dlemoal@kernel.org, kernel@pengutronix.de, tj@kernel.org,
	s.hauer@pengutronix.de, krzk+dt@kernel.org, imx@lists.linux.dev,
	cassel@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible
 string
Message-ID: <172073680147.3233842.13674968436579281799.robh@kernel.org>
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
 <1720685518-20190-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720685518-20190-2-git-send-email-hongxing.zhu@nxp.com>


On Thu, 11 Jul 2024 16:11:55 +0800, Richard Zhu wrote:
> Add i.MX8QM AHCI "fsl,imx8qm-ahci" compatible strings.
> 
> i.MX8QM AHCI SATA doesn't require AHB clock rate to set the vendor
> specified TIMER1MS register. ahb clock is not required by i.MX8QM AHCI.
> 
> Update the description of clocks in the dt-binding accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/ata/imx-sata.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

