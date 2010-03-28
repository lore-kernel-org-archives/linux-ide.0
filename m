From: Tejun Heo <tj@kernel.org>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Mon, 29 Mar 2010 08:47:06 +0900
Message-ID: <4BAFEA7A.50904@kernel.org>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com> <4B9ED027.30800@hardwarefreak.com> <4BAAB080.3010401@kernel.org> <4BAB2A94.8010001@hardwarefreak.com> <20100325215242.GA9785@localhost.localdomain> <4BAF9670.6010706@hardwarefreak.com> <4BAFB58C.5050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47327 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381Ab0C1Xn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2010 19:43:58 -0400
In-Reply-To: <4BAFB58C.5050702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Stan Hoeppner <stan@hardwarefreak.com>, linux-ide@vger.kernel.org

Hello,

On 03/29/2010 05:01 AM, Robert Hancock wrote:
>> ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max
>> MWDMA2
>> ata2.00: NOSETXFER but PATA detected - can't skip SETXFER, might
>> malfunction
> 
> Yeah, NOSETXFER doesn't take effect on PATA drives. It could, but it
> would assume that the BIOS has set the right mode which seems rather
> dangerous.

Well, we can issue the command, ignore the error and then check the
correct mode is configured during revalidation.  For now, the
following should show us whether something like that would work.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a28420..ca4a50a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3446,6 +3446,10 @@ static int ata_dev_set_mode(struct ata_device *dev)
 				       "NOSETXFER but PATA detected - can't "
 				       "skip SETXFER, might malfunction\n");
 		err_mask = ata_dev_set_xfermode(dev);
+		if (err_mask)
+			ata_dev_printk(dev, KERN_WARNING, "SETXFER failed w/ %x\n",
+				       err_mask);
+		err_mask = 0;
 	}

 	if (err_mask & ~AC_ERR_DEV)

-- 
tejun
