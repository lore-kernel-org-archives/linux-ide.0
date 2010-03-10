From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 10:14:07 +0100
Message-ID: <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201003100046.24695.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 10, 2010 at 12:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 March 2010 04:48:35 Tejun Heo wrote:
>> Unfortunately, while Windows can assume that newer releases won't
>> share the hard drive with older releases including Windows XP, Linux
>> distros can't do that. =A0There will be many installations where a
>> modern Linux distros share a hard drive with older releases of
>> Windows. =A0At this point, I can't see a silver bullet solution.
>>
>> Partitioners maybe should only align partitions which will be used b=
y
>> Linux and default to the traditional layout for others while allowin=
g
>> explicit override. =A0I think Windows XP wouldn't have problem with
>> differently aligned partitions as long as it doesn't actually use th=
em
>> but haven't tested it.
>
> Any idea if XP can cope with partition tables that use a 32-sector, 1=
28-head
> geometry rather than the default 63-sector, 255-head one? That seems =
to
> be what some flash memory cards are using and it would make any cylin=
der
> aligned partition also 4096-byte aligned, at the cost of moving the
> 1024-cylinder boundary from 7.88 GiB to 2 GiB.
>
> Do we know of anything that requires 63s/255h?

63s/255h is more or less "standard" now.

Alignment issues can be solved by picking a good multiple of
_heads_ or _cylinders_:

=46or first partition, pick the start at 8th head:

cyl 0 head 1 sector 1: LBA sector 63) - bad
cyl 0 head 8 sector 1: LBA sector 8*63) - good (4k aligned)

=46or any other partition, pick start cylinder which is a multiple of 8=
:

cyl 8*x head 0 sector 1: LBA sector 8*x*255*63 - good (4k aligned)

This will actually work well for *any* geometry, not only for 63s/255h.
--=20
vda
