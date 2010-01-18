From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 22/64] pata_via: fix address setup timings underlocking
Date: Mon, 18 Jan 2010 18:00:57 +0000
Message-ID: <20100118180057.6ecde501@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171703.14623.85025.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58321 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752032Ab0ARR6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:58:11 -0500
In-Reply-To: <20100118171703.14623.85025.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Mon, 18 Jan 2010 18:17:03 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_via: fix address setup timings underlocking
> 
> Correct via_do_set_mode() documentation while at it.

>  		setup &= ~(3 << shift);
> -		setup |= clamp_val(t.setup, 1, 4) << shift;	/* 1,4 or 1,4 - 1  FIXME */
> +		setup |= (clamp_val(t.setup, 1, 4) - 1) << shift;
>  		pci_write_config_byte(pdev, 0x4C, setup);

Change looks correct to me and matches the VT8235 data sheet (p.97)

Alan
