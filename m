From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [libata] libata driver for bf548 on chip ATAPI
 controller.
Date: Mon, 13 Aug 2007 12:13:54 +0100
Message-ID: <20070813121354.2a8e014f@the-village.bc.nu>
References: <1187001288.13754.3.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44836 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S943992AbXHMLGT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 07:06:19 -0400
In-Reply-To: <1187001288.13754.3.camel@sevens.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "; linux-kernel"@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

> + * Register transfer timing table
> + */
> +/*               mode:       0    1    2    3    4    */
> +/* Cycle Time                     */
> +static u32 reg_t0min[]   = { 600, 383, 330, 180, 120 };
> +/* DIOR/DIOW to end cycle         */
> +static u32 reg_t2min[]   = { 290, 290, 290, 70,  25  };
> +/* DIOR/DIOW asserted pulse width */
> +static u32 reg_teocmin[] = { 290, 290, 290, 80,  70  };
> +
> +/**
> + * PIO timing table
> + */
> +/*               mode:       0    1    2    3    4    */
> +/* Cycle Time                     */
> +static u32 pio_t0min[]   = { 600, 383, 240, 180, 120 };
> +/* Address valid to DIOR/DIORW    */
> +static u32 pio_t1min[]   = { 70,  50,  30,  30,  25  };
> +/* DIOR/DIOW to end cycle         */
> +static u32 pio_t2min[]   = { 165, 125, 100, 80,  70  };
> +/* DIOR/DIOW asserted pulse width */
> +static u32 pio_teocmin[] = { 165, 125, 100, 70,  25  };
> +/* DIOW data hold                 */
> +static u32 pio_t4min[]   = { 30,  20,  15,  10,  10  };

Why not use the timing tables provided by libata ?


