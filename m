From: snatcher snatcher <snatcher93@rocketmail.com>
Subject: Re : Re : sata_sil problems with SIL3512 controler on a ppc target
Date: Wed, 15 Nov 2006 06:06:28 -0800 (PST)
Message-ID: <20061115140629.61552.qmail@web51405.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web51405.mail.yahoo.com ([206.190.38.184]:47478 "HELO
	web51405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030434AbWKOOGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2006 09:06:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,
I've tried to force this already with no changes in the behaviour (ie :=
 timeout). Actually it's not applying the patch because the value is al=
ready correct (I've add some print code to check what was the readed va=
lue, and it was 0x10401554).

This is due to the "specific" method I use to run my 2.6 kernel (rememb=
er that I'm using an embedded device where a 2.4 kernel + initrd are in=
 flash) :
I'm booting the 2.4 kernel (so It's applying the workaround in the regi=
ster), then I use a kernel module that is loading my 2.6 kernel in RAM =
(+ the initrd) and attach a function to run this kernel in the reboot m=
ethod (using register_reboot_notifier ()). Then when I'm rebooting, aft=
er shuting down all stuff, it loads my kernel instead of rebooting ...

The fact is that running the 2.4 kernel available from buffalo (with al=
l needed patches for the platform) using the same loading method is wor=
king (I have a warning message telling that I don't have a correct PCI_=
CACHE_LINE_SIZE value : it should be 0 so it's forcing it to 0 with thi=
s message : "BUFFALO:it must be zero for PPC8241/8245" but it's working=
 great). But doing the same (forcing pci cache to 0) in the 2.6 kernel =
doesn't help. Moreover, the sata_sil driver ask the pci_cache to be ena=
bled ("cache line size not set.  Driver may not function").

What should I have instead of that ? :
SCSI device sda: drive cache: write back=20
sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen=
 Best regards,

Sylver

----- Message d'origine ----
De : Tejun Heo <htejun@gmail.com>
=C0 : snatcher snatcher <snatcher93@rocketmail.com>
Cc : linux-ide@vger.kernel.org
Envoy=E9 le : Mercredi, 15 Novembre 2006, 13h59mn 46s
Objet : Re: Re : sata_sil problems with SIL3512 controler on a ppc targ=
et

snatcher snatcher wrote:
> By checking the old 2.4.20 driver used for this device, I've found
> the following lines :
>=20
> #ifdef CONFIG_BUFFALO_PLATFORM
 > writel(0x10401554, mmio_base + 0x14c);
> writel(0x10401554, mmio_base + 0x1cc);
 > #endif in the sil_init_one function (in sata_sil.c)...
>=20
> After some google searching, I've found this message from this
> mailing list : http://www.spinics.net/lists/linux-ide/msg00047.html=20
> =3D> It says that for SiI 3114 contoler, we need to force write
> 0x10401554 instead of 0x10401555 in sfis_cfg (SATA FIS reception
> config register). By looking in the source code of the latest
> version, it looks like my controler (Sil 3512) is set to apply this
> workaround too, but according to my boot log, it's not applying it
> (It should write "Applying R_ERR on DMA / activate FIS errata fix"
> just after the error about the PCI cache). I'll add some traces to
> understand what's happening and I'll tell you ... Sylver

Please apply the attached patch and report what happens.

--=20
tejun

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index f844a1f..5c34f75 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -593,8 +593,6 @@ static void sil_init_controller(struct p
=20
         for (i =3D 0, cnt =3D 0; i < n_ports; i++) {
             tmp =3D readl(mmio_base + sil_port[i].sfis_cfg);
-            if ((tmp & 0x3) !=3D 0x01)
-                continue;
             if (!cnt)
                 dev_printk(KERN_INFO, &pdev->dev,
                        "Applying R_ERR on DMA activate "
diff --git a/include/linux/libata.h b/include/linux/libata.h





=09
=09
	=09
_______________________________________________________________________=
____=20
D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vo=
s questions !=20
Profitez des connaissances, des opinions et des exp=E9riences des inter=
nautes sur Yahoo! Questions/R=E9ponses=20
http://fr.answers.yahoo.com
