From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: kill trailing whitespace
Date: Sat, 25 Mar 2006 14:28:57 +0900
Message-ID: <20060325052857.GA25030@htj.dyndns.org>
References: <11431768704184-git-send-email-htejun@gmail.com> <4424026A.1080504@pobox.com> <20060325021407.GF5288@htj.dyndns.org> <4424C27B.1090000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.234]:3160 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751410AbWCYNy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Mar 2006 08:54:29 -0500
Received: by wproxy.gmail.com with SMTP id 69so1122374wri
        for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 05:54:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4424C27B.1090000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Kill trailing whitespace.

---

Sorry about that.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cb9813..8631056 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2635,7 +2635,7 @@ static int ata_dma_blacklisted(const str
  *
  *	FIXME: The current implementation limits all transfer modes to
  *	the fastest of the lowested device on the port.  This is not
- *	required on most controllers. 
+ *	required on most controllers.
  *
  *	LOCKING:
  *	None.
