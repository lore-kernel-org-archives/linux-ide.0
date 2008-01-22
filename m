From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 0/12] ide-floppy redux v2.5
Date: Tue, 22 Jan 2008 06:32:31 +0100
Message-ID: <20080122053231.GA20570@gollum.tnic>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <200801142238.17282.bzolnier@gmail.com> <20080120123815.GA20082@gollum.tnic> <200801212345.35762.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:30210 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751146AbYAVFcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 00:32:46 -0500
Content-Disposition: inline
In-Reply-To: <200801212345.35762.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 21, 2008 at 11:45:35PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi Borislav,
>=20
> On Sunday 20 January 2008, Borislav Petkov wrote:
> > On Mon, Jan 14, 2008 at 10:38:17PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > > By the way, I have an Iomega ZIP 100 drive somewhere in my hard=
ware pile and
> > > > will do some testing with the "new" :) driver just in case.
> > >=20
> > > This would be great. :)
> > Hi Bart,
> >=20
> > i just whipped rc8 along with your pata-2.6 tree on top and had sev=
eral test
> > runs of the ide-floppy driver (raw reads, software floppy disk ejec=
t, etc) and
> > everything seems to work fine. I will keep this hardware setup here=
 so that we
> > could at least test ide-floppy occasionally. We should probably ack=
nowledge this
>=20
> Big thanks for all great ide-floppy work!  I hope that you'll continu=
e with
> putting IDE device drivers in shape. :)

Sure, no problem :). I'm on ide-tape right now and probably will have m=
ost of it
ready for submission on the weekend so keep your fingers crossed... :)

--=20
Regards/Gru=DF,
    Boris.
