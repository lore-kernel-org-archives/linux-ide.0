From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: ahci_start_engine compliant to AHCI spec
Date: Thu, 21 Apr 2011 15:40:54 +0200
Message-ID: <20110421134054.GE31724@htj.dyndns.org>
References: <1303249499-11557-1-git-send-email-jipeng2005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303249499-11557-1-git-send-email-jipeng2005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 19, 2011 at 02:44:59PM -0700, Jian Peng wrote:
> At the end of section 10.1 of AHCI spec (rev 1.3), it states
> 
> Software shall not set PxCMD.ST to 1 until it is determined that a
> functoinal device is present on the port as determined by
> PxTFD.STS.BSY=0, PxTFD.STS.DRQ=0 and PxSSTS.DET=3h
> 
> Even though most AHCI host controller works without this additional
> check, specific controller will fail without this.
> 
> Signed-off-by: Jian Peng <jipeng2005@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

But some nitpicks below.

> +	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;

It usually isn't customary to initialize variable with a statement
which has side effect, especially hardware access.  Please make the
readl a separate statement.

> +	if (status & (ATA_BUSY | ATA_DRQ) ||
> +	    ahci_scr_read(&ap->link, SCR_STATUS, &tmp) ||

Also, ahci_scr_read() is known not to fail on host port in ahci and
it's customary to skip error return in such cases in low level
drivers.

> +	    (tmp & 0x0f) != 0x03)
> +		return;

And please add comment explaining what condition is being checked.
It's much easier to read comment than digging through changelog and
find out what the code is trying to achieve.

Thanks.

-- 
tejun
