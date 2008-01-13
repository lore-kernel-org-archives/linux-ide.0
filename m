From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 14:36:53 +0900
Message-ID: <4789A375.9000302@gmail.com>
References: <200801051734.18088.marc@fallon.classyad.com> <478434C4.5000209@gmail.com> <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com> <Pine.LNX.4.64.0801102143150.11200@classyad.com> <4786DE62.6090604@gmail.com> <Pine.LNX.4.64.0801121338140.8409@classyad.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010905000205020501030605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:34832 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYAMFhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 00:37:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1385338rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 21:36:59 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801121338140.8409@classyad.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Howard Zuckman <marc@fallon.classyad.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------010905000205020501030605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marc Howard Zuckman wrote:
> On Fri, 11 Jan 2008, Tejun Heo, replying to Marc Zuckman  wrote:
> 
>>>     Zuckman:
> 
>>> Is it possible that both drivers are present in the kernel and conflict
>>> with one another in some fashion?
>>     Heo:
> 
>> The don't conflict.  If both are in the kernel, IDE drivers have
>> priority.  Can you please try the libata driver and see if anything is
>> different?
> 
> It's different, but the drive array does not function.
> 
> These are the boot messages with libata and pata_it821x configured.
> Note that I left the old ide drivers in the kernel for the ICH5
> controller.

Does this change anything?  And, yeah, I really wanna see the hdparm
--Istdout too.

Thanks.

-- 
tejun

--------------010905000205020501030605
Content-Type: text/x-patch;
 name="disabe-init-dev-params.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disabe-init-dev-params.patch"

---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tree0/drivers/ata/libata-core.c
===================================================================
--- tree0.orig/drivers/ata/libata-core.c
+++ tree0/drivers/ata/libata-core.c
@@ -1745,7 +1745,7 @@ int ata_dev_read_id(struct ata_device *d
 		 * anything else..
 		 * Some drives were very specific about that exact sequence.
 		 */
-		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
+		if (0 && (ata_id_major_version(id) < 4 || !ata_id_has_lba(id))) {
 			err_mask = ata_dev_init_params(dev, id[3], id[6]);
 			if (err_mask) {
 				rc = -EIO;

--------------010905000205020501030605--
