From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 6 Aug 2007 17:32:02 +0200
Message-ID: <200708061732.03425.rjw@sisk.pl>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com> <1186411815.4355.7.camel@nx6310> <20070806150159.GC31615@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070806150159.GC31615@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Michael Sedkowski <sedmich@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday, 6 August 2007 17:01, Henrique de Moraes Holschuh wrote:
> On Mon, 06 Aug 2007, Michael Sedkowski wrote:
> > Dnia 06-08-2007, Pn o godzinie 11:23 -0300, Henrique de Moraes Holschuh
> > napisa??(a):
> > > On Mon, 06 Aug 2007, Tejun Heo wrote:
> > > > Cc'ing Henrique.  Any ideas?
> > > 
> > > Check if /etc/init.d/halt is calling halt(8) with the -h flag.  If it is,
> > > remove that -h flag.  Usually, there is a hddown variable that holds it, you
> > > just need to get rid of it.
> > > 
> > > I don't know anything about a Sidux, though.
> > 
> > Well there is an -h variable:
> > # Don't shut down drives if we're using RAID.
> > 	hddown="-h"
> > 	if grep -qs '^md.*active' /proc/mdstat
> > 	then
> > 		hddown=""
> > 	fi
> > ....
> > log_action_msg "Will now halt"
> > 	halt -d -f $netdown $poweroff $hddown
> > However removing it has no effect, the drive still spins down two times.
> 
> Nothing in Debian userspace will spin down the drive if you kill that -h, at
> least as far as I know.
> 
> > Sidux is a Debian Unstable based distro with it's own set of patches
> > including the shut down patch provided here:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=426224
> 
> You'll probably have to ask Sidux what changes they made that could cause
> the double spin down, even if halt(8) is never passed the -h flag.

Well, I've been observing the same behavior on nx6325 for some time and I
use openSUSE 10.2.  I think this is kernel-related.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
