From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Wed, 02 Nov 2005 21:41:08 +0100
Message-ID: <43692464.2060109@gmx.de>
References: <Pine.LNX.4.44L0.0511021422450.5719-100000@iolanthe.rowland.org>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:22231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965229AbVKBUlO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 15:41:14 -0500
In-Reply-To: <Pine.LNX.4.44L0.0511021422450.5719-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

Alan Stern wrote:
> On Wed, 2 Nov 2005, thomas schorpp wrote:
>=20
>=20
>>Alan Stern wrote:
>=20
>=20
>>>Is there any standard way to pass ATA commands over a USB transport?=
  I've=20
>>>never heard of one.
>>>
>>>Alan Stern
>>>
>>>
>>
>>yes, ive read on the smartmontools page theres none, at present.
>>
>>since therere rw-commands issued, why not possible to issue other, to=
o?
>=20
>=20
> They aren't ATA read/write commands; they are SCSI commands.  If ther=
e is=20
> a version of SMART that runs over SCSI, you might be able to use it.
>=20
>=20
>>and sata is short of smart support. both use scsi-emu(?).
>>
>>i dont think theres a hardware problem.
>=20
>=20
> Yes there is.  The USB interface on the drive won't recognize an ATA =
SMART
> command and won't pass it on to the drive controller.

maybe yes,

(cant link) goto cypress, search part CY7C68300A, see the features and
application notes, the cypress windows driver can do Security since 200=
3.

"CY7C68300A Complies with T13's ATA/ATAPI-6 Draft Specification"

and see page 2 of the windos driver pdf doc:

Protect
The next selection, labeled =93Protect,=94 will give the user th
ability to password protect their HDD. There are three item
that must be true to enable password protection. These are
 1. The attached device must support the Security Mode Fea
    ture set as defined in the ATA/ATAPI specification. The
    support of Security is determined from an IDENTIFY DE
    VICE command (Word 128 bit 0).
 2. The attached device must be an ATA device.
 3. The bridge chip must support ATACB command. The
    ISD-300A1 and the ISD-200 parts are examples of such
    ICs.
 4. ATA Security must be enabled in the driver=92s .inf file.


>=20
>=20
>>i'll look at sata/libata/smartctl code and trial'n'error.
>>
>>maybe i find a way and you can propose it as standard then :)
>>why wait for it?
>=20
>=20
> Because if you don't wait, then no vendors will have implemented it a=
nd so=20
> it won't work.

i'll check the datasheet of the CY7C68300A

>=20
> Alan Stern
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

tom schorpp
