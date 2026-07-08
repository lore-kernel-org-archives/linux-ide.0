Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514040803C;
	Wed,  8 Jul 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507934; cv=none; b=UW50N53K2DeUh6816DVuDIkFYH3VwgrQE/rGDEFZf6w+KDlE+866lraLSMqCxGfx3neiBR8s7HCE0mRrQtrEX3Q1kxM+F+Sw3twWh5V7cfsHXYAbNcsqXAqa8bs9hpvtkwP8q4ZLaUp+wujwaIxaAw3fU9IVFzGStqpXvouynqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507934; c=relaxed/simple;
	bh=dsJABScrUj4xyMwOzi3nscIGfAqE3ZpoAy0XSamHHZw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GTv+UlPZKmbN8JxkFuMiqbVL3BjEn7XVTX+mpqKVw/ES7LQAwHkgfyS2uThdNNeQrWWos88DxSi9zQoUsVbE0uYoO7MwWSTzDI3VqL62cOsAbg0VgIqgImpMZh+VtNtIciU6BaYz+tk012aJetGf/aaxtxGVbEnRPrb6QchlvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EbEd9dB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebF1mgFh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EbEd9dB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebF1mgFh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 35CFEEC00FB;
	Wed,  8 Jul 2026 06:51:58 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 06:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783507918;
	 x=1783594318; bh=hIZg2ldnJogwpujWh7PTyNBHelvaX4udZ6sI2p5ue3Q=; b=
	EbEd9dB/H667eHNIUhfhARn5KtpXiZwQHKjFZHTKDd0icFN+ezVXDoGvC69FDhwt
	yGkyxqc2b8kw04vbMceMZxF6wcD5sNonUrpVRsoGxsbHEd+Z5uryyRyVWVlmK6wt
	w42/mvKHGQ64rDwVXwab7FNgK48Q9Yzr6C50ukDOu5Yg6ccraJekoZRQ7TBsLvye
	5wU79tQ5Omkh4VuNRWZeaRLGjD+i53giPaVAssrf9I0yPOzC79LMZBta60VW27Kz
	7UqeUsz+jaOQGVFqNjz55YeA7KHLTx6k42Qy7WkblHIoq1G/iC1J4tM9uXzcA1qw
	N+7PRK04ZkMgN4QZHm+VZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783507918; x=
	1783594318; bh=hIZg2ldnJogwpujWh7PTyNBHelvaX4udZ6sI2p5ue3Q=; b=e
	bF1mgFh9WHGg4EAveD6C5FztHI4IrY97ZINpWS9SyyBvcvdNPJdLIxcri7dAnh4e
	KRjF4zwGN3PwfYV2xB0/lM+iUkMw6XRmqpE/koiy/ukk+k1QLvBG5MAkg0EQSMK9
	4w8kgGyuGaEMAjMgAhXwgQpqwMecAllOn52+2uHbXMxws2nv3o9kC+33GX0xI7t+
	tSwXDpU8vCAtwDPzpxfBtucPg7atptZo1L9YNEibKUPGYjI7nFL/dw1EqM7dpwpC
	NQU6Z3l41oHPN8rBW8TBIHUG85xxdaJPlo5oMMya03aYzbTpNZrSEPRS2A9KYu4e
	A7ukfXgz808KiI9jRix5Q==
X-ME-Sender: <xms:zCtOanDVTSWCcdnLjIq39wQcYuC3g-d1DXGiRMCp18u8ZXoluSR4Hw>
    <xme:zCtOaoVUtY4r0JTbDNt2A1JGFq2Ub2zXV3bnBKYK5smZNJoz2EHRxfyaan7hWTs5Y
    jZviUs_RJsldNmdqnZMowq1TNqbuJaWPydz5c_F0xs_9qILNSyTCRE>
X-ME-Proxy-Cause: dmFkZTGtvw6WvSymr4VinGd1nWZv6KTMr8E8sY/3Felf8ggSTxeLSW1bjf6AFpkx1wa10S
    Tw+au5ZhoWjRVV4ZI5UaQ1rc5VcDRzzogcg7j5MEWljN6cRcQL8D7zUObhRejnnY9esRfP
    ea/uVcXgJyKkO4oLUCdW5XJqAoSaylYrXZtr69SMRAudl/jG8PFCLGprKfHRJRQv+wu+qo
    Ky6LBuaylM/KOJXeoiIOvzHTqzPBFkFfzcbZ07SYR20IZcJsltsnUbgxEkF8i9VvxSY5cj
    P0H8ig+2CZPMhH3F3JbjSfqImk4zgPlFkmqRiUKu3EgM5JwdEqDpHx4baqAFnHhFMRyhC2
    E5j1O3GDnopkBgVgqnjcO3D+iFhPY9A9ZdD9uKsCMfqUmtId4qKm0xHbyexw3QpVt73tMA
    cuvIZW58OuFOqhCYLFWnC0fUhq/NsIo6V+0j5NjvwpM1H8+gxpj4uQQKT8OymxUG+1DK86
    iq1vh6w9x3N0JuB7jmaCN+ME+7q3zagzdX1XfGkNpro1YVBcAO1VIbh9ihsdxiKg2X4tdn
    L3SH6w2tThZrvIi5Vl/MdH/VbBKVd4hfxFL5vwjxYxAKWcHBrHs87CN6LDGHs25nSi5aPm
    UgWhxzh9cYhZDf1SLKH4QfQFVHb77cWDrH8ChqzI6/5ekmpHMNLILE2lA6fA
X-ME-Proxy: <xmx:zCtOasBt3oO2ZuCPZHZYA9qTIXvaFWRtBOnmoIkkOG1HcJXCHPshng>
    <xmx:zCtOaqg4B4pxEY1ePwRuyAUne2lVzP3AAaCci7_dWcKCr1QWK-JVPQ>
    <xmx:zCtOahxgna8TOR1MKkOlZT4v-G9kxufyWeDNblw_csGLb2T6wrGHwQ>
    <xmx:zCtOaj303j4vhpsN_fHUENQEdVbLt9PHKwIAzJOBzgXOlpyikkceQw>
    <xmx:zitOaj8A7Uyz9qRtirqup1Vfgi56TGIONPRWwFl9K1OWFNzRof921wgr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 540881820082; Wed,  8 Jul 2026 06:51:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoQOi4MnDbNN
Date: Wed, 08 Jul 2026 12:50:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>,
 "Damien Le Moal" <dlemoal@kernel.org>, "Niklas Cassel" <cassel@kernel.org>
Cc: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Vinod Koul" <vkoul@kernel.org>, "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <64f3ed43-9276-423f-9db6-2270fa9c2192@app.fastmail.com>
In-Reply-To: <20260708092704.60815-1-chenchangcheng@kylinos.cn>
References: <20260708092704.60815-1-chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] ata: pata_ep93xx: fix double-free of DMA channel on error path
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2026, at 11:27, Chen Changcheng wrote:
>  static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
>  {
> -	if (drv_data->dma_rx_channel) {
> +	if (!IS_ERR_OR_NULL(drv_data->dma_rx_channel)) {
>  		dma_release_channel(drv_data->dma_rx_channel);
>  		drv_data->dma_rx_channel = NULL;
>  	}

If something requires you to use IS_ERR_OR_NULL(), that is usually
a bad API design, and you should fix this at the place where
it gets introduced.

Please fix the probe path instead so it doesn't try to use the
device without a valid channel.

      Arnd
