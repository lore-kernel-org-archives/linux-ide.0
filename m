From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 08:42:44 -0400
Message-ID: <48526B44.4060600@rtr.ca>
References: <20080512132611.GA15410@deprecation.cyrius.com> <48286499.9020202@rtr.ca> <20080512154609.GI15866@deprecation.cyrius.com> <20080512191534.GA28429@deprecation.cyrius.com> <20080612181851.GA19874@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3022 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbYFMMmr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 08:42:47 -0400
In-Reply-To: <20080612181851.GA19874@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

Martin Michlmayr wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2008-05-12 21:15]:
>> * Martin Michlmayr <tbm@cyrius.com> [2008-05-12 17:46]:
>>>> The code that triggers this was fixed up more after -rc1, so if you can
>>>> still get messages like that with, say -rc2 or later, then please post them.
>>> Cool.  I'll let you know in case the message doesn't go away with rc2.
>> I still get the same message with rc2.
> 
> Just saw it again with 2.6.26-rc6:
> 
> [42949509.440000] Power down.
> [42949509.440000] qnap_ts209_power_off: triggering power-off...
> [42949509.460000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
> [42949509.460000] ata1: edma_err_cause=02000020 pp_f
..

Mmm.. I don't know how this can happen, even if it does happen.
Unless perhaps the plaform code doesn't do a (driver).remove() call,
which is where we disable the interrupt you see above.

This *is* a "platform" (non-PCI) device, right?

That being the case, can you stick a printk() into mv_platform_remove()
so we can see whether or not it gets called before "power down" ?

Something like this:

--- old/drivers/ata/sata_mv.c	2008-05-30 19:36:52.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-06-13 08:42:02.000000000 -0400
@@ -3186,6 +3186,7 @@
 	struct mv_host_priv *hpriv;
 	struct resource *res;
 	int n_ports, rc;
+	printk(KERN_INFO "%s(%p)\n", __func__, pdev);
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -3258,7 +3259,9 @@
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
 
+	printk(KERN_INFO "%s(%p) enter\n", __func__, pdev);
 	ata_host_detach(host);
+	printk(KERN_INFO "%s(%p) exit\n", __func__, pdev);
 	return 0;
 }
 
