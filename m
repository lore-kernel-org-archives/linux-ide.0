From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] drivers/ata: remove flood "Enabling discard_zeroes_data"
Date: Fri, 07 Jun 2019 13:26:54 -0400
Message-ID: <yq1sgsli9wh.fsf@oracle.com>
References: <155989286981.1471.16344793966539115439.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155989286981.1471.16344793966539115439.stgit@buzz> (Konstantin
        Khlebnikov's message of "Fri, 07 Jun 2019 10:34:29 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org


Konstantin,

> Printing this at each SCSI READ_CAPACITY command is too verbose.
>
> Flag "discard_zeroes_data" is deprecated since commit 48920ff2a5a9
> ("block: remove the discard_zeroes_data flag").

> -			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
> -				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
> +			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
>  				rbuf[14] |= 0x40; /* LBPRZ */

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
