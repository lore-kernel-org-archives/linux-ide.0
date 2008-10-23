From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Thu, 23 Oct 2008 22:47:05 +0200
Message-ID: <200810232247.05686.bzolnier@gmail.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbYJWVuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:50:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:50:04 -0700 (PDT)
In-Reply-To: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Wednesday 22 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

I applied it so please address issues left (if any) with incremental patches.

Thanks for all your work on TX493x drivers.
