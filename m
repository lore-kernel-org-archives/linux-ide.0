From: Jeff Garzik <jeff@garzik.org>
Subject: Re: DRDY errors again
Date: Tue, 08 Apr 2008 11:59:51 -0400
Message-ID: <47FB9677.30109@garzik.org>
References: <20080408171311.69441c8b@werewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48721 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668AbYDHP7y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2008 11:59:54 -0400
In-Reply-To: <20080408171311.69441c8b@werewolf>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

J.A. Magall=F3n wrote:
> scsi4 : ata_piix
> scsi5 : ata_piix
> ata3: SATA max UDMA/133 cmd 0xc000 ctl 0xc400 bmdma 0xd000 irq 18
> ata4: SATA max UDMA/133 cmd 0xc800 ctl 0xcc00 bmdma 0xd008 irq 18

> ata4.00: ATA-8: ST3500820AS, SD25, max UDMA/133
> ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
> ata4.00: configured for UDMA/133

> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata4.00: cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0
>          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4.00: status: { DRDY }

Can you bisect to see when this problem starts?  I'm pretty sure it's=20
software, either interrupt-related or the libata driver itself.

See http://ata.wiki.kernel.org/index.php/Libata_error_messages for a=20
full explanation of that error message.

Most notable:  "DRDY" =3D=3D device ready =3D=3D device says everything=
 is OK,=20
from it's perspective.  "timeout" usually means an interrupt wasn't=20
delivered from your ATA controller, when we were expecting one.

	Jeff


