From: Marcello Maggioni <hayarms@gmail.com>
Subject: [PATCH] Timeout at bootTime with NEC3500A (and possibly others) when inserted a CD in it.
Date: Tue, 26 Apr 2005 20:06:19 +0200
Message-ID: <63f5296805042611066489d7e1@mail.gmail.com>
Reply-To: Marcello Maggioni <hayarms@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3254_25048881.1114538779106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:9499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261539AbVDZSGT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Apr 2005 14:06:19 -0400
Received: by zproxy.gmail.com with SMTP id 13so18769nzp
        for <linux-ide@vger.kernel.org>; Tue, 26 Apr 2005 11:06:19 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------=_Part_3254_25048881.1114538779106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I've attached a patch intended for solving boottime issues with this
and other drives when a CD/DVD is inserted .

Problem: Some drives (NEC 3500 , TDK 1616N , Mad-dog MD-16XDVD9, RICOH
MP5163DA , Memorex DVD9 drive and IO-DATA's too for sure) , if a
CD/DVD is inserted into the tray when the system is booted and if
before the OS bootup the BIOS checked for the presence of a bootable
CD/DVD into the drive , during the IDE probe phase the drive may
result busy and remain so for the next 25/30 seconds . This cause the
drive to be skipped during the booting phase and not begin usable
until the next reboot (if the reboot goes well and the drive doesn't
timeout again ).

Solution: Rising the timeout time from 10 seconds to 35 seconds
(during these 35 seconds  every drive should wake up for sure
according to the tests I've done) .

Here the simple patch :

--- drivers/ide/ide-probe.c.orig        2005-04-26 15:04:46.000000000 +0200
+++ drivers/ide/ide-probe.c     2005-04-26 15:04:14.000000000 +0200
@@ -638,13 +638,13 @@
       SELECT_DRIVE(&hwif->drives[0]);
       hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
       mdelay(2);
-       rc =3D ide_wait_not_busy(hwif, 10000);
+       rc =3D ide_wait_not_busy(hwif, 35000);
       if (rc)
               return rc;
       SELECT_DRIVE(&hwif->drives[1]);
       hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
       mdelay(2);
-       rc =3D ide_wait_not_busy(hwif, 10000);
+       rc =3D ide_wait_not_busy(hwif, 35000);

       /* Exit function with master reselected (let's be sane) */
       SELECT_DRIVE(&hwif->drives[0]);

Greets,

Maggioni Marcello

------=_Part_3254_25048881.1114538779106
Content-Type: text/plain; name="ide-timeout-NEC3500.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-timeout-NEC3500.diff"

LS0tIGRyaXZlcnMvaWRlL2lkZS1wcm9iZS5jLm9yaWcJMjAwNS0wNC0yNiAxNTowNDo0Ni4wMDAw
MDAwMDAgKzAyMDAKKysrIGRyaXZlcnMvaWRlL2lkZS1wcm9iZS5jCTIwMDUtMDQtMjYgMTU6MDQ6
MTQuMDAwMDAwMDAwICswMjAwCkBAIC02MzgsMTMgKzYzOCwxMyBAQAogCVNFTEVDVF9EUklWRSgm
aHdpZi0+ZHJpdmVzWzBdKTsKIAlod2lmLT5PVVRCKDgsIGh3aWYtPmlvX3BvcnRzW0lERV9DT05U
Uk9MX09GRlNFVF0pOwogCW1kZWxheSgyKTsKLQlyYyA9IGlkZV93YWl0X25vdF9idXN5KGh3aWYs
IDEwMDAwKTsKKwlyYyA9IGlkZV93YWl0X25vdF9idXN5KGh3aWYsIDM1MDAwKTsKIAlpZiAocmMp
CiAJCXJldHVybiByYzsKIAlTRUxFQ1RfRFJJVkUoJmh3aWYtPmRyaXZlc1sxXSk7CiAJaHdpZi0+
T1VUQig4LCBod2lmLT5pb19wb3J0c1tJREVfQ09OVFJPTF9PRkZTRVRdKTsKIAltZGVsYXkoMik7
Ci0JcmMgPSBpZGVfd2FpdF9ub3RfYnVzeShod2lmLCAxMDAwMCk7CisJcmMgPSBpZGVfd2FpdF9u
b3RfYnVzeShod2lmLCAzNTAwMCk7CiAKIAkvKiBFeGl0IGZ1bmN0aW9uIHdpdGggbWFzdGVyIHJl
c2VsZWN0ZWQgKGxldCdzIGJlIHNhbmUpICovCiAJU0VMRUNUX0RSSVZFKCZod2lmLT5kcml2ZXNb
MF0pOwo=
------=_Part_3254_25048881.1114538779106--
