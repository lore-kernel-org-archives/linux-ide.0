From: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume.laures@club-internet.fr>
Subject: Re: sata disk failure?
Date: Wed, 16 Feb 2005 15:30:08 +0100
Message-ID: <c80c650eb1c3862f79f3048edb2bcc1e@club-internet.fr>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com> <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr> <42122859.9060609@pobox.com> <8a8e3658e83b16145dc64b4efa140f9f@club-internet.fr> <421342FE.5020800@zsolt.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--739494439"
Content-Transfer-Encoding: 7bit
In-Reply-To: <421342FE.5020800@zsolt.net>
Resent-Message-ID: <SJVv1C.A.Ga.Wk1ECB@murphy>
List-Post: <mailto:debian-amd64@lists.debian.org>
List-Help: <mailto:debian-amd64-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-amd64-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-amd64-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-amd64/>
To: debian-amd64@lists.debian.org, linux-ide@vger.kernel.org
Cc: Zsolt KOZAK <zsolt@zsolt.net>, Manuele Rampazzo <manu@linux.it>
List-Id: linux-ide@vger.kernel.org


--Apple-Mail-3--739494439
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed

Hi Zsolt and others following this thread,

For now I have no solution... exept the trick I tell below. So the =20
problem is stil there, but there is some progress too. I hope this will =20=

help the developpers to narrow the problem down.

I noticed something stange. If I manage to mount my sata drive and use =20=

it fast enough (that is, before the bunch of "device removed" happens), =20=

I can use the disk without any problem !
As soon as the drive is idle for some 20-30s, the error comes back and =20=

I can't use the drive anymore.

During my first test I managed to copy over 3Gigs of .ogg files (823 =20
files total) off of the sata drive to a pata one, and the sata disk =20
went out _after_ the rsync was finished. Not sure about how much time =20=

after however.
After a reboot I was able to copy 5-6 gigs of .nuv mpeg2 files (yeah =20
this is a mythtv box...) and copy them back to a newly formatted =20
partition on the sata drive before it went out, again _after_ some idle =20=

time (_not_ during the test which lasted at least 10-15 mins).
Those tests were done on 2.6.10, I can try do do them again with =20
2.6.11-rc4 if needed.

Does it help to narrow the problem down ? I think is some developpers =20=

helps me to put some debugging information into the sata_nv.ko we may =20=

be able to figure out what's wrong. I'm gom on #debian-amd64@freenode.

Another strange thing is that my last partition on the sata drive =20
(170gigs) was almost full when it was used in my previous mythtv =20
machine (kernel 2.4 with some sort of pata emulation, not on nforce3 =20
but on intel hardware) and now the partition has 74Gigs of empty space. =20=

I wonder if there is some 138G barrier as Manuele tells.

Later,

GoM

Le 16 f=C3=A9vr. 05, =C3=A0 13:56, Zsolt KOZAK a =C3=A9crit :

> Hi Guillaume,
>
> I've just noticed your problem on debian-amd64 list. I've just =20
> installed a new Debian system and I've run into this problem also.... =20=

> Nforce3 motherboard, SATA discs (2 200G Seagate).
> Hvae you got any solution? Or do you have still the problem? What =20
> about driver developers? I noticed you cc-ed them into your messages.
>
> best regards,
> Zsolt
>
> On 2005-02-15 23:38, Guillaume Laur=C4=8Ds wrote:
>
>> Thanks for your help Jeff.
>>
>> During my experiments I plugged an unpluged the drive numerous times. =
=20
>> I  also tried another SATA cable, but same thing. Even on the other  =20=

>> motherboard SATA plug. I closely examined the drive and it seems =20
>> right.  like new in fact. The motherboard is even newer, and so is =20=

>> the cable.
>>
>> Is your idea consistent with the fact that the drive is _alays_  =20
>> recognized in the bios, and _always_ recognized in linux ? All the =20=

>> time  it fails with the messages "nv_sata: Primary/Secondary device =20=

>> removed"  a few seconds after the console promt is displayed. =20
>> Sometimes I have  the time to mount the drive, sometimes not even.
>>
>> Later,
>>
>> GoM
>>
>> Le 15 f=C3=A9vr. 05, =C5=95 17:50, Jeff Garzik a =C3=A9crit :
>>
>>> Guillaume Laur=C4=8Ds wrote:
>>>
>>>> Hello,
>>>> Here is a small report in attachement, done with 2.6.11-rc4.
>>>> =
--------------------------------------------------------------------=20
>>>> -- --
>>>>  * Hardware is nforce3 250GB, booting debian pure64 on pata (Maxtor =
=20
>>>>  30Gb 6E030L0) drive. The goal is to mount data found on a sata =20
>>>> disk  (seagate 200Gb ST3200822AS). The pata drive holds / and lvm =20=

>>>> partition  with /usr, /var /tmp and /home.
>>>> The ultimate goal is to switch all this to the sata drive, which  =20=

>>>> already holds a (barely used) swap partition.
>>>>  * Soon after boot the console displays:
>>>> nv_sata: Primary device removed
>>>> nv_sata: Primary device removed
>>>> nv_sata: Primary device removed
>>>> nv_sata: Primary device removed
>>>> ...
>>>
>>>
>
>
> --=20
> Zsolt KOZAK      zsolt@zso.lt
> personal web:    http://zso.lt
> Road To Avonlea: http://www.avonlea.hu
>
>
> --=20
> To UNSUBSCRIBE, email to debian-amd64-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact =20
> listmaster@lists.debian.org
>

--Apple-Mail-3--739494439
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: =?ISO-8859-1?Q?Ceci_est_une_signature_=E9lectronique_PGP?=
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFCE1jwxnIJde5abSkRAn3WAJ9oqT8K37f44IM6amTOzzN5R+GG3gCgkt0z
omzucpYsGHPnuMbDnNhT5w4=
=xNXd
-----END PGP SIGNATURE-----

--Apple-Mail-3--739494439--
