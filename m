From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Mon, 31 Jul 2006 05:22:42 +0900
Message-ID: <44CD1512.1060802@gmail.com>
References: <1151182247.5566.18.camel@localhost>	 <449DFDC4.5050207@gmail.com> <1153729271.3860.14.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050802000107030701040404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:32776 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750917AbWG3UWf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Jul 2006 16:22:35 -0400
Received: by nz-out-0102.google.com with SMTP id i11so121227nzi
        for <linux-ide@vger.kernel.org>; Sun, 30 Jul 2006 13:22:34 -0700 (PDT)
In-Reply-To: <1153729271.3860.14.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEFtbWVybcO8bGxlcg==?= <tenco@gmx.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

This is a multi-part message in MIME format.
--------------050802000107030701040404
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Martin Ammermüller wrote:
> With high disk I/O and a 2.6.18-rc1 kernel i get these errors (depending
> upon the work i do, up to several times a day):
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2 frozen
> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xc8 Emask 0x2 stat 0x58 err 0x0 (HSM violation)

Hmm... Interesting.  It gets HSM violation first.

> ata1: soft resetting port
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ATA: abnormal status 0xD8 on port 0xDCA18087
> ATA: abnormal status 0xD8 on port 0xDCA18087
> ATA: abnormal status 0xD8 on port 0xDCA18087
> ATA: abnormal status 0xD8 on port 0xDCA18087
> ATA: abnormal status 0xD8 on port 0xDCA18087
> ata1.00: qc timeout (cmd 0xec)
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.00: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: hard resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete

Then two timeouts while recovering.

> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> 
>> Anyways, if your harddisk is doing this regularly, 
>> your hardware is faulty.  Maybe the connection between the controller 
>> and the disk is the problem or the disk itself.
> 
> I did not get those errors with Windows XP and i am not the only one who
> has problems running this particular laptop model with a linux kernel.
> Ok, to be honest, there's actually only one person i know of which
> bothered enough about exactly the same errors to send me an e-mail (he
> discovered at least one of my messages to this list). But in my
> experience there are almost always others getting the same error, but
> which remain silent.

It might be that the drive is quirky and raises interrupts prematurely 
sometimes.  Depending on how the driver performs recovery, the effect 
can be hidden from user.  Can you try the attached patch and see how the 
kernel acts?

-- 
tejun

--------------050802000107030701040404
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zYXRhX3NpbC5jIGIvZHJpdmVycy9zY3NpL3Nh
dGFfc2lsLmMKaW5kZXggZDBhODUwNy4uNjYzMzczOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9z
Y3NpL3NhdGFfc2lsLmMKKysrIGIvZHJpdmVycy9zY3NpL3NhdGFfc2lsLmMKQEAgLTM4MCwx
MSArMzgwLDE0IEBAIHN0YXRpYyB2b2lkIHNpbF9ob3N0X2ludHIoc3RydWN0IGF0YV9wb3IK
IAkJCWFwLT5laF9pbmZvLnNlcnJvciB8PSBzZXJyb3I7CiAJCX0KIAorCQlhdGFfcG9ydF9w
cmludGsoYXAsIEtFUk5fRVJSLCAiWFhYOiBTQVRBX0lSUSBzZXJyb3I9JXhcbiIsIHNlcnJv
cik7CiAJCWdvdG8gZnJlZXplOwogCX0KIAotCWlmICh1bmxpa2VseSghcWMgfHwgcWMtPnRm
LmN0bCAmIEFUQV9OSUVOKSkKKwlpZiAodW5saWtlbHkoIXFjIHx8IHFjLT50Zi5jdGwgJiBB
VEFfTklFTikpIHsKKwkJYXRhX3BvcnRfcHJpbnRrKGFwLCBLRVJOX0VSUiwgIlhYWDogcWM9
JXAgY3RsPSV4XG4iLCBxYywgcWMgPyBxYy0+dGYuY3RsIDogMCk7CiAJCWdvdG8gZnJlZXpl
OworCX0KIAogCS8qIENoZWNrIHdoZXRoZXIgd2UgYXJlIGV4cGVjdGluZyBpbnRlcnJ1cHQg
aW4gdGhpcyBzdGF0ZSAqLwogCXN3aXRjaCAoYXAtPmhzbV90YXNrX3N0YXRlKSB7CkBAIC00
MTUsMTMgKzQxOCwxNyBAQCBzdGF0aWMgdm9pZCBzaWxfaG9zdF9pbnRyKHN0cnVjdCBhdGFf
cG9yCiAJY2FzZSBIU01fU1Q6CiAJCWJyZWFrOwogCWRlZmF1bHQ6CisJCWF0YV9wb3J0X3By
aW50ayhhcCwgS0VSTl9FUlIsICJYWFg6IEhTTT0lZFxuIiwgYXAtPmhzbV90YXNrX3N0YXRl
KTsKIAkJZ290byBlcnJfaHNtOwogCX0KIAogCS8qIGNoZWNrIG1haW4gc3RhdHVzLCBjbGVh
cmluZyBJTlRSUSAqLwogCXN0YXR1cyA9IGF0YV9jaGtfc3RhdHVzKGFwKTsKLQlpZiAodW5s
aWtlbHkoc3RhdHVzICYgQVRBX0JVU1kpKQorCWlmICh1bmxpa2VseShzdGF0dXMgJiBBVEFf
QlVTWSkpIHsKKwkJYXRhX3BvcnRfcHJpbnRrKGFwLCBLRVJOX0VSUiwgIlhYWDogQlVTWSBz
dGF0dXM9JXhcbiIsCisJCQkJc3RhdHVzKTsKIAkJZ290byBlcnJfaHNtOworCX0KIAogCS8q
IGFjayBibWRtYSBpcnEgZXZlbnRzICovCiAJYXRhX2JtZG1hX2lycV9jbGVhcihhcCk7CkBA
IC00MzQsNiArNDQxLDcgQEAgc3RhdGljIHZvaWQgc2lsX2hvc3RfaW50cihzdHJ1Y3QgYXRh
X3BvcgogIGVycl9oc206CiAJcWMtPmVycl9tYXNrIHw9IEFDX0VSUl9IU007CiAgZnJlZXpl
OgorCWFwLT5laF9pbmZvLmFjdGlvbiB8PSBBVEFfRUhfSEFSRFJFU0VUOwogCWF0YV9wb3J0
X2ZyZWV6ZShhcCk7CiB9CiAK
--------------050802000107030701040404--
