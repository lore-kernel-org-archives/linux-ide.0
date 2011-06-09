From: Tejun Heo <tj@kernel.org>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Thu, 9 Jun 2011 16:37:55 +0200
Message-ID: <20110609143755.GA2615@htj.dyndns.org>
References: <4DEE6831.9020501@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41657 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1FIOh7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 10:37:59 -0400
Received: by fxm17 with SMTP id 17so1021165fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2011 07:37:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DEE6831.9020501@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Tue, Jun 07, 2011 at 07:04:33PM +0100, Tim Small wrote:
> --- libata-pmp.c.orig 2010-11-22 04:34:38.000000000 +0900
> +++ libata-pmp.c 2010-11-22 04:42:59.000000000 +0900
> @@ -286,6 +286,8 @@
>                         reason = "failed to write Sil3726 Private Register";
>                         goto fail;
>                 }
> + /* nr_ports decrement */
> + nr_ports--;
>         }
>  
>         if (print_info) {
> 
> 
> 
> ... and was going to give it a go, but it's not really obvious to me
> what it does (aside from the err great comment of course), and I
> couldn't find any other references to this patch on the web, and thought
> someone here might be able to shed some light on it...

3726 has an extra port for SEMB device (ie. it's not connected to
actual downstream port) and the above will make the kernel ignore that
port completely.  Maybe we shouldn't issue hardreset either.  Can you
please try the following patch (without the nr_ports-- hack)?

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index f06b7ea..3ab4784 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -398,7 +398,8 @@ static void sata_pmp_quirks(struct ata_port *ap)
 
 			/* port 5 is for SEMB device and it doesn't like SRST */
 			if (link->pmp == 5)
-				link->flags |= ATA_LFLAG_NO_SRST |
+				link->flags |= ATA_LFLAG_NO_HRST |
+					       ATA_LFLAG_NO_SRST |
 					       ATA_LFLAG_ASSUME_SEMB;
 		}
 	} else if (vendor == 0x1095 && devid == 0x4723) {


-- 
tejun
