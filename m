From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 06 Aug 2007 16:50:15 +0200
Message-ID: <1186411815.4355.7.camel@nx6310>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>
	 <46B6B006.6000100@gmail.com> <20070806142339.GA31615@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070806142339.GA31615@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Dnia 06-08-2007, Pn o godzinie 11:23 -0300, Henrique de Moraes Holschuh
napisa=C5=82(a):
> On Mon, 06 Aug 2007, Tejun Heo wrote:
> > Cc'ing Henrique.  Any ideas?
>=20
> Check if /etc/init.d/halt is calling halt(8) with the -h flag.  If it=
 is,
> remove that -h flag.  Usually, there is a hddown variable that holds =
it, you
> just need to get rid of it.
>=20
> I don't know anything about a Sidux, though.

Well there is an -h variable:
# Don't shut down drives if we're using RAID.
	hddown=3D"-h"
	if grep -qs '^md.*active' /proc/mdstat
	then
		hddown=3D""
	fi
=2E...
log_action_msg "Will now halt"
	halt -d -f $netdown $poweroff $hddown
However removing it has no effect, the drive still spins down two times=
=2E

Sidux is a Debian Unstable based distro with it's own set of patches
including the shut down patch provided here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224

Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
