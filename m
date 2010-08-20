From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] sd: Update thin provisioning support
Date: Fri, 20 Aug 2010 11:00:40 +0200
Message-ID: <20100820090039.GD27033@lst.de>
References: <1282232941-9910-1-git-send-email-martin.petersen@oracle.com> <1282232941-9910-7-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1282232941-9910-7-git-send-email-martin.petersen@oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, hch@lst.de
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 19, 2010 at 11:49:01AM -0400, Martin K. Petersen wrote:
> +		if (sdkp->tpu && desc_count && lba_count)
> +			sdkp->unmap = 1;
> +		else if (!sdkp->tpws) {
> +			sd_printk(KERN_ERR, sdkp, "Thin provisioning is "  \
> +				  "enabled but neither TPU, nor TPWS are " \
> +				  "set. Disabling discard!\n");
> +			goto out;
> +		}
> +

I don't think we can simply break all existing setups with support for
earlier SBC drafts.  I think we should use the TPU and TPWS same bits
if present and else fall back to our current heuristics.

