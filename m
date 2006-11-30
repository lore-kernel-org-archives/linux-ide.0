From: "Peer Chen" <pchen@nvidia.com>
Subject: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Thu, 30 Nov 2006 17:40:20 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0D588DC0@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C71463.8DCDE1B9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:15924 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S933351AbWK3Jkn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 04:40:43 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71463.8DCDE1B9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Move the device IDs of MCP65/MCP67 from sata_nv.c to ahci.c.
The patch will be applied to kernel 2.6.19.
Please check attachment for the patch.

Signed-off-by: Peer Chen <pchen@nvidia.com>


BRs
Peer Chen


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

------_=_NextPart_001_01C71463.8DCDE1B9
Content-Type: application/octet-stream;
	name="patch.sata_nv"
Content-Transfer-Encoding: base64
Content-Description: patch.sata_nv
Content-Disposition: attachment;
	filename="patch.sata_nv"

LS0tIGxpbnV4LTIuNi4xOS9kcml2ZXJzL2F0YS9zYXRhX252LmMub3JpZwkyMDA2LTExLTMwIDE0
OjIwOjQyLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5L2RyaXZlcnMvYXRhL3NhdGFf
bnYuYwkyMDA2LTExLTMwIDE0OjIzOjE2LjAwMDAwMDAwMCArMDgwMApAQCAtMTE3LDE0ICsxMTcs
NiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZfcGNpCiAJeyBQQ0lfVkRF
VklDRShOVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBKSwgR0VO
RVJJQyB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9S
Q0VfTUNQNjFfU0FUQTIpLCBHRU5FUklDIH0sCiAJeyBQQ0lfVkRFVklDRShOVklESUEsIFBDSV9E
RVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBMyksIEdFTkVSSUMgfSwKLQl7IFBDSV9W
REVWSUNFKE5WSURJQSwgMHgwNDVjKSwgR0VORVJJQyB9LCAvKiBNQ1A2NSAqLwotCXsgUENJX1ZE
RVZJQ0UoTlZJRElBLCAweDA0NWQpLCBHRU5FUklDIH0sIC8qIE1DUDY1ICovCi0JeyBQQ0lfVkRF
VklDRShOVklESUEsIDB4MDQ1ZSksIEdFTkVSSUMgfSwgLyogTUNQNjUgKi8KLQl7IFBDSV9WREVW
SUNFKE5WSURJQSwgMHgwNDVmKSwgR0VORVJJQyB9LCAvKiBNQ1A2NSAqLwotCXsgUENJX1ZERVZJ
Q0UoTlZJRElBLCAweDA1NTApLCBHRU5FUklDIH0sIC8qIE1DUDY3ICovCi0JeyBQQ0lfVkRFVklD
RShOVklESUEsIDB4MDU1MSksIEdFTkVSSUMgfSwgLyogTUNQNjcgKi8KLQl7IFBDSV9WREVWSUNF
KE5WSURJQSwgMHgwNTUyKSwgR0VORVJJQyB9LCAvKiBNQ1A2NyAqLwotCXsgUENJX1ZERVZJQ0Uo
TlZJRElBLCAweDA1NTMpLCBHRU5FUklDIH0sIC8qIE1DUDY3ICovCiAJeyBQQ0lfVkVORE9SX0lE
X05WSURJQSwgUENJX0FOWV9JRCwKIAkJUENJX0FOWV9JRCwgUENJX0FOWV9JRCwKIAkJUENJX0NM
QVNTX1NUT1JBR0VfSURFPDw4LCAweGZmZmYwMCwgR0VORVJJQyB9LAo=

------_=_NextPart_001_01C71463.8DCDE1B9--
