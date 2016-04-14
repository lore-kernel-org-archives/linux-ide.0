From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_artop: Use ioread8.
Date: Thu, 14 Apr 2016 11:45:17 -0400
Message-ID: <20160414154517.GD12583@htj.duckdns.org>
References: <1460618763-1712-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460618763-1712-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Apr 14, 2016 at 04:26:03PM +0900, Yoshinori Sato wrote:
> Support for non x86 targets.

Being a bit more detailed would be nice.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/ata/pata_artop.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 96c05c9..3731dea 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -340,6 +340,18 @@ static void atp8xx_fixup(struct pci_dev *pdev)
>  	}
>  }
>  
> +static int is_fast(struct pci_dev *pdev)

Can you please make the name a bit more descriptive?

Thanks.

-- 
tejun
