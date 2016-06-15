From: Kevin Brubeck Unhammer <unhammer@fsfe.org>
Subject: Re: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Wed, 15 Jun 2016 10:26:20 +0200
Message-ID: <87eg7yluxf.fsf@mm.st>
References: <87vb1mwz73.fsf@fsfe.org>
	<CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
	<20160606135422.GU31708@htj.duckdns.org> <87porue7n6.fsf@mm.st>
	<20160607141142.GV31708@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51667 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889AbcFOI03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2016 04:26:29 -0400
In-Reply-To: <20160607141142.GV31708@htj.duckdns.org> (Tejun Heo's message of
	"Tue, 7 Jun 2016 09:11:42 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Navin P.S" <navinp1912@gmail.com>, linux-ide@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tejun Heo <tj@kernel.org> =C4=8D=C3=A1lii:

> On Mon, Jun 06, 2016 at 04:03:57PM +0200, Kevin Brubeck Unhammer wrote:
>> dmesg from 4.2 is attached; from 4.6 I'm not sure how to get it =E2=80=A6
>>=20
>> perhaps I could mount a USB-stick through a
>> /etc/initramfs-tools/scripts/init-premount/ script, I'll try this later
>> (I'm travelling this week, so might be a bit delayed).
>
> You can also use serial or netconsole.
>
> Thanks.

I'm still working on getting the full dmesg text :-/

There's no /dev/sd[abcd] when I have a USB-stick in there, so I don't
know how I would mount that (and from 4.7 initramfs script a
"dmesg|grep /dev/sd[abcd]" gives nothing).


I got netconsole working from the booted 4.2, but when I try from the
4.7 initramfs script it can't find eth0 even though I have r8169 in modules.

It seems r8169 is the right driver since 4.2 shows=20

$ grep DRIVER /sys/class/net/*/device/uevent
/sys/class/net/eth0/device/uevent:DRIVER=3Dr8169
/sys/class/net/wlan0/device/uevent:DRIVER=3Drtl8723au


I tried

/etc/initramfs-tools/modules:
r8169
ahci
libahci
uhci_hcd
ehci_hcd
usb_storage
configfs
netconsole

/etc/initramfs-tools/scripts/init-premount/kbu-blkid:
echo 'cat /proc/scsi/scsi # gives:'
      cat /proc/scsi/scsi
echo 'dmesg | grep -i libata # gives:'
      dmesg | grep -i libata
echo 'grep -i ahci /proc/modules # gives:'
      grep -i ahci /proc/modules=20
echo 'modprobe ahci # gives:'
      modprobe ahci
echo 'grep -i ahci /proc/modules # gives:'
      grep -i ahci /proc/modules=20
dmesg |grep -i eth
mount none -t configfs /sys/kernel/config
mkdir /sys/kernel/config/netconsole/target1
cd /sys/kernel/config/netconsole/target1
echo 0 >enabled
echo 192.168.1.117 > local_ip
echo 192.168.1.2 >remote_ip
echo eth0 >dev_name
echo 68:05:CA:29:E4:7F >remote_mac
echo 6666 > remote_port
echo 1 >enabled
echo kbu-testing >/dev/kmsg
echo 'dmesg | tail'
      dmesg | tail
echo "/KBU"

and got

http://bildr.no/image/dXFjbkEw.jpeg
http://bildr.no/image/MUpqLzZx.jpeg


I guess I'll have to start shopping for (two) USB-to-serial cables.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXYREsAAoJEPw8Hn0AkxZnNyoP/0cW6y0K+6zpCpSeWTBrtT9M
iKRL+DKSAcz4hjy/+G+98CDKqTYgFVe8u2l5+MVbPUCFq8+CIUCkcZDS+Y1d6FAm
QU8gRcdyrGUd8M6d8XP8oxdisqm41QQIXYnYbcHtB22vJCKBhZp4/HpKtm8Oi2t5
OiD25jna5ZvDgBMtVluz2DNFGaCykXsx0gRKxN90VmUqpOHq/lRz+8h34VSP7d28
SPRKPA1jcp3YqKY48IvMCJGmq7XzdyciCEKKo+5WQfQzfTwCltrIl9awd+7DyWUn
K1DGCNBxV4a7+vzDxyg6I3KUqLPYR5HxcoverM4LNAHm86VnbMAB2BvOMGOm7lgu
2j7lV54CAmv6RsxYjTQQd2Gu7nntVdenKp3Xl8Fk0cYzBwiOcoNRj6Sj+zC89Zvp
dglui0Xrocb3gpw8ZXmviKJYrUCEMaLuR1WTcd7tmJ44ujF0NAnwcEUFikDxlyha
OZkpiOv8RnanGpwu8gOFSHSOBqDd5NV/fsYrUvxWltC548F14+LcyM6aFptvIuli
fxq//AJxFBFxFQMMYiJ1vTgkba240VkQiP9V0cJtnVY0UL0BwqZz/6YLKVpONf51
GBa2ld7n/ZHAfHq0cMGVzkTiiHa9bT092wKlbYah6HHX82fcb2PCOMDWQs//YNM5
lxD7dHFTz9NtFb50XAQB
=MwEg
-----END PGP SIGNATURE-----
--=-=-=--
