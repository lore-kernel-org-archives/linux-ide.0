From: "Joel Soete" <soete.joel@tiscali.be>
Subject: a fix for NS87415 on C3K broken
Date: Wed, 22 Sep 2004 12:41:21 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4150193600000506@mail-7-bnl.tiscali.it>
References: <200409170243.06449.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========/4150193600000506/mail-7-bnl.tiscali.it"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-7-bnl.tiscali.it ([213.205.33.227]:30258 "EHLO
	mail-7-bnl.tiscali.it") by vger.kernel.org with ESMTP
	id S264085AbUIVKll (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Sep 2004 06:41:41 -0400
In-Reply-To: <200409170243.06449.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Grant Grundler <grundler@parisc-linux.org>
Cc: linux-ide@vger.kernel.org, parisc-linux@parisc-linux.org


--========/4150193600000506/mail-7-bnl.tiscali.it
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hello Grant, Bartlomiej and *,

I test this patch:
--- arch/parisc/kernel/pci.c.Orig	2004-09-22 09:47:02.000000000 +0200
+++ arch/parisc/kernel/pci.c	2004-09-22 11:26:02.104187784 +0200
@@ -146,6 +146,9 @@
 	return str;
 }
 
+/* Used in drivers/pci/quirks.c */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, super=
io_fixup_pci);
+
 /*
  * Called by pci_set_master() - a driver interface.
  *
--- drivers/parisc/superio.c.Orig	2004-09-22 11:17:53.759427472 +0200
+++ drivers/parisc/superio.c	2004-09-22 11:27:32.856391352 +0200
@@ -484,7 +484,6 @@
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 	printk("PCI: Enabled native mode for NS87415 (pif=3D0x%x)\n", prog);
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, super=
io_fixup_pci);
 
 /* Because of a defect in Super I/O, all reads of the PCI DMA status 
  * registers, IDE status register and the IDE select register need to be=


=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D

That fix the NS87415 pb on my c2k model :)
Can somebody check it with some c3k model?

And if Ok for all, can somebody ci for me?

Tia,
    Joel

PS: here attached the diff in case of bad wrapping
> -- Original Message --
> From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
> To: Grant Grundler <grundler@parisc-linux.org>
> Date: Fri, 17 Sep 2004 02:43:06 +0200
> Cc: linux-ide@vger.kernel.org, parisc-linux@lists.parisc-linux.org
> Subject: [parisc-linux] Re: NS87415 on C3K broken
> 
> 
> On Friday 17 September 2004 01:25, Grant Grundler wrote:
> > > ide_setup_pci_controller()
> > > 	-> ide_pci_enable()
> > > 		-> pci_enable_device()
> > > 
> > > and ide_setup_pci_controller() is called at the beginning
> > > of ide_setup_pci_device() before ->init_chipset()
> > 
> > Yes - I tracked the pci_enabled_device back to ide_setup_pci_controll=
er().
> > But I just realized I had another brainfart: ide_setup_pci_controller=
()
> > is not ide_setup_pci_device(). I should stop coding late at night...
> 
> Heh.
> 
> > > > Anyway, ns87415 driver has more problems. The patch below adds
> > > > "init_chipset" entry point and init_chipset_ns87415() calls
> > > > pci_enable_device() and pci_set_master() before the probe.
> > > > And my C3k still HPMCs. My guess is more of the code from
> > > > init_hwif_ns87415() needs to be moved to init_chipset_ns87415().
> > > > And possible call some special suckyio init routines.
> > > > I won't be able to touch this for a few days.
> > > > Anyone else on parisc-linux ml want to take a whack at this?
> > ...
> > > Yep, also if they are to stay please move them to ns87415.c
> > > because using <linux/ide.h> outside drivers/ide is WRONG.
> > 
> > they? superio_ide_init_iops() or something else?
> 
> They.
> 
> > Willy mentioned that as a TODO item and it's on my list.
> > But I didn't plan on touching that before the HPMC is resolved
> > or the PCI resource mgt issues are resolved.
> 
> OK, thanks.
> _______________________________________________
> parisc-linux mailing list
> parisc-linux@lists.parisc-linux.org
> http://lists.parisc-linux.org/mailman/listinfo/parisc-linux


-------------------------------------------------------------------------=
--
Tiscali ADSL GO, 29,50 Euro/mois pendant toute une ann=E9e, profitez-en..=
.
http://reg.tiscali.be/adsl/welcome.asp?lg=3DFR





--========/4150193600000506/mail-7-bnl.tiscali.it
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="NS87415.diff"

LS0tIGFyY2gvcGFyaXNjL2tlcm5lbC9wY2kuYy5PcmlnCTIwMDQtMDktMjIgMDk6NDc6MDIuMDAw
MDAwMDAwICswMjAwCisrKyBhcmNoL3BhcmlzYy9rZXJuZWwvcGNpLmMJMjAwNC0wOS0yMiAxMToy
NjowMi4xMDQxODc3ODQgKzAyMDAKQEAgLTE0Niw2ICsxNDYsOSBAQAogCXJldHVybiBzdHI7CiB9
CiAKKy8qIFVzZWQgaW4gZHJpdmVycy9wY2kvcXVpcmtzLmMgKi8KK0RFQ0xBUkVfUENJX0ZJWFVQ
X0hFQURFUihQQ0lfVkVORE9SX0lEX05TLCBQQ0lfREVWSUNFX0lEX05TXzg3NDE1LCBzdXBlcmlv
X2ZpeHVwX3BjaSk7CisKIC8qCiAgKiBDYWxsZWQgYnkgcGNpX3NldF9tYXN0ZXIoKSAtIGEgZHJp
dmVyIGludGVyZmFjZS4KICAqCi0tLSBkcml2ZXJzL3BhcmlzYy9zdXBlcmlvLmMuT3JpZwkyMDA0
LTA5LTIyIDExOjE3OjUzLjc1OTQyNzQ3MiArMDIwMAorKysgZHJpdmVycy9wYXJpc2Mvc3VwZXJp
by5jCTIwMDQtMDktMjIgMTE6Mjc6MzIuODU2MzkxMzUyICswMjAwCkBAIC00ODQsNyArNDg0LDYg
QEAKIAlwY2lfcmVhZF9jb25maWdfYnl0ZShwZGV2LCBQQ0lfQ0xBU1NfUFJPRywgJnByb2cpOwog
CXByaW50aygiUENJOiBFbmFibGVkIG5hdGl2ZSBtb2RlIGZvciBOUzg3NDE1IChwaWY9MHgleClc
biIsIHByb2cpOwogfQotREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfTlMs
IFBDSV9ERVZJQ0VfSURfTlNfODc0MTUsIHN1cGVyaW9fZml4dXBfcGNpKTsKIAogLyogQmVjYXVz
ZSBvZiBhIGRlZmVjdCBpbiBTdXBlciBJL08sIGFsbCByZWFkcyBvZiB0aGUgUENJIERNQSBzdGF0
dXMgCiAgKiByZWdpc3RlcnMsIElERSBzdGF0dXMgcmVnaXN0ZXIgYW5kIHRoZSBJREUgc2VsZWN0
IHJlZ2lzdGVyIG5lZWQgdG8gYmUgCg==

--========/4150193600000506/mail-7-bnl.tiscali.it--
