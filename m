From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Slow disks.
Date: Sun, 26 Dec 2010 18:17:40 -0500
Message-ID: <AANLkTinKgW_Jpph5NtstCJxA6ZhuTgEc+Juc8YrvE7CE@mail.gmail.com>
References: <20101220141553.GA6088@bitwizard.nl> <20101220190630.66084e1d@neptune.home>
 <AANLkTi=VAJbVSzX_DH9_==a3RonLJmawYu3MzF-uqGXC@mail.gmail.com>
 <20101222104306.GB30941@bitwizard.nl> <m3aajvz5na.fsf@intrepid.localdomain>
 <4D14BB36.1030304@msgid.tls.msk.ru> <20101225121407.GA2116@bitwizard.nl> <20101226214037.GB18227@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101226214037.GB18227@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Krzysztof Halasa <khc@pm.waw.pl>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Dec 26, 2010 at 4:40 PM, Rogier Wolff <R.E.Wolff@bitwizard.nl> =
wrote:
> On Sat, Dec 25, 2010 at 01:14:07PM +0100, Rogier Wolff wrote:
>> Out of four partitions on the drive, two are aligned, two are not.
>
> Ooops. I looked wrong. Sorry. All four partitions are mis aligned.
>
> =A0 =A0 =A0 =A0Roger.

It sounds like you have 3 or 4 separate issues that are each costing
you a factor of 3 or so of pain.

3 * 3 * 3 *3 =3D 81  ( I don't recall how bad your overall problem was)=
=2E

I can remember:

Raid 5 - poor choice for 4KB random writes - a factor of 2-4
Misaligned 4KB physical sectors - a factor of 2+
Excessive Head Parking  (You show 100K plus head parks in your smart
data) - (who knows.  It takes a while to un-park the heads and your
heads are parking way too often.)

I think you said it was a 8TB, I know its a pain, but I'd rebuild.  I
don't know how reliable various large drives are currently.  in
2008/2009 they seemed to be horrible and the advice was to use drives
from different vendors, etc so you would be less likely to have a
batch of drives go bad all at once.

Good Luck
Greg
