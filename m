From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BUG] sata_via broken by recent libata updates
Date: Wed, 24 Mar 2004 13:08:49 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4061CEB1.3080600@pobox.com>
References: <20040324163340.GD23503@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020706070507060307050105"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32455 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261915AbUCXSJE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 13:09:04 -0500
In-Reply-To: <20040324163340.GD23503@master.mivlgu.local>
List-Id: linux-ide@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020706070507060307050105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sergey Vlasov wrote:
> Hello!
> 
> After updating from 2.4.25-libata1 to 2.4.25-libata9 the sata_via
> driver stopped working.  The module loads and even seems to detect
> the presense of drives, but the SCSI-emulation devices are not
> registered:
[...]
> Seems that the problem is caused by changes in the device
> initialization - calling ata_device_add() from svia_init_one() does
> not work (at least with the 2.4.x SCSI layer).  The following patch
> solves the initialization problem:
> 
> --- kernel-source-2.4.25/drivers/scsi/sata_via.c.sata_via-init-fix	2004-03-22 14:03:31 +0300
> +++ kernel-source-2.4.25/drivers/scsi/sata_via.c	2004-03-24 16:27:50 +0300
> @@ -264,9 +264,7 @@ static int svia_init_one (struct pci_dev
>  
>  	pci_set_master(pdev);
>  
> -	/* FIXME: check ata_device_add return value */
> -	ata_device_add(probe_ent);
> -	kfree(probe_ent);
> +	ata_add_to_probe_list(probe_ent);
>  
>  	return 0;

Ah, indeed.  A bug in the 2.4 backport.  Seems to be present in sata_sis 
too.

Thanks for spotting, I just checked in the attached patch.

	Jeff



--------------020706070507060307050105
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/24 13:07:52-05:00 jgarzik@redhat.com 
#   [libata] Fix probing bug in VIA, SiS drivers
#   
#   Some 2.6 code leaked into the 2.4 backport.
#   
#   Spotted by Sergey Vlasov.
# 
# drivers/scsi/sata_via.c
#   2004/03/24 13:07:50-05:00 jgarzik@redhat.com +1 -3
#   [libata] Fix probing bug in VIA, SiS drivers
#   
#   Some 2.6 code leaked into the 2.4 backport.
#   
#   Spotted by Sergey Vlasov.
# 
# drivers/scsi/sata_sis.c
#   2004/03/24 13:07:50-05:00 jgarzik@redhat.com +1 -3
#   [libata] Fix probing bug in VIA, SiS drivers
#   
#   Some 2.6 code leaked into the 2.4 backport.
#   
#   Spotted by Sergey Vlasov.
# 
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	Wed Mar 24 13:08:01 2004
+++ b/drivers/scsi/sata_sis.c	Wed Mar 24 13:08:01 2004
@@ -182,9 +182,7 @@
 	pci_set_master(pdev);
 	pci_enable_intx(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	ata_add_to_probe_list(probe_ent);
 
 	return 0;
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Wed Mar 24 13:08:01 2004
+++ b/drivers/scsi/sata_via.c	Wed Mar 24 13:08:01 2004
@@ -264,9 +264,7 @@
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	ata_add_to_probe_list(probe_ent);
 
 	return 0;
 

--------------020706070507060307050105--

