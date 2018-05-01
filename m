From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] libata: blacklist Micron SSD
Date: Mon, 30 Apr 2018 23:24:49 -0400
Message-ID: <yq1r2mw83cu.fsf@oracle.com>
References: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180429160138.11091-1-sudip.mukherjee@codethink.co.uk> (Sudip
        Mukherjee's message of "Sun, 29 Apr 2018 17:01:38 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>
List-Id: linux-ide@vger.kernel.org


Sudip,

> v1: Only M500IT MU01 was blacklisted.
>
> v2: Whitelist M500IT BG02 and M500DC and then blacklist all other Micron. 

I think my preference would be to blacklist M500IT with the MU01
firmware (which Micron said was affected) and rely on the "Micron*"
fallthrough further down for the rest.

I have not gotten firm confirmation on ZRAT behavior so for now we
should probably just do:

+ { "Micron_M500IT_*", "MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },

-- 
Martin K. Petersen	Oracle Linux Engineering
