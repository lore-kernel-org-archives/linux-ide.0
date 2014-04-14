From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_octeon_cf: use devm_kzalloc() to allocate cf_port
Date: Mon, 14 Apr 2014 13:36:39 -0400
Message-ID: <20140414173639.GA10416@htj.dyndns.org>
References: <1927612.nfmGqcZdLy@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:65263 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbaDNRgn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 13:36:43 -0400
Content-Disposition: inline
In-Reply-To: <1927612.nfmGqcZdLy@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>, Guenter Roeck <linux@roeck-us.net>, linux-ide@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 14, 2014 at 06:28:37PM +0200, Bartlomiej Zolnierkiewicz wrote:
> As a nice side effect this fixes the cf_port leak on
> dma_coerce_mask_and_coherent() or ata_host_activate()
> failure.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
