From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add FIXME above ata_dev_xfermask()
Date: Sat, 25 Mar 2006 11:14:07 +0900
Message-ID: <20060325021407.GF5288@htj.dyndns.org>
References: <11431768704184-git-send-email-htejun@gmail.com> <4424026A.1080504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.201]:65136 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbWCYCOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 21:14:14 -0500
Received: by xproxy.gmail.com with SMTP id t10so599355wxc
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 18:14:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4424026A.1080504@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Add FIXME above ata_dev_xfermask noting that the current
implementation limits all transfer modes to the fastest of the slowest
device on a port which isn't necessary.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0aff888..e4bd673 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2634,6 +2634,10 @@ static int ata_dma_blacklisted(const str
  *	known limits including host controller limits, device
  *	blacklist, etc...
  *
+ *	FIXME: The current implementation limits all transfer modes to
+ *	the fastest of the lowested device on the port.  This is not
+ *	required on most controllers. 
+ *
  *	LOCKING:
  *	None.
  */
