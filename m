From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH] ide-timing.h: make the timing from the IDE device work
Date: Mon, 14 Feb 2005 18:55:46 +0800
Message-ID: <007001c51283$bf7e2c20$6401a8c0@tw.ibm.com>
References: <004001c485c0$fe5031a0$6401a8c0@tw.ibm.com> <20050212092229.GB2297@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006D_01C512C6.CAEECF40"
Received: from bluehawaii.tikira.net ([61.62.22.51]:64493 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261398AbVBNK4T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2005 05:56:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_006D_01C512C6.CAEECF40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


> 
> Bartolomiej, we indeed need this patch, otherwise EIDE timings the drive
> supplies to us are completely ignored in the code.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 

 Sorry the previous patch seems in incorrect format.
Resubmit it here.

Change:
 - Make the timings supplied by the IDE device work

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
--------------------------------------------------------------------------------------------------
--- libata-dev-2.6/drivers/ide/ide-timing.h 2005-02-14 16:26:37.000000000 +0800
+++ libata-dev-2.6-mod/drivers/ide/ide-timing.h 2005-02-14 18:40:57.000000000 +0800
@@ -220,6 +220,7 @@
  if (!(s = ide_timing_find_mode(speed)))
   return -EINVAL;
 
+ memcpy(t, s, sizeof(*t));
 /*
  * If the drive is an EIDE drive, it can tell us it needs extended
  * PIO/MWDMA cycle timing.
@@ -248,7 +249,7 @@
  * Convert the timing to bus clock counts.
  */
 
- ide_timing_quantize(s, t, T, UT);
+ ide_timing_quantize(t, t, T, UT);
 
 /*
  * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T


------=_NextPart_000_006D_01C512C6.CAEECF40
Content-Type: application/octet-stream;
	name="ide-timing.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ide-timing.diff"

--- libata-dev-2.6/drivers/ide/ide-timing.h	2005-02-14 =
16:26:37.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/ide/ide-timing.h	2005-02-14 =
18:40:57.000000000 +0800=0A=
@@ -220,6 +220,7 @@=0A=
 	if (!(s =3D ide_timing_find_mode(speed)))=0A=
 		return -EINVAL;=0A=
 =0A=
+	memcpy(t, s, sizeof(*t));=0A=
 /*=0A=
  * If the drive is an EIDE drive, it can tell us it needs extended=0A=
  * PIO/MWDMA cycle timing.=0A=
@@ -248,7 +249,7 @@=0A=
  * Convert the timing to bus clock counts.=0A=
  */=0A=
 =0A=
-	ide_timing_quantize(s, t, T, UT);=0A=
+	ide_timing_quantize(t, t, T, UT);=0A=
 =0A=
 /*=0A=
  * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, =
S.M.A.R.T=0A=

------=_NextPart_000_006D_01C512C6.CAEECF40--


