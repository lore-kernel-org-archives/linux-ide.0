From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Mon, 10 Nov 2008 15:47:18 +0900
Message-ID: <4917D8F6.4020305@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se> <49056F2C.20101@kernel.org> <49056FEA.4070405@kernel.org> <20081027194038.GA7004@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050403020700090601080008"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53454 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbYKJGr2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 01:47:28 -0500
In-Reply-To: <20081027194038.GA7004@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403020700090601080008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Lars Michael Jogback wrote:
> * Tejun Heo <tj@kernel.org> [2008-10-27 16:38:18]:
> 
>> Oh.. one more thing.  Can you please try the attached patch and post the
>> failing log?
> 
> Yank the drive:
> [  423.185630] ata7: XXX error_intr irq_stat=0x8040800
> [  423.200853] ata7.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
> [  423.200930] ata7: SError: { PHYRdyChg CommWake DevExch }

I bought harddrive of the same generation but of lower capacity and
tested it with two 3726s but can't reproduce the problem you're
seeing.  :-(

Can you please try the attached patch and see whether anything is
different?

Thanks.

-- 
tejun

--------------050403020700090601080008
Content-Type: text/x-patch;
 name="add-delay-after-hrst.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-delay-after-hrst.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0cd3ad4..e0dca54 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3805,6 +3805,7 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 
 	/* do hardreset */
 	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
+	msleep(500);
 	return online ? -EAGAIN : rc;
 }
 

--------------050403020700090601080008--
