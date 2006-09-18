From: Jack Bates <ms419@freezone.co.uk>
Subject: system hang: hdc: irq timeout: status=0xc0 { Busy }
Date: Sun, 17 Sep 2006 21:06:07 -0700
Message-ID: <1158552367.4388.60.camel@fis.lat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TEHEbwRhtE0GuC89EBqG"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from defout.telus.net ([199.185.220.240]:15870 "EHLO
	defout.telus.net") by vger.kernel.org with ESMTP id S1751494AbWIREGO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 00:06:14 -0400
Received: from priv-edtnaa04.telusplanet.net ([207.6.195.230])
          by priv-edtnes87.telusplanet.net
          (InterMail vM.7.05.01.01 201-2174-106-103-20060222) with ESMTP
          id <20060918040612.ZIRY24204.priv-edtnes87.telusplanet.net@priv-edtnaa04.telusplanet.net>
          for <linux-ide@vger.kernel.org>; Sun, 17 Sep 2006 22:06:12 -0600
Received: from tor.lat (d207-6-195-230.bchsia.telus.net [207.6.195.230])
	by priv-edtnaa04.telusplanet.net (BorderWare MXtreme Infinity Mail Firewall) with ESMTP id CFBRAQ1CK0
	for <linux-ide@vger.kernel.org>; Sun, 17 Sep 2006 22:06:11 -0600 (MDT)
Received: from fis.lat (fis.lat [192.168.179.246])
	by tor.lat (Postfix) with ESMTP id DA4FB12F36
	for <linux-ide@vger.kernel.org>; Sun, 17 Sep 2006 21:06:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-TEHEbwRhtE0GuC89EBqG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since upgrading to 2.6.18-rc6-mm1 from 2.6.13-rc6-mm2 my system started
hanging. I copied the below error from /var/log/messages.

When my system hangs, it is unresponsive for about 10 seconds, then
responsive for 1 second, unresponsive for 10 seconds, then responsive
for 1 second, etc. I need to reboot to use my system again.

I am not sleeping or waking, suspending or resuming my system. I am only
powering down to recover from this error. It happens roughly every 24
hours. I usually wake up to find my system hung, reboot, use it in the
morning and again in the evening without problem, but wake to find it
hung again next morning.

/dev/hdc is my PowerBook's cd/dvd-rom drive. I don't have a disc in the
drive when the error occurs, however I've checked the drive and I'm able
to read cds.

tj recommended using libata/PATA, however I can't find an
apple/uninorth/powermac PATA controller config option.

Any ideas what is causing this error, why the IDE error handler is
getting stuck in a loop, or how to use PATA on my PowerBook?

Much thanks - Jack

Sep 16 14:21:43 fis kernel: hdc: irq timeout: status=3D0xc0 { Busy }
Sep 16 14:21:43 fis kernel: ide: failed opcode was: unknown
Sep 16 14:22:25 fis kernel: hdc: status timeout: status=3D0xc0 { Busy }
Sep 16 14:22:25 fis kernel: ide: failed opcode was: unknown
Sep 16 14:22:25 fis kernel: Call Trace:
Sep 16 14:22:25 fis kernel: [D95656E0] [C00085A4] show_stack+0x3c/0x194
(unreliable)
Sep 16 14:22:25 fis kernel: [D9565710] [C005452C] softlockup_tick
+0x94/0xc4
Sep 16 14:22:25 fis kernel: [D9565730] [C0038554] run_local_timers
+0x18/0x28
Sep 16 14:22:25 fis kernel: [D9565740] [C0038594] update_process_times
+0x30/0x7c
Sep 16 14:22:25 fis kernel: [D9565750] [C000D30C] timer_interrupt
+0x110/0x584
Sep 16 14:22:25 fis kernel: [D95657D0] [C0010A64] ret_from_except
+0x0/0x14
Sep 16 14:22:30 fis kernel: --- Exception: 901 at ide_mm_inb+0x4/0x14
Sep 16 14:22:30 fis kernel:     LR =3D ide_wait_stat+0x144/0x1a0
Sep 16 14:22:30 fis kernel: [D9565890] [C0184AA0] elv_next_request
+0x70/0x1bc (unreliable)
Sep 16 14:22:30 fis kernel: [D95658C0] [C02189E4] ide_do_request
+0x3f0/0xbc0
Sep 16 14:22:30 fis kernel: [D9565940] [C0184CF8] elv_insert+0x10c/0x1f4
Sep 16 14:22:30 fis kernel: [D9565960] [C0219288] ide_do_drive_cmd
+0xd4/0x12c
Sep 16 14:22:30 fis kernel: [D9565990] [C0228CB0]
cdrom_queue_packet_command+0x48/0xe8
Sep 16 14:22:30 fis kernel: [D95659F0] [C0228FA4] cdrom_check_status
+0x70/0x84
Sep 16 14:22:30 fis kernel: [D9565AD0] [C022A3F0] cdrom_read_toc
+0x3c/0x4a4
Sep 16 14:22:30 fis kernel: [D9565B20] [C022B538] idecd_revalidate_disk
+0x1c/0x30
Sep 16 14:22:30 fis kernel: [D9565B70] [C00A56C0] check_disk_change
+0x80/0xc8
Sep 16 14:22:30 fis kernel: [D9565B90] [C0265C20] cdrom_open+0x1ac/0xadc
Sep 16 14:22:30 fis kernel: [D9565D20] [C0229CAC] idecd_open+0x80/0xf4
Sep 16 14:22:30 fis kernel: [D9565D40] [C00A5F84] do_open+0x8c/0x3ec
Sep 16 14:22:30 fis kernel: [D9565E80] [C00A651C] blkdev_open+0x34/0x94
Sep 16 14:22:30 fis kernel: [D9565EA0] [C0078860] __dentry_open
+0xcc/0x254
Sep 16 14:22:30 fis kernel: [D9565EC0] [C0078B2C] do_filp_open+0x5c/0x78
Sep 16 14:22:30 fis kernel: [D9565F20] [C0078BA0] do_sys_open+0x58/0xf8
Sep 16 14:22:30 fis kernel: [D9565F40] [C00103BC] ret_from_syscall
+0x0/0x38
Sep 16 14:22:30 fis kernel: --- Exception: c01 at 0xfed6c8c
Sep 16 14:22:30 fis kernel:     LR =3D 0xff68f54
Sep 16 14:22:30 fis kernel: hdc: status timeout: status=3D0xc0 { Busy }
Sep 16 14:22:30 fis kernel: ide: failed opcode was: unknown
Sep 16 14:22:30 fis kernel: hdc: status timeout: status=3D0xc0 { Busy }
Sep 16 14:22:30 fis kernel: ide: failed opcode was: unknown
Sep 16 14:22:30 fis kernel: hdc: status timeout: status=3D0xc0 { Busy }
Sep 16 14:22:30 fis kernel: ide: failed opcode was: unknown
[...]

--=-TEHEbwRhtE0GuC89EBqG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iGUEABECACUFAkUOGy8eGGhrcDovL2NnaS5zZnUuY2E6ODAvfmpkYmF0ZXMvAAoJ
EDQq9j8F5ZSERyMAmwZaTSnl6iMTTrpWNmnWeIIjTlDkAKCpVWveit9LwIFZ1AFZ
8z5+eOx8Eg==
=jd6b
-----END PGP SIGNATURE-----

--=-TEHEbwRhtE0GuC89EBqG--

