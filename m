From: Tejun Heo <htejun@gmail.com>
Subject: Re: +AFs-patch+AF0- Add more device IDs for supporting ATI SB700
 SATA controller completely
Date: Fri, 13 Jul 2007 18:19:44 +0900
Message-ID: <469743B0.4040005@gmail.com>
References: <FFECF24D2A7F6D418B9511AF6F35860202098043@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762047AbXGMJTs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 05:19:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so509360wah
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 02:19:48 -0700 (PDT)
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F35860202098043@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henry Su <henry.su@amd.com>
Cc: linux-ide@vger.kernel.org

Henry Su wrote:
> From: henry.su+AEA-amd.com
> 
> The sata controller device ID will be different according to the onchip
>  sata type setting in system BIOS:
> Device                                                                 Device ID
> SATA in IDE mode                                             0x4390
> SATA in AHCI mode                                           0x4391
> SATA in RAID mode with non-Raid 5 driver  0x4392
> SATA in RAID mode with Raid 5 driver          0x4393
> 
> Signed-off-by: henry.su+AEA-amd.com
> ----------------------------------------------
> diff -Nur linux-2.6.22.1.orig/drivers/ata/ahci.c linux-2.6.22.1/drivers/ata/ahci.c
> --- linux-2.6.22.1.orig/drivers/ata/ahci.c      2007-07-13 10:39:27.854093200 +-0800
> +-+-+- linux-2.6.22.1/drivers/ata/ahci.c   2007-07-13 10:52:58.625022700 +-0800
> +AEAAQA- -399,7 +-399,10 +AEAAQA-
> 
>         /+ACo- ATI +ACo-/
>         +AHs- PCI+AF8-VDEVICE(ATI, 0x4380), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB600 +ACo-/
> -       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 +ACo-/
> +-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 IDE +ACo-/
> +-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4391), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 AHCI +ACo-/
> +-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4392), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 nor-raid5 +ACo-/
> +-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4393), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 raid5 +ACo-/
> 
>         /+ACo- VIA +ACo-/
>         +AHs- PCI+AF8-VDEVICE(VIA, 0x3349), board+AF8-ahci+AF8-vt8251 +AH0-, /+ACo- VIA VT8251 +ACo-/

What did you do to your mailer?  Or, what is your mailer doing to you?
Please get yourself a thunderbird.

-- 
tejun
