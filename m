From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Wed, 30 Nov 2016 15:22:01 -0500
Message-ID: <20161130202201.GA15989@htj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
 <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35518 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbcK3UWD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 15:22:03 -0500
Received: by mail-yb0-f194.google.com with SMTP id d59so2596431ybi.2
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 12:22:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

On Wed, Nov 30, 2016 at 10:03:47AM -0500, tedheadster wrote:
>   on my hardware it grabbed all those interrupts, showing up in
> /proc/interrupts very clearly.

Can you please see whether the following patch makes a difference?

Thanks.

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8c..fdc2b4f 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -962,6 +962,9 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	ret = -EBUSY;
 	if (devm_request_region(&pdev->dev, io, 8, "pata_legacy") == NULL ||
 	    devm_request_region(&pdev->dev, io + 0x0206, 1,
@@ -1008,12 +1011,14 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 		if (!ata_dev_absent(dev)) {
 			legacy_host[probe->slot] = host;
 			ld->platform_dev = pdev;
+			devres_remove_group(&pdev->dev, NULL);
 			return 0;
 		}
 	}
 	ata_host_detach(host);
 fail:
 	platform_device_unregister(pdev);
+	devres_release_group(&pdev->dev, NULL);
 	return ret;
 }
 
