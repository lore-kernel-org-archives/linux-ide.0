From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Tue, 6 Sep 2005 08:17:53 +0900
Message-ID: <20050905231753.GA1003@htj.dyndns.org>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:8868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964938AbVIEXSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2005 19:18:05 -0400
Received: by zproxy.gmail.com with SMTP id 13so914977nzn
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 16:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050905230234.GA543@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

 Hello, Marc.

 To eliminate one more possibility, can you please try the following
patch?

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -720,6 +720,8 @@ static int sil24_init_one(struct pci_dev
 				       pci_name(pdev));
 		}
 
+		writel(0x0300, port + PORT_SCONTROL);
+
 		/* Zero error counters. */
 		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
 		writel(0x8000, port + PORT_CRC_ERR_THRESH);
diff --git a/include/linux/libata.h b/include/linux/libata.h
