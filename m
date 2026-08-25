Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EF17BB21
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619096; cv=none; b=VKd1DX/itg+gikNslU3wp/4mzTI7ytAvd5datxnLq/esEeNgXEL6g9AdxfjnKz57/C9XsRyRwdvW0K6UXcDEwCeuJI2RiYqcgVO6R0ZMzrDjeK4Xy4Q7NViz7UWm/ntXUAFd8BLQQleweEvEgsOyegaZ1RQPw6Y7uCI7BqNPHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619096; c=relaxed/simple;
	bh=ei1sNq9R+wcCk9R1flxMkrfbZ0XTb51gbduKzYrCDDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeY8TOp75kzwjTMZ4X9FxQrWhFT7Fy7n3Sucz6NnNC16Etix/O21tHZZP/peDtt+X7KW4YGGNX6nCJgyig2BRUSkCFZtU/jLAiUghNV75WSRLQ9lEysNvHI4yw3qD7fZhI/WaN/YseFSp4bd76emtJRSWzso1/CJgXwfKku4a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvXvQfZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvXvQfZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED161F000E9;
	Tue, 25 Aug 2026 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619095;
	bh=FqRg8NT5REasKk2jDGYT5CuOrtxGNk203/K70+N78LE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jvXvQfZAiomMeFAdsKUEifgmByyZr7oiprUhjPxAD2WvPpScdrpcmGlIxCCFJAd8b
	 BQdOOYSD82St4gDe7MfQM4KHSJoAyW7uoD9rHTkMw6giF35eOdPWPwx84K/9KaZRQC
	 hX3jMIlwbSrGriaxg20Pssj5cmGPrlu5G7Iz5f/EfK+JUVBca5Zj1yfksFgMyKqZ/3
	 w0A+HVsVeO93UgU4EnWYQoeeM9bwZUpTbiWvBxKz1dp0hcFvzLSJ47ZZGOmJzae3Nx
	 /tvJmI6hEZOgfnt3CA7Jl7s1WQVof3ZggeLYava6tNU78PxI5HkiDnGuM99rSzQ0dI
	 T2C5ZeWrK5tVw==
Message-ID: <df91dc9a-58a5-49e1-b208-507cb9593cd1@kernel.org>
Date: Tue, 25 Aug 2026 09:51:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: clear HOST_IRQ_STAT before the ports on
 Marvell 88SE61xx
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>, linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
References: <50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 20:26, Hajo Noerenberg wrote:
> 
> ahci_single_level_irq_intr() services the ports first and clears the global
> HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section 10.6.2.  The
> Marvell 88SE6111/6121/6145 family stops reporting interrupts for a port when
> HOST_IRQ_STAT is cleared while PxIS still holds bits: PxIS keeps its content,
> HOST_IRQ_STAT reads back as 0, the port is never looked at again, and the
> command in flight only ends in a timeout.
> 
> Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood, 88SE6121
> rev B2 behind PCIe) by polling the AHCI registers from userspace while an
> IDENTIFY was outstanding:

The commit title is not great as "before the ports" is not very clear.
What does "clear the ports" mean? Though I do not have a better alternative
title (yet).

[...]

> +static irqreturn_t ahci_mv_irq_handler(int irq, void *dev_instance)
> +{
> +       struct ata_host *host = dev_instance;
> +       struct ahci_host_priv *hpriv = host->private_data;
> +       void __iomem *mmio = hpriv->mmio;
> +       unsigned int rc;
> +       u32 irq_stat, irq_masked;
> +
> +       irq_stat = readl(mmio + HOST_IRQ_STAT);
> +       if (!irq_stat)
> +               return IRQ_NONE;
> +
> +       irq_masked = irq_stat & hpriv->port_map;
> +
> +       spin_lock(&host->lock);
> +
> +       /*
> +        * Use the unmasked value to clear the interrupt, as a spurious pending
> +        * event on a dummy port might cause a screaming IRQ.
> +        */
> +       writel(irq_stat, mmio + HOST_IRQ_STAT);
> +
> +       rc = ahci_handle_port_intr(host, irq_masked);
> +
> +       spin_unlock(&host->lock);
> +
> +       return IRQ_RETVAL(rc);
> +}

This looks very similar to what ahci_thunderx_irq_handler() does, minus the
loop. That loop does make sense to me though, so shouldn't this be the same?
Maybe try using that same function to see if it works?
If it does, we can rename that function to something more generic and reuse it.

-- 
Damien Le Moal
Western Digital Research
