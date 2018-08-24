From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Add missing newline at end of file
Date: Thu, 23 Aug 2018 22:34:03 -0400
Message-ID: <yq1sh348pd0.fsf@oracle.com>
References: <20180823212306.17134-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823212306.17134-1-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Thu, 23 Aug 2018 23:23:06 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, Jason Yan <yanaijie@huawei.com>, "Signed-off-by : Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Geert,

> With gcc 4.1.2:
>
>     drivers/ata/libata-core.c:7396:33: warning: no newline at end of file

Applied to 4.19/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
