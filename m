From: <Stuart_Hayes@Dell.com>
Subject: [PATCH] ugly messages trying to open CD drive with no media present
Date: Mon, 2 Apr 2007 14:51:11 -0500
Message-ID: <DFEF91B22ED07447AB6AA4B237F913F9524A30@ausx3mpc125.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C77560.43AA2D80"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:47511 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965756AbXDBTvN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2007 15:51:13 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77560.43AA2D80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


I get the following error messages when trying to open a CD device
(specifically, the Teac CD-ROM CD-224E) that has no media present:

hda: packet command error: status=3D0x51 { DriveReady SeekComplete Error =
}
hda: packet command error: error=3D0x54 { AbortedCommand
LastFailedSense=3D0x05 }
ide: failed opcode was: unknown

This happens when a "start stop unit" command (0x1b 0 0 0 3 0 0 0 0 0)
is sent to the drive to try to close the CD-ROM tray, but this drive
doesn't have that capability (it's a slim portable-type CD-ROM), so it
reports sense key 5 (illegal request) with asc/ascq 24/0.  This is
exactly how SFF8090i says it should respond.

But ide-cd.c (in cdrom_decode_status() ) just sees sense key 5 and spews
out an error.  It then goes on to request sense data, and
cdrom_log_sense() understands this error and doesn't log it.

The patch, for kernel 2.6.20.4, suppresses this error message.

Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>


------_=_NextPart_001_01C77560.43AA2D80
Content-Type: application/octet-stream;
	name="idecd_suppress_startstop_error_msg_2.6.20.4.patch"
Content-Transfer-Encoding: base64
Content-Description: idecd_suppress_startstop_error_msg_2.6.20.4.patch
Content-Disposition: attachment;
	filename="idecd_suppress_startstop_error_msg_2.6.20.4.patch"

LS0tIGxpbnV4LTIuNi4yMC40L2RyaXZlcnMvaWRlL2lkZS1jZC5jLm9yaWcJMjAwNy0wMy0yMyAx
NDo1Mjo1MS4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi4yMC40L2RyaXZlcnMvaWRlL2lk
ZS1jZC5jCTIwMDctMDQtMDIgMDg6Mjg6MjQuMDAwMDAwMDAwIC0wNTAwCkBAIC03NDIsNiArNzQy
LDE1IEBAIHN0YXRpYyBpbnQgY2Ryb21fZGVjb2RlX3N0YXR1cyhpZGVfZHJpdmUKIAkJCWNkcm9t
X3Nhd19tZWRpYV9jaGFuZ2UgKGRyaXZlKTsKIAkJCS8qcHJpbnRrKCIlczogbWVkaWEgY2hhbmdl
ZFxuIixkcml2ZS0+bmFtZSk7Ki8KIAkJCXJldHVybiAwOworIAkJfSBlbHNlIGlmICgoc2Vuc2Vf
a2V5ID09IElMTEVHQUxfUkVRVUVTVCkgJiYKKyAJCQkgICAocnEtPmNtZFswXSA9PSBHUENNRF9T
VEFSVF9TVE9QX1VOSVQpKSB7CisgCQkJLyoKKyAJCQkgKiBEb24ndCBwcmludCBlcnJvciBtZXNz
YWdlIGZvciB0aGlzIGNvbmRpdGlvbi0tCisgCQkJICogU0ZGODA5MGkgaW5kaWNhdGVzIHRoYXQg
NS8yNC8wMCBpcyB0aGUgY29ycmVjdAorIAkJCSAqIHJlc3BvbnNlIHRvIGEgcmVxdWVzdCB0byBj
bG9zZSB0aGUgdHJheSBpZiB0aGUKKyAJCQkgKiBkcml2ZSBkb2Vzbid0IGhhdmUgdGhhdCBjYXBh
YmlsaXR5LgorIAkJCSAqIGNkcm9tX2xvZ19zZW5zZSgpIGtub3dzIHRoaXMhCisgCQkJICovCiAJ
CX0gZWxzZSBpZiAoIShycS0+Y21kX2ZsYWdzICYgUkVRX1FVSUVUKSkgewogCQkJLyogT3RoZXJ3
aXNlLCBwcmludCBhbiBlcnJvci4gKi8KIAkJCWlkZV9kdW1wX3N0YXR1cyhkcml2ZSwgInBhY2tl
dCBjb21tYW5kIGVycm9yIiwgc3RhdCk7Cg==

------_=_NextPart_001_01C77560.43AA2D80--
