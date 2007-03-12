From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Mon, 12 Mar 2007 21:25:36 +0900
Message-ID: <45F546C0.1030502@gmail.com>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com> <45F4FCA3.1080301@gmail.com> <45F54147.1060509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090200010603050406030909"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:55327 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965745AbXCLMZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 08:25:35 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1653474wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 05:25:34 -0700 (PDT)
In-Reply-To: <45F54147.1060509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090200010603050406030909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Berck E. Nash wrote:
> Tejun Heo wrote:
>> Hello, Berck.
>>
>> Berck E. Nash wrote:
>>> Tejun Heo wrote:
>>>> Berck E. Nash wrote:
>>>>> Testing the new libata ICH PATA drivers.  There's one PATA port on this
>>>>> chip, and I've got two optical drives connected to it.  The master drive
>>>>> fails to detect.  The slave detects and works properly.
>>>> Can you test 2.6.20.1 and post full dmesg?
>>> Here's 2.6.20.2...  No ACPI errors, but still doesn't detect both drives.
>> Please apply the attached patch and see if it works.  If it works,
>> please post the result of hdparm -I /dev/srX of the optical drive.  Thanks.
> 
> You forgot to attach the patch  :)

Heh heh.  Sorry about that.  Here it is.

-- 
tejun

--------------090200010603050406030909
Content-Type: text/x-patch;
 name="ata_piix-polling-setxfer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ata_piix-polling-setxfer.patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index dc42ba1..6e7775a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -105,7 +105,8 @@ enum {
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
-	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
+	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS |
+				  ATA_FLAG_SETXFER_POLLING,
 	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
 
 	/* combined mode.  if set, PATA is channel 0.

--------------090200010603050406030909--
