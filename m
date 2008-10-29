From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] include old-style rb532 CompactFlash support
Date: Wed, 29 Oct 2008 20:25:53 +0100
Message-ID: <200810292025.53762.bzolnier@gmail.com>
References: <20081027205124.GB27227@nuty> <1225304359-11290-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:51068 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYJ2T3E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:29:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so99787gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:29:03 -0700 (PDT)
In-Reply-To: <1225304359-11290-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org

On Wednesday 29 October 2008, Phil Sutter wrote:
> I copied the driver from the OpenWrt project to FreeWRT at Thu, 16 Nov
> 2006 and since then maintain it. As the current kernel for rb532 in
> FreeWRT is 2.6.19.1, intense testing has only been done basing on the
> local patches for the board support. After porting it to the linux-mips
> git tree, I could verify the functionality by mounting an ext2
> filesystem on the disk and reading/writing files in it.

Hmm, I thought that the old driver is an IDE driver not a stand-alone one
so I'm not much in favor of merging it as it is.  However it still should
be useful in figuring out why pata_rb532_cf doesn't work correctly.

> +static irqreturn_t cf_irq_handler(int irq, void *dev_id)
> +{
> +	/* While tasklet has not disabled irq, irq will be retried all the time
> +	 * because of ILEVEL matching GPIO pin status => deadlock.
> +	 * To avoid this, we change ILEVEL to 0.
> +	 */
> +	struct cf_mips_dev *dev = dev_id;
> +
> +	rb532_gpio_set_ilevel(0, dev->pin);
> +	rb532_gpio_set_istat(0, dev->pin);

I cannot find the corresponding functionality in the new driver or arch code?

[ It seems that ->set_int_{level,status} methods from arch/mips/rb532/gpio.c
  are not used anywhere in the kernel? ]
