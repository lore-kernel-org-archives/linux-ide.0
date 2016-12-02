From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Fri, 2 Dec 2016 12:07:05 -0500
Message-ID: <20161202170705.GB6033@htj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
 <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org>
 <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34389 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLBRHH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 12:07:07 -0500
Received: by mail-qk0-f196.google.com with SMTP id y205so31294957qkb.1
        for <linux-ide@vger.kernel.org>; Fri, 02 Dec 2016 09:07:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

Sorry, I got the order of operation wrong.  Can you please test this
one?

Thanks.

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8c..3a0bb89 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -962,6 +962,9 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
+	if (!devres_open_group(&pdev->dev, legacy_init_one, GFP_KERNEL))
+		return -ENOMEM;
+
 	ret = -EBUSY;
 	if (devm_request_region(&pdev->dev, io, 8, "pata_legacy") == NULL ||
 	    devm_request_region(&pdev->dev, io + 0x0206, 1,
@@ -1008,11 +1011,13 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 		if (!ata_dev_absent(dev)) {
 			legacy_host[probe->slot] = host;
 			ld->platform_dev = pdev;
+			devres_remove_group(&pdev->dev, legacy_init_one);
 			return 0;
 		}
 	}
 	ata_host_detach(host);
 fail:
+	devres_release_group(&pdev->dev, legacy_init_one);
 	platform_device_unregister(pdev);
 	return ret;
 }
