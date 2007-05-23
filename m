From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?UkU6ICtBRnMtUEFUQ0grQUYwLWFkZCB0aGUgSURFIGRldmljZSBJRA==?=
	=?utf-7?B?IGZvciBBVEkgU0I3MDA=?=
Date: Wed, 23 May 2007 17:26:35 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201AEF3D7@shacnexch2.atitech.com>
References: <200705160037.03542.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:31352 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757351AbXEWJ0n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 05:26:43 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200705160037.03542.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, =?utf-7?B?Z21haWwrQUY4LWF0aQ==?= <henry.su.ati@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Bart,
I have resent four patches for the ATI SB700 chipset, could you please help me check if  these patches are applied?
I list all patches as following, Thanks for your help+ACE-

BRs,
Henry


+AFs-PATCH 1/4+AF0- add the SMBus device ID for ATI SB700
From: henry.su+AEA-amd.com
add the SMBUS device id for ATI SB700.
Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-
-----------------------------------------------------
diff -Nur linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h linux-2.6.21.1/include/linux/pci+AF8-ids.h
--- linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h 2007-05-16 13:28:54.405386000 +-0800
+-+-+- linux-2.6.21.1/include/linux/pci+AF8-ids.h      2007-05-16 13:45:29.936636000 +-0800
+AEAAQA- -371,6 +-371,9 +AEAAQA-
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SRAID 0x4381
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS 0x4385
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE   0x438c
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA  0x4390
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS 0x4395
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE   0x439c

 +ACM-define PCI+AF8-VENDOR+AF8-ID+AF8-VLSI             0x1004
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-VLSI+AF8-82C592      0x0005

diff -Nur linux-2.6.21.1.orig/drivers/i2c/busses/i2c-piix4.c linux-2.6.21.1/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.21.1.orig/drivers/i2c/busses/i2c-piix4.c  2007-05-16 13:27:53.014761000 +-0800
+-+-+- linux-2.6.21.1/drivers/i2c/busses/i2c-piix4.c       2007-05-16 13:40:21.546011000 +-0800
+AEAAQA- -23,7 +-23,7 +AEAAQA-
    Supports:
        Intel PIIX4, 440MX
        Serverworks OSB4, CSB5, CSB6, HT-1000
-       ATI IXP200, IXP300, IXP400, SB600
+-       ATI IXP200, IXP300, IXP400, SB600, SB700
        SMSC Victory66

    Note: we assume there can only be one device, with one SMBus interface.
+AEAAQA- -399,6 +-399,8 +AEAAQA-
          .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS),
          .driver+AF8-data +AD0- 0 +AH0-,
+-       +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS),
+-         .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-SERVERWORKS, PCI+AF8-DEVICE+AF8-ID+AF8-SERVERWORKS+AF8-OSB4),
          .driver+AF8-data +AD0- 0 +AH0-,
        +AHs- PCI+AF8-DEVICE(PCI+AF8-VENDOR+AF8-ID+AF8-SERVERWORKS, PCI+AF8-DEVICE+AF8-ID+AF8-SERVERWORKS+AF8-CSB5),


+AFs-PATCH 2/4+AF0- add the IDE and SATA device IDs for ATI SB700.
From: henry.su+AEA-amd.com
add the IDE and SATA device ids for ATI SB700.
Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-
-----------------------------------------------------
diff -Nur linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h linux-2.6.21.1/include/linux/pci+AF8-ids.h
--- linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h 2007-05-16 13:28:54.405386000 +-0800
+-+-+- linux-2.6.21.1/include/linux/pci+AF8-ids.h      2007-05-16 13:45:29.936636000 +-0800
+AEAAQA- -371,6 +-371,9 +AEAAQA-
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SRAID 0x4381
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS 0x4385
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE   0x438c
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA  0x4390
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS 0x4395
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE   0x439c

 +ACM-define PCI+AF8-VENDOR+AF8-ID+AF8-VLSI             0x1004
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-VLSI+AF8-82C592      0x0005

diff -Nur linux-2.6.21.1.orig/drivers/ata/pata+AF8-atiixp.c linux-2.6.21.1/drivers/ata/pata+AF8-atiixp.c
--- linux-2.6.21.1.orig/drivers/ata/pata+AF8-atiixp.c       2007-05-16 13:27:49.764761000 +-0800
+-+-+- linux-2.6.21.1/drivers/ata/pata+AF8-atiixp.c    2007-05-16 13:37:47.014761000 +-0800
+AEAAQA- -283,6 +-283,7 +AEAAQA-
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP300+AF8-IDE), +AH0-,
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP400+AF8-IDE), +AH0-,
        +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE), +AH0-,
+-       +AHs- PCI+AF8-VDEVICE(ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE), +AH0-,

        +AHs- +AH0-,
 +AH0AOw-

diff -Nur linux-2.6.21.1.orig/drivers/ata/ahci.c linux-2.6.21.1/drivers/ata/ahci.c
--- linux-2.6.21.1.orig/drivers/ata/ahci.c      2007-05-16 13:27:49.717886000 +-0800
+-+-+- linux-2.6.21.1/drivers/ata/ahci.c   2007-05-16 13:42:40.155386000 +-0800
+AEAAQA- -415,6 +-415,7 +AEAAQA-
        /+ACo- ATI +ACo-/
        +AHs- PCI+AF8-VDEVICE(ATI, 0x4380), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB600 non-raid +ACo-/
        +AHs- PCI+AF8-VDEVICE(ATI, 0x4381), board+AF8-ahci +AH0-, /+ACo- ATI SB600 raid +ACo-/
+-       +AHs- PCI+AF8-VDEVICE(ATI, 0x4390), board+AF8-ahci+AF8-sb600 +AH0-, /+ACo- ATI SB700 non-raid +ACo-/

        /+ACo- VIA +ACo-/
        +AHs- PCI+AF8-VDEVICE(VIA, 0x3349), board+AF8-ahci+AF8-vt8251 +AH0-, /+ACo- VIA VT8251 +ACo-/


+AFs-PATCH 3/4+AF0-add the IDE device ID for ATI SB700
From: henry.su+AEA-amd.com
add the IDE device ids to atiixp+AF8-pci+AF8-tbl struct in atiixp.c for ATI SB700.
Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-
-----------------------------------------------------
diff -Nur linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h linux-2.6.21.1/include/linux/pci+AF8-ids.h
--- linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h 2007-05-16 13:28:54.405386000 +-0800
+-+-+- linux-2.6.21.1/include/linux/pci+AF8-ids.h      2007-05-16 13:45:29.936636000 +-0800
+AEAAQA- -371,6 +-371,9 +AEAAQA-
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SRAID 0x4381
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS 0x4385
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE   0x438c
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA  0x4390
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS 0x4395
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE   0x439c

 +ACM-define PCI+AF8-VENDOR+AF8-ID+AF8-VLSI             0x1004
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-VLSI+AF8-82C592      0x0005

diff -Nur linux-2.6.21.1.orig/drivers/ide/pci/atiixp.c linux-2.6.21.1/drivers/ide/pci/atiixp.c
--- linux-2.6.21.1.orig/drivers/ide/pci/atiixp.c        2007-05-16 13:27:53.671011000 +-0800
+-+-+- linux-2.6.21.1/drivers/ide/pci/atiixp.c     2007-05-16 13:43:51.952261000 +-0800
+AEAAQA- -353,6 +-353,7 +AEAAQA-
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP300+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP400+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
        +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
+-       +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
        +AHs- 0, +AH0-,
 +AH0AOw-
 MODULE+AF8-DEVICE+AF8-TABLE(pci, atiixp+AF8-pci+AF8-tbl)+ADs-

+AFs-PATCH 4/4+AF0- Add the combined mode for ATI SB700
From: henry.su+AEA-amd.com
Besides those modes in ATI SB600 SATA controller, ATI SB700 supports one more mode:the combined mode.

The combined mode is a Legacy IDE mode used for compatibility with some old OS without AHCI driver, 
but now it is not necessary for Linux since the kernel has supported AHCI.
Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-
-----------------------------------------------------
diff -Nur linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h linux-2.6.21.1/include/linux/pci+AF8-ids.h
--- linux-2.6.21.1.orig/include/linux/pci+AF8-ids.h 2007-05-16 13:28:54.405386000 +-0800
+-+-+- linux-2.6.21.1/include/linux/pci+AF8-ids.h      2007-05-16 13:45:29.936636000 +-0800
+AEAAQA- -371,6 +-371,9 +AEAAQA-
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SRAID 0x4381
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SMBUS 0x4385
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE   0x438c
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA  0x4390
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SMBUS 0x4395
+-+ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE   0x439c

 +ACM-define PCI+AF8-VENDOR+AF8-ID+AF8-VLSI             0x1004
 +ACM-define PCI+AF8-DEVICE+AF8-ID+AF8-VLSI+AF8-82C592      0x0005

diff -Nur linux-2.6.21.1.orig/drivers/pci/quirks.c linux-2.6.21.1/drivers/pci/quirks.c
--- linux-2.6.21.1.orig/drivers/pci/quirks.c    2007-05-16 13:28:09.702261000 +-0800
+-+-+- linux-2.6.21.1/drivers/pci/quirks.c 2007-05-16 13:41:26.155386000 +-0800
+AEAAQA- -875,6 +-875,7 +AEAAQA-
        +AH0-
 +AH0-
 DECLARE+AF8-PCI+AF8-FIXUP+AF8-HEADER(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-SATA, quirk+AF8-sb600+AF8-sata)+ADs-
+-DECLARE+AF8-PCI+AF8-FIXUP+AF8-HEADER(PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-SATA, quirk+AF8-sb600+AF8-sata)+ADs-

 /+ACo-
  +ACo-     Serverworks CSB5 IDE does not fully support native mode















-----Original Message-----
From: Bartlomiej Zolnierkiewicz +AFs-mailto:bzolnier+AEA-gmail.com+AF0- 
Sent: Wednesday, May 16, 2007 6:37 AM
To: gmail+AF8-ati
Cc: Henry Su+ADs- linux-ide+AEA-vger.kernel.org
Subject: Re: +AFs-PATCH+AF0-add the IDE device ID for ATI SB700


Hi,

On Monday 14 May 2007, gmail+AF8-ati wrote:
+AD4- From: henry.su.ati+AEA-gmail.com
+AD4- add the IDE device ids to atiixp+AF8-pci+AF8-tbl struct in atiixp.c for ATI SB700.
+AD4- Signed-off-by: Luugi Marsan +ADw-luugi.marsan+AEA-amd.com+AD4-

This patch is somehow missing the chunk adding PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE
define to +ADw-linux/pci+AF8-ids.h+AD4- and thus makes atiixp.c fail to compile.

Please resend the complete patch.

PS your mailer seems to encode patches in some strange way (whitespaces are
mangled and saved email contained MIME encoded text instead of plain-text) so
I had to apply this change by hand.  Not really a problem for this particular
patch +ADs-) but definitively something needing fixing.

Thanks,
Bart

+AD4- -----------------------------------------------------
+AD4- diff -Nur linux-2.6.21.1.org/drivers/ide/pci/atiixp.c linux-2.6.21.1/drivers/ide/pci/atiixp.c
+AD4- --- linux-2.6.21.1.org/drivers/ide/pci/atiixp.c 2007-05-13 04:47:25.000000000 +-0800
+AD4- +-+-+- linux-2.6.21.1/drivers/ide/pci/atiixp.c 2007-05-13 05:14:08.000000000 +-0800
+AD4- +AEAAQA- -353,6 +-353,7 +AEAAQA-
+AD4-   +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP300+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
+AD4-   +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP400+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 0+AH0-,
+AD4-   +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP600+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
+AD4- +- +AHs- PCI+AF8-VENDOR+AF8-ID+AF8-ATI, PCI+AF8-DEVICE+AF8-ID+AF8-ATI+AF8-IXP700+AF8-IDE, PCI+AF8-ANY+AF8-ID, PCI+AF8-ANY+AF8-ID, 0, 0, 1+AH0-,
+AD4-   +AHs- 0, +AH0-,
+AD4-  +AH0AOw-
+AD4-  MODULE+AF8-DEVICE+AF8-TABLE(pci, atiixp+AF8-pci+AF8-tbl)+ADs-



