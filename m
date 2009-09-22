From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: libATA SATA errors on DVD bad sectors...
Date: Tue, 22 Sep 2009 10:42:30 -0700
Message-ID: <55a4f86e0909221042h37977c59y4b137380b3d2a1b3@mail.gmail.com>
References: <55a4f86e0909212101s3097a1e3yf225f3e165ff0bea@mail.gmail.com>
	 <19128.52482.184096.558888@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756900AbZIVRmc@vger.kernel.org>
In-Reply-To: <19128.52482.184096.558888@pilspetsen.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Later you write that ata12 connects to a Promise SATA300 TX4.
> In that case, port_status 0x20280000 means:
> - Overrun Error
> - Drive Error
> - Packet Command Cycle
> which means that the drive set its error status flag and raised an in=
terrupt which prematurely terminated a data transfer.

Yes, the code in question is here:
http://lxr.linux.no/linux+v2.6.31/drivers/ata/sata_promise.c#L748

> The obvious next experiment would be to swap the drives and see how t=
he Lite-On behaves on the ICH9 and the LG behaves on the TX4.

Yup, did that earlier this morning.  The controller is the cause, not
the drives. (ie. getting the same error on ata12 even though it's now
the LG, the LiteOn on AHCI is now kernel error message free, still
giving IO errors of course)

> =C2=A0> Would it make sense to add this somewhere into the code as a =
'bad sector' error condition and not perform a hard reset?
>
> The sata_promise driver upon seeing the port_status above sets AC_ERR=
_HSM and AC_ERR_DEV, and performs a soft reset. Apparently libata-eh fo=
llows up with a hard(er) reset, which doesn't surprise me given the HSM=
 and DEV errors.

> So things actually work Ok with the Lite-On on the TX4, and you're ma=
inly concerned about log messages and potential performance loss?

Yes, putting the LiteOn on the AHCI controller seems to speed stuff up
a fair bit (some 20-25% or so).
OTOH, I'd prefer to keep the blu-ray drive on AHCI, since the TX4
controller is just a measly PCI controller.

- Maciej
