From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: [PATCH] Fix libata resource conflict for legacy mode
Date: Mon, 18 Sep 2006 17:02:57 +0200
Message-ID: <m3zmcxgqu6.fsf@anduin.mandriva.com>
References: <m3ac4xiacr.fsf@anduin.mandriva.com> <450EA3BA.8010100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:33802 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751702AbWIROwi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 10:52:38 -0400
In-Reply-To: <450EA3BA.8010100@gmail.com> (Tejun Heo's message of "Mon, 18 Sep
	2006 22:48:42 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--=-=-=

Tejun Heo <htejun@gmail.com> writes:

> Hello,

Hi,


>> Index: linux-2.6/drivers/scsi/libata-bmdma.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/scsi/libata-bmdma.c
>> +++ linux-2.6/drivers/scsi/libata-bmdma.c
>> @@ -1016,10 +1016,13 @@ int ata_pci_init_one (struct pci_dev *pd
>>  			res.start = 0x1f0;
>>  			res.end = 0x1f0 + 8 - 1;
>>  			conflict = ____request_resource(&ioport_resource, &res);
>> +			if (conflict->child)
>> +				conflict = ____request_resource(conflict,&res);
>
> IMHO, having something which is slightly more generic would be better - 
> e.g. looping till no child.

Ok. Done in the attached patch.

>
>>  			if (!strcmp(conflict->name, "libata"))
>>  				legacy_mode |= (1 << 0);
>>  			else {
>>  				disable_dev_on_err = 0;
>> +				printk(KERN_WARNING "ata: conflict with %s\n",conflict->name);
>>  				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
>
> Please merge two printks into one.  Other than that, I think printing 

Fixed too.


Regards,
Arnaud

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=2618git_libata_vs_pnp.patch

When the libata is trying to handle legacy ide ports (0x1f0 for instance), it
doesn't take care if the resource has childs or not. 
The result is that this situation :
0100-01fe : pnp 00:09
  0170-0177 : libata
  01f0-01f7 : libata

is seen as conflict, which is wrong.
The proposed fix is to detect childs and in this case, look at which child is
conflicting.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---
Index: linux-2.6/drivers/scsi/libata-bmdma.c
===================================================================
--- linux-2.6.orig/drivers/scsi/libata-bmdma.c
+++ linux-2.6/drivers/scsi/libata-bmdma.c
@@ -1016,11 +1016,14 @@ int ata_pci_init_one (struct pci_dev *pd
 			res.start = 0x1f0;
 			res.end = 0x1f0 + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
+			while (conflict->child)
+				conflict = ____request_resource(conflict, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 0);
 			else {
 				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
+				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n" \
+						    "ata: conflict with %s\n", conflict->name);
 			}
 		} else
 			legacy_mode |= (1 << 0);
@@ -1030,11 +1033,14 @@ int ata_pci_init_one (struct pci_dev *pd
 			res.start = 0x170;
 			res.end = 0x170 + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
+			while (conflict->child)
+				conflict = ____request_resource(conflict, &res);
 			if (!strcmp(conflict->name, "libata"))
 				legacy_mode |= (1 << 1);
 			else {
 				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
+				printk(KERN_WARNING "ata: 0x170 IDE port busy\n" \
+						    "ata: conflict with %s\n", conflict->name);
 			}
 		} else
 			legacy_mode |= (1 << 1);

--=-=-=--

