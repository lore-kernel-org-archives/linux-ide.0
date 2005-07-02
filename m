From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] SCSI_SATA has to be a tristate
Date: Sat, 2 Jul 2005 23:43:51 +0200
Message-ID: <20050702214351.GB5346@stusta.de>
References: <42C6C5CE.50203@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:522 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261291AbVGBVnx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Jul 2005 17:43:53 -0400
Content-Disposition: inline
In-Reply-To: <42C6C5CE.50203@freemail.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zoltan Boszormenyi <zboszor@freemail.hu>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jul 02, 2005 at 06:50:22PM +0200, Zoltan Boszormenyi wrote:

> Hi!

Hi Zoltan!

> I got this, the tree is freshly untarred and patched:
>=20
>   BUILD   arch/x86_64/boot/bzImage
> Root device is (3, 10)
> Boot sector 512 bytes.
> Setup is 7249 bytes.
> System is 1586 kB
> Kernel: arch/x86_64/boot/bzImage is ready
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "is_broadcast_ether_addr" [net/ieee80211/ieee80211.ko]=20
> undefined!

Known bug, fix was already posted.

> *** Warning: "ata_device_add" [drivers/scsi/sata_vsc.ko] undefined!
>...
> .config is attached.

Thanks for this report, the fix is below.

> Best regards,
> Zolt=E1n B=F6sz=F6rm=E9nyi

cu
Adrian


<--  snip  -->


SCSI=3Dm must disallow static drivers.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.0=
00000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.00000=
0000 +0200
@@ -447,7 +447,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
=20
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
