From: Moritz Heiber <moe@lunar-linux.org>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 7 May 2006 15:10:21 +0200
Message-ID: <20060507151021.2986c766.moe@lunar-linux.org>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
	<445D6298.7090003@gmail.com>
	<20060507140443.7ae89a68.moe@lunar-linux.org>
	<445DE5D1.3010203@gmail.com>
Reply-To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__7_May_2006_15_10_21_+0200_qeEPItDivuFTa54c"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:61362 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932153AbWEGNKY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 09:10:24 -0400
In-Reply-To: <445DE5D1.3010203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__7_May_2006_15_10_21_+0200_qeEPItDivuFTa54c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 07 May 2006 21:19:29 +0900
Tejun Heo <htejun@gmail.com> wrote:

<snip>
> >> More info can be obtained by printing SCR_CONTROL, just print the
> >> result of scr_read(ap, SCR_CONTROL) from
> >> libata.c::sata_print_link_status(), which prints the SStatus value.
> > 
> > I'm going to try to follow that lead. There doesn't seem to be any
> > sort of tool or application that runs the exact same test yet, is
> > there? hdparm fails on me.
> 
> Heh heh... I should have attached a patch for this.  I was too lazy. 
> I'm attaching one on this mail.

Here's the output:

------

libata version 1.20 loaded.
ahci 0000:03:00.0: version 1.2
PCI: Found IRQ 5 for device 0000:03:00.0
<...>
PCI: Setting latency timer of device 0000:03:00.0 to 64
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xF8814100 ctl 0x0 bmdma 0x0 irq 5
<...>
ata1: SATA link up 1.5 (SStatus 113 SControl 300)
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
  Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0

------

I guess the Scontrol value of 300 is .. good?

I had to adjust your patch since it didn't apply to my 2.6.16.14 kernel.
The "corrected" patch is attached. I think I pretty much retained the
functionality you intended it to have.

Given your patch though .. your git-based code looks much simpler. I
wonder if that is a good or a bad thing and wether I should try a more
recent kernel .. (?)

> > Well, I'm just making an effort to get the best out of the hardware
> > I bought. I might fail at some point .. but at least I can say I
> > tried.
> 
> Yeap, good luck.  FYI, my seagate 7200.9 and samsung hd160jj work
> fine @ 3Gbps on ICH7 AHCI, sil3124 and sil3132.

Yeah, as I heard the ICH(n) chipsets are pretty well supported.
Unfortunately, I went with a ULi chipset since they are rumoured to be
rock solid and stable (which my motherboard is actually).

Regards,

Moritz

--Multipart=_Sun__7_May_2006_15_10_21_+0200_qeEPItDivuFTa54c
Content-Type: application/octet-stream;
 name="libata-scontrol.patch"
Content-Disposition: attachment;
 filename="libata-scontrol.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jLm9yaWcJMjAwNi0wNS0wNyAxNDozNTo0Ni4w
MDAwMDAwMDAgKzAyMDAKKysrIGRyaXZlcnMvc2NzaS9saWJhdGEtY29yZS5jCTIwMDYtMDUtMDcg
MTQ6NDE6MzEuMDAwMDAwMDAwICswMjAwCkBAIC0xNTQzLDcgKzE1NDMsNyBAQAogICovCiB2b2lk
IF9fc2F0YV9waHlfcmVzZXQoc3RydWN0IGF0YV9wb3J0ICphcCkKIHsKLQl1MzIgc3N0YXR1czsK
Kwl1MzIgc3N0YXR1cywgc2NvbnRyb2w7CiAJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gamlmZmll
cyArIChIWiAqIDUpOwogCiAJaWYgKGFwLT5mbGFncyAmIEFUQV9GTEFHX1NBVEFfUkVTRVQpIHsK
QEAgLTE1NjUsNiArMTU2NSw4IEBACiAKIAkvKiBUT0RPOiBwaHkgbGF5ZXIgd2l0aCBwb2xsaW5n
LCB0aW1lb3V0cywgZXRjLiAqLwogCXNzdGF0dXMgPSBzY3JfcmVhZChhcCwgU0NSX1NUQVRVUyk7
CisJc2NvbnRyb2wgPSBzY3JfcmVhZChhcCwgU0NSX0NPTlRST0wpOworCQogCWlmIChzYXRhX2Rl
dl9wcmVzZW50KGFwKSkgewogCQljb25zdCBjaGFyICpzcGVlZDsKIAkJdTMyIHRtcDsKQEAgLTE1
NzYsMTIgKzE1NzgsMTQgQEAKIAkJCXNwZWVkID0gIjMuMCI7CiAJCWVsc2UKIAkJCXNwZWVkID0g
Ijx1bmtub3duPiI7Ci0JCXByaW50ayhLRVJOX0lORk8gImF0YSV1OiBTQVRBIGxpbmsgdXAgJXMg
R2JwcyAoU1N0YXR1cyAlWClcbiIsCi0JCSAgICAgICBhcC0+aWQsIHNwZWVkLCBzc3RhdHVzKTsK
KyAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9JTkZPCisgICAgICAgICAgICAgICAgICAgICAg
ICJhdGEldTogU0FUQSBsaW5rIHVwICVzIChTU3RhdHVzICVYIFNDb250cm9sICVYKVxuIiwKKyAg
ICAgICAgICAgICAgICAgICAgICAgYXAtPmlkLCBzcGVlZCwgc3N0YXR1cywgc2NvbnRyb2wpOwog
CQlhdGFfcG9ydF9wcm9iZShhcCk7CiAJfSBlbHNlIHsKLQkJcHJpbnRrKEtFUk5fSU5GTyAiYXRh
JXU6IFNBVEEgbGluayBkb3duIChTU3RhdHVzICVYKVxuIiwKLQkJICAgICAgIGFwLT5pZCwgc3N0
YXR1cyk7CisgICAgICAgICAgICAgICAgcHJpbnRrKEtFUk5fSU5GTworICAgICAgICAgICAgICAg
ICAgICAgICAiYXRhJXU6IFNBVEEgbGluayBkb3duIChTU3RhdHVzICVYIFNDb250cm9sICVYKVxu
IiwKKyAgICAgICAgICAgICAgICAgICAgICAgYXAtPmlkLCBzc3RhdHVzLCBzY29udHJvbCk7CiAJ
CWF0YV9wb3J0X2Rpc2FibGUoYXApOwogCX0KIAo=

--Multipart=_Sun__7_May_2006_15_10_21_+0200_qeEPItDivuFTa54c--
