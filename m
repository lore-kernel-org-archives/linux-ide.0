From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67support to sata_nv.c
Date: Wed, 1 Nov 2006 18:04:04 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54F6A5@hkemmail01.nvidia.com>
References: <45486D47.9020803@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6FD9D.10351682"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:65058 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1946751AbWKAKEU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 05:04:20 -0500
Content-class: urn:content-classes:message
In-Reply-To: <45486D47.9020803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FD9D.10351682
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Check attachment for the new patch,thanks.=20


BRs
Peer Chen

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]=20
Sent: Wednesday, November 01, 2006 5:48 PM
To: Peer Chen
Cc: Arjan van de Ven; linux-ide@vger.kernel.org;
linux-kernel@vger.kernel.org; Alan Cox
Subject: Re: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of
MCP67support to sata_nv.c

Peer Chen wrote:
> Attached the patch cause my mail client always wrap the plain text
format.
> Check attachment for patch,thanks.

Need one more modification:

It is the libata policy to prefer use of numeric hexidecimal constants
for the PCI device id, rather than always defining a symbol in
include/linux/pci_ids.h.  The PCI device ID is a single-use "magic
number" that is only used in the PCI ID table.

Therefore, when your patch changes the hex numbers to constants, it is
reversing that policy.

Instead, please submit a patch that simply adds more hexidecimal PCI
device ids.

=09Jeff




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

------_=_NextPart_001_01C6FD9D.10351682
Content-Type: application/octet-stream;
	name="patch.sata_nv"
Content-Transfer-Encoding: base64
Content-Description: patch.sata_nv
Content-Disposition: attachment;
	filename="patch.sata_nv"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0MS9kcml2ZXJzL2F0YS9zYXRhX252LmMub3JpZwkyMDA2
LTEwLTMxIDIwOjQ0OjQ1LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5LXJjNC1naXQx
L2RyaXZlcnMvYXRhL3NhdGFfbnYuYwkyMDA2LTExLTAxIDAzOjAxOjI1LjAwMDAwMDAwMCArMDgw
MApAQCAtMTE3LDEwICsxMTcsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
IG52X3BjaQogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9S
Q0VfTUNQNjFfU0FUQSksIEdFTkVSSUMgfSwKIAl7IFBDSV9WREVWSUNFKE5WSURJQSwgUENJX0RF
VklDRV9JRF9OVklESUFfTkZPUkNFX01DUDYxX1NBVEEyKSwgR0VORVJJQyB9LAogCXsgUENJX1ZE
RVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNjFfU0FUQTMpLCBH
RU5FUklDIH0sCi0JeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1YyksIEdFTkVSSUMgfSwKLQl7
IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNDVkKSwgR0VORVJJQyB9LAotCXsgUENJX1ZERVZJQ0Uo
TlZJRElBLCAweDA0NWUpLCBHRU5FUklDIH0sCi0JeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1
ZiksIEdFTkVSSUMgfSwKKwl7IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNDVjKSwgR0VORVJJQyB9
LCAvKiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWQpLCBHRU5FUklDIH0s
IC8qIE1DUDY1ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1ZSksIEdFTkVSSUMgfSwg
LyogTUNQNjUgKi8KKwl7IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNDVmKSwgR0VORVJJQyB9LCAv
KiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTApLCBHRU5FUklDIH0sIC8q
IE1DUDY3ICovCisJeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MSksIEdFTkVSSUMgfSwgLyog
TUNQNjcgKi8KKwl7IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNTUyKSwgR0VORVJJQyB9LCAvKiBN
Q1A2NyAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTMpLCBHRU5FUklDIH0sIC8qIE1D
UDY3ICovCiAJeyBQQ0lfVkVORE9SX0lEX05WSURJQSwgUENJX0FOWV9JRCwKIAkJUENJX0FOWV9J
RCwgUENJX0FOWV9JRCwKIAkJUENJX0NMQVNTX1NUT1JBR0VfSURFPDw4LCAweGZmZmYwMCwgR0VO
RVJJQyB9LAo=

------_=_NextPart_001_01C6FD9D.10351682--
