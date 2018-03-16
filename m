From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Date: Fri, 16 Mar 2018 11:54:30 -0400
Message-ID: <yq137106mo9.fsf@oracle.com>
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
        (Sudip Mukherjee's message of "Fri, 16 Mar 2018 14:33:39 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Sudip,

> While whitelisting Micron M500DC drives, the tweaked blacklist entry
> enabled queued TRIM from M500IT variants also. But these do not support
> queued TRIM. And while using those SSDs with the latest kernel we have
> seen errors and even the partition table getting corrupted.

> +	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },

Any reason to believe this deficiency is limited to MU01 firmware?

-- 
Martin K. Petersen	Oracle Linux Engineering
