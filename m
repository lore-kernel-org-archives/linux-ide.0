From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Regression] 2.6.25-rc4-git3: Handling of audio CDs broken on
 pata_ali
Date: Mon, 10 Mar 2008 21:03:45 +0900
Message-ID: <47D523A1.7070808@gmail.com>
References: <200803082246.47987.rjw@sisk.pl> <20080309073824.902DC82CF2E@smtp04.mtu.ru> <200803100012.27520.rjw@sisk.pl> <47D4E64F.5070106@gmail.com> <47D4E78A.10507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000709060004000605070303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:11998 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYCJMDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 08:03:55 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1874876wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 05:03:52 -0700 (PDT)
In-Reply-To: <47D4E78A.10507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709060004000605070303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Tejun Heo wrote:
>> Rafael J. Wysocki wrote:
>>>>> where ata1 is:
>>>>>
>>>>> scsi0 : pata_ali
>>>>> scsi1 : pata_ali
>>>> Oh, is it only with audio CDs? I am unable to use DVD on pata_ali in DMA at
>>>> all. Have you tried to disable ATAPI DMA (libata.dma=1)?
>>> Data CDs seem to work fine here.
>> * Does booting into runlevel 1, putting in an audio cd and running
>> cdparanoia give the same result?
>>
>> * Does setting module parameter libata.force to "1.00:pio4" make any
>> difference?
> 
> Oh, never mind.  I have a hunch.  I'll report back in a while.
> 

Does the attached patch fix the problem?

-- 
tejun

--------------000709060004000605070303
Content-Type: text/x-patch;
 name="use-cmd_type-in-atapi-dma-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use-cmd_type-in-atapi-dma-check.patch"

 drivers/ata/pata_ali.c    |    2 +-
 drivers/ata/pata_it821x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 7e68edf..8786455 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -295,7 +295,7 @@ static void ali_lock_sectors(struct ata_device *adev)
 static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	/* If its not a media command, its not worth it */
-	if (qc->nbytes < 2048)
+	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 109ddd4..f751749 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -564,7 +564,7 @@ static int it821x_check_atapi_dma(struct ata_queued_cmd *qc)
 	struct it821x_dev *itdev = ap->private_data;
 
 	/* Only use dma for transfers to/from the media. */
-	if (qc->nbytes < 2048)
+	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
 		return -EOPNOTSUPP;
 
 	/* No ATAPI DMA in smart mode */

--------------000709060004000605070303--
