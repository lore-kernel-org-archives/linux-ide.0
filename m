From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Mon, 21 Jan 2008 19:51:48 +0000
Message-ID: <20080121195148.146741ca@lxorguk.ukuu.org.uk>
References: <200801212144.29511.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38550 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752468AbYAUTx4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 14:53:56 -0500
In-Reply-To: <200801212144.29511.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

> +static inline u32 ioread(u32 reg)
> +{
> +	return ioread32(base + reg);
> +}
> +
> +static inline void iowrite(u32 val, u32 reg)
> +{
> +	iowrite32(val, base + reg);
> +}

Why not just use ioread32/iowrite32 directly ?


Otherwise this looks way way better.

Alan
