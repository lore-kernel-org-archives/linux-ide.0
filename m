From: Tejun Heo <htejun@gmail.com>
Subject: Re: Boot fails on Intel SATA controller
Date: Wed, 01 Aug 2007 23:36:07 +0900
Message-ID: <46B09A57.50806@gmail.com>
References: <080120071418.11784.46B09645000B42BF00002E082200735834CE05040A05@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070002040603070907070700"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.225]:39430 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbXHAOgO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:36:14 -0400
Received: by qb-out-0506.google.com with SMTP id e11so219403qbe
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 07:36:13 -0700 (PDT)
In-Reply-To: <080120071418.11784.46B09645000B42BF00002E082200735834CE05040A05@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Quel Qun <kelk1@comcast.net>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070002040603070907070700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Quel Qun wrote:
>  -------------- Original message ----------------------
> From: Tejun Heo <htejun@gmail.com>
>> Hello,
>>
>> Luiz Fernando N. Capitulino wrote:
>>>  Hi there,
>>>
>>>  A Mandriva user is reporting that his machine hangs while booting
>>> kernels 2.6.22.1 and 2.6.23-rc1.
>>>
>>>  But boots fine with 2.6.21.
>>>
>>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> ata1.00: qc timeout (cmd 0x27)
>>> ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)
>>> ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133
>>> ata1.00: 781422768 sectors, multi 8: LBA48
>>> ata1.00: failed to set xfermode (err_mask=0x40)
>>> ata1: failed to recover some devices, retrying in 5 secs
>> What happens after this?
>>
> It basically retries a few times, then fails to boot. Here is a more complete log with 2.6.23-rc1:

Does the attached patch change anything?

-- 
tejun

--------------070002040603070907070700
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d8c6789..af5db69 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1915,8 +1915,8 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
-			if (ata_id_hpa_enabled(dev->id))
-				dev->n_sectors = ata_hpa_resize(dev);
+			//if (ata_id_hpa_enabled(dev->id))
+			//	dev->n_sectors = ata_hpa_resize(dev);
 
 			/* config NCQ */
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));

--------------070002040603070907070700--
