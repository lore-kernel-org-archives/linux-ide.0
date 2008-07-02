From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.25 to 2.6.26-rc8 regression  (related to ahci and acpi _GTF)
Date: Wed, 02 Jul 2008 11:55:37 +0900
Message-ID: <486AEE29.2010506@gmail.com>
References: <4869FB3C.4060509@crans.org> <200807011614.21491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200807011614.21491.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>, linux-ide@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> [Adding CCs.]
>=20
> On Tuesday, 1 of July 2008, Mathieu B=E9rard wrote:
>> Hi,
>> I have a laptop with an ICH6M SATA Controller and a Hitachi hard dri=
ve.
>> While it worked well using the ahci module and Linux 2.6.25,=20
>> it get randomly 'stuck' for several seconds to several minutes with =
2.6.26-rc8.
>> Successive errors progressively reduce the ATA link speed.
>>
>> Passing the libata.noacpi parameter is an effective workaround.
>>
>> Please note that it's not the first time i have this kind of issue, =
see:
>> http://marc.info/?l=3Dlinux-ide&m=3D117305595312399&w=3D2
>> This was found to be a bad interaction between my _GTF taskfile, whi=
ch enable the
>> "Enable Device-Initiated Interface Power State Transitions" feature,=
 and NCQ.
>> The driver was later NCQ blacklisted to correct the problem.

Can you please post the result of "hdparm -I /dev/sda" and full kernel
boot log?  0xca is not a NCQ command so the it's not related to NCQ at
all.  It seems we'll need to filter out DIPM commands from _GTF.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
