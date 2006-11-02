From: "Peer Chen" <pchen@nvidia.com>
Subject: [PATCH 2/2] IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c & pata_amd.c
Date: Thu, 2 Nov 2006 11:31:00 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA8@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6FE2F.5199DE4A"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.143]:65291 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1752587AbWKBDhP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 22:37:15 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FE2F.5199DE4A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add support for PATA controllers of MCP67 to pata_amd.c.
The patch will be applied to kernel 2.6.19-rc4-git1.
Please check attachment for the patch.

Signed-off-by: Peer Chen <pchen@nvidia.com>

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C6FE2F.5199DE4A
Content-Type: application/octet-stream;
	name="patch.pata_amd"
Content-Transfer-Encoding: base64
Content-Description: patch.pata_amd
Content-Disposition: attachment;
	filename="patch.pata_amd"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0MS9kcml2ZXJzL2F0YS9wYXRhX2FtZC5jLm9yaWcJMjAw
Ni0xMC0zMSAyMDo0NToxNC4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOS1yYzQtZ2l0
MS9kcml2ZXJzL2F0YS9wYXRhX2FtZC5jCTIwMDYtMTAtMzEgMjA6MjU6MjQuMDAwMDAwMDAwICsw
ODAwCkBAIC02NzcsNiArNjc3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
IGFtZFtdIAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9S
Q0VfTUNQNTFfSURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lE
X05WSURJQV9ORk9SQ0VfTUNQNTVfSURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQ
Q0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjFfSURFKSwJOCB9LAorCXsgUENJX1ZERVZJ
Q0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjVfSURFKSwJOCB9LAor
CXsgUENJX1ZERVZJQ0UoTlZJRElBLAlQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjdf
SURFKSwJOCB9LAogCXsgUENJX1ZERVZJQ0UoQU1ELAlQQ0lfREVWSUNFX0lEX0FNRF9DUzU1MzZf
SURFKSwJCTkgfSwKIAogCXsgfSwK

------_=_NextPart_001_01C6FE2F.5199DE4A--
