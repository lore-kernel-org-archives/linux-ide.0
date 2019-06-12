From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Extend quirks for the ST1000LM024 drives with NOLPM quirk
Date: Tue, 11 Jun 2019 23:40:29 -0400
Message-ID: <yq1d0jjeaj6.fsf@oracle.com>
References: <20190611143259.28647-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190611143259.28647-1-hdegoede@redhat.com> (Hans de Goede's
        message of "Tue, 11 Jun 2019 16:32:59 +0200")
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hans,

> -	/* drives which fail FPDMA_AA activation (some may freeze afterwards) */
> -	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
> -	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
> +	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
> +	   the ST disks also have LPM issues */
> +	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
> +						ATA_HORKAGE_NOLPM, },
> +	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
> +						ATA_HORKAGE_NOLPM, },

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Slightly orthogonal, and I know it's been discussed before, but I think
it would be worth considering just blacklisting all firmware revs for
this model.

There were several firmware releases for these drives. And while it's
conceivable that post-2BA30001 may fix the issues, I think it's safe to
say that all the intermediate releases between the two we have are
equally broken.

-- 
Martin K. Petersen	Oracle Linux Engineering
