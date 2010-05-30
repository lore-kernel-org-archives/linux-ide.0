From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: clarification and trivial correction to Kconfig
 text
Date: Sun, 30 May 2010 17:05:08 +0200
Message-ID: <4C027EA4.5050900@kernel.org>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de> <4C010AA8.8070004@kernel.org> <4C0135BF.1010505@s5r6.in-berlin.de> <4C0225D1.90205@kernel.org> <tkrat.acb772e71ffffd6e@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <tkrat.acb772e71ffffd6e@s5r6.in-berlin.de>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 05/30/2010 04:00 PM, Stefan Richter wrote:
> Change the text of the ATA_BMDMA prompt to indicate that it lets one access a class of
> device drivers (rather than only add a certain feature to libata).  The divisions of
> the "ATA SFF support" menu now read
>   - SFF controllers with custom DMA interface,
>   - SFF controllers with bus master DMA  (was: "ATA BMDMA support"),
>       - SATA SFF controllers with BMDMA,
>       - PATA SFF controllers with BMDMA,
>   - PIO-only SFF controllers.
> This hopefully helps convince users of "make oldconfig" to follow the
> recommendation to switch that option on.
> 
> Also let the help text of this prompt say more precisely what it is about:  It adds a
> little bit of support code to libata that is required by many but not all SFF drivers.
> This option alone does not add support of respective controllers though; according
> drivers are chosen at subsequent dependent Kconfig prompts. --- And fix a typo.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
