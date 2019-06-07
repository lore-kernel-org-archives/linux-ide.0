From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
Date: Fri, 07 Jun 2019 12:58:30 -0400
Message-ID: <yq1wohxib7t.fsf@oracle.com>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155989287898.1506.14253954112551051148.stgit@buzz> (Konstantin
        Khlebnikov's message of "Fri, 07 Jun 2019 10:34:39 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org


Konstantin,

> +			if (dev->horkage & ATA_HORKAGE_NOTRIM)
> +				trim_status = "backlisted";

blacklisted

> +			else
> +				trim_status = "supported";
> +
> +			if (!ata_fpdma_dsm_supported(dev))
> +				trim_queued = "no";
> +			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
> +				trim_queued = "backlisted";

ditto

> +			else
> +				trim_queued = "yes";

Why is trim_status "supported" and trim_queued/trim_zero "yes"?

> +
> +			if (!ata_id_has_zero_after_trim(id))
> +				trim_zero = "no";
> +			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
> +				trim_zero = "yes";
> +			else
> +				trim_zero = "maybe";
> +
> +			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
> +				     trim_status, trim_queued, trim_zero);
> +		}
> +

Otherwise no particular objections. We were trying to limit noise during
boot which is why this information originally went to sysfs instead of
being printed during probe.

-- 
Martin K. Petersen	Oracle Linux Engineering
