From: "Henry Su" <henry.su@amd.com>
Subject: =?utf-7?B?UkU6ICtBRnMtUEFUQ0grQUYwLWFkZCB0aGUgSURFIGRldmljZSBJRA==?=
	=?utf-7?B?IGZvciBBVEkgU0I3MDA=?=
Date: Wed, 16 May 2007 11:38:49 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F35860201A4D590@shacnexch2.atitech.com>
References: <200705160037.03542.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:36181 "EHLO
	outbound3-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754576AbXEPDi5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 23:38:57 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200705160037.03542.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, =?utf-7?B?Z21haWwrQUY4LWF0aQ==?= <henry.su.ati@gmail.com>
Cc: linux-ide@vger.kernel.org

hi Bart,
Thanks for your kindly reply, it's seems that something wrong with the MS outlook,
the IXP700 device ID is defined to /linux/pci+AF8-ids.h in another patch,I will resend the  
complete patch.

BRS,
Henry

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



