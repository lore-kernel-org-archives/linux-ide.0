From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v4 2/4] AHCI: Move host activation code into
 ahci_host_activate()
Date: Mon, 29 Sep 2014 11:18:46 +0100
Message-ID: <20140929101846.GA8971@agordeev.usersys.redhat.com>
References: <cover.1411648623.git.agordeev@redhat.com>
 <39cff5287f4fcc33d0f00f89cb2337c5a5ec22b6.1411648623.git.agordeev@redhat.com>
 <20140928160408.GA8050@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25628 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbaI2KJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2014 06:09:58 -0400
Content-Disposition: inline
In-Reply-To: <20140928160408.GA8050@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Sep 28, 2014 at 12:04:08PM -0400, Tejun Heo wrote:
> It's generally a bad idea to mix code movement w/ other changes.  I'm
> applying this one but please separate code movements to separate
> patches from now on.

This patch lacks the hunk below, which causes build error.

--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -568,8 +568,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
 
-	rc = ata_host_activate(host, irq, ahci_interrupt, 0,
-					&ahci_highbank_platform_sht);
+	rc = ahci_host_activate(host, irq, &ahci_highbank_platform_sht);
 	if (rc)
 		goto err0;
 
> Thanks.
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
