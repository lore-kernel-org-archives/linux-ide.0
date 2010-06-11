From: Ben Hutchings <ben@decadent.org.uk>
Subject: More ata_piix spurious IRQs
Date: Sat, 12 Jun 2010 00:13:26 +0100
Message-ID: <1276298006.14011.149.camel@localhost>
References: <20100611222746.37b5efa6@server.gazypan.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DmDpSE5rv2M1vWM5N6+3"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52735 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518Ab0FKXNl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jun 2010 19:13:41 -0400
In-Reply-To: <20100611222746.37b5efa6@server.gazypan.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jeanseb <jeanseb.valette@free.fr>, 585556@bugs.debian.org, linux-ide@vger.kernel.org


--=-DmDpSE5rv2M1vWM5N6+3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

jeanseb reported this problem with a PATA PIIX controller:

> [    1.324685] irq 5: nobody cared (try booting with the "irqpoll" option=
)
> [    1.324730] Pid: 194, comm: scsi_eh_0 Not tainted 2.6.32-5-amd64 #1
> [    1.324732] Call Trace:
> [    1.324734]  <IRQ>  [<ffffffff810952cd>] ? __report_bad_irq+0x30/0x7d
> [    1.324745]  [<ffffffff8109541f>] ? note_interrupt+0x105/0x16e
> [    1.324749]  [<ffffffff81095b26>] ? handle_level_irq+0x80/0xc3
> [    1.324753]  [<ffffffff81013957>] ? handle_irq+0x17/0x1d
> [    1.324756]  [<ffffffff81012fb1>] ? do_IRQ+0x57/0xb6
> [    1.324759]  [<ffffffff810114d3>] ? ret_from_intr+0x0/0x11
> [    1.324762]  [<ffffffff81014fa3>] ? mask_and_ack_8259A+0x0/0xca
> [    1.324767]  [<ffffffff81053967>] ? __do_softirq+0x6e/0x19f
> [    1.324770]  [<ffffffff81011cac>] ? call_softirq+0x1c/0x30
> [    1.324773]  [<ffffffff81013903>] ? do_softirq+0x3f/0x7c
> [    1.324776]  [<ffffffff81053845>] ? irq_exit+0x36/0x76
> [    1.324779]  [<ffffffff81012ffa>] ? do_IRQ+0xa0/0xb6
> [    1.324782]  [<ffffffff810114d3>] ? ret_from_intr+0x0/0x11
> [    1.324784]  <EOI>  [<ffffffff812fa7f5>] ? _spin_unlock_irqrestore+0x8=
/0xe
> [    1.324798]  [<ffffffffa006bb64>] ? ata_exec_internal_sg+0x239/0x45b [=
libata]
> [    1.324802]  [<ffffffff8105a549>] ? del_timer_sync+0xc/0x16
> [    1.324807]  [<ffffffff811946c9>] ? delay_tsc+0x30/0x73
> [    1.324813]  [<ffffffffa006be09>] ? ata_exec_internal+0x83/0x92 [libat=
a]
> [    1.324820]  [<ffffffffa007732c>] ? ata_sff_check_status+0x10/0x13 [li=
bata]
> [    1.324827]  [<ffffffffa006c0d2>] ? ata_do_dev_read_id+0x21/0x23 [liba=
ta]
> [    1.324833]  [<ffffffffa006c1c8>] ? ata_dev_read_id+0xf4/0x3c2 [libata=
]
> [    1.324839]  [<ffffffffa007783c>] ? ata_sff_postreset+0x0/0x73 [libata=
]
> [    1.324846]  [<ffffffffa0074e1d>] ? ata_eh_schedule_probe+0xb3/0xe0 [l=
ibata]
> [    1.324852]  [<ffffffffa0075520>] ? ata_eh_recover+0x6d6/0xc2a [libata=
]
> [    1.324856]  [<ffffffff8103fe62>] ? update_curr+0xa6/0x147
> [    1.324862]  [<ffffffffa007783c>] ? ata_sff_postreset+0x0/0x73 [libata=
]
> [    1.324868]  [<ffffffffa007921c>] ? ata_sff_softreset+0x0/0x130 [libat=
a]
> [    1.324873]  [<ffffffffa00d3578>] ? piix_pata_prereset+0x0/0x51 [ata_p=
iix]
> [    1.324879]  [<ffffffffa007921c>] ? ata_sff_softreset+0x0/0x130 [libat=
a]
> [    1.324885]  [<ffffffffa007783c>] ? ata_sff_postreset+0x0/0x73 [libata=
]
> [    1.324890]  [<ffffffffa007921c>] ? ata_sff_softreset+0x0/0x130 [libat=
a]
> [    1.324894]  [<ffffffffa00d3578>] ? piix_pata_prereset+0x0/0x51 [ata_p=
iix]
> [    1.324901]  [<ffffffffa0075bfc>] ? ata_do_eh+0x3b/0x82 [libata]
> [    1.324907]  [<ffffffffa007652b>] ? ata_scsi_error+0x342/0x67a [libata=
]
> [    1.324911]  [<ffffffff81047f57>] ? finish_task_switch+0x3a/0xa7
> [    1.324919]  [<ffffffffa00049dc>] ? scsi_error_handler+0x0/0x5b5 [scsi=
_mod]
> [    1.324925]  [<ffffffffa0004aea>] ? scsi_error_handler+0x10e/0x5b5 [sc=
si_mod]
> [    1.324931]  [<ffffffffa00049dc>] ? scsi_error_handler+0x0/0x5b5 [scsi=
_mod]
> [    1.324934]  [<ffffffff8106482d>] ? kthread+0x79/0x81
> [    1.324937]  [<ffffffff81011baa>] ? child_rip+0xa/0x20
> [    1.324940]  [<ffffffff810647b4>] ? kthread+0x0/0x81
> [    1.324943]  [<ffffffff81011ba0>] ? child_rip+0x0/0x20
> [    1.324944] handlers:
> [    1.324977] [<ffffffffa00d384e>] (piix_interrupt+0x0/0x192 [ata_piix])
> [    1.325076] Disabling IRQ #5
> [    1.347126] ata1.00: ATAPI: DVD-RW IDE1108, VER B018, max UDMA/66
> [    1.347150] ata1.00: limited to UDMA/33 due to 40-wire cable

(more details at <http://bugs.debian.org/585556>).

This is in Debian kernel version 2.6.32-15 which is based on stable
version 2.6.32.14 but has your backported spurious IRQ handling patch
taken from SLE11 (References: bnc#445872, bnc#589449).  Any idea what's
going wrong here?  Is there a piece missing from that fix?

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-DmDpSE5rv2M1vWM5N6+3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATBLDDOe/yOyVhhEJAQIuvg//Z/PhWHH9N8IuGYNtj4Ny6V46VOV8lhbl
vO4xwQkU+jLEuUizVfgJkBQx9jznqfs0NGPwozuE56ZgSaam7gES/wuw4s+UJreB
NezzWTOk3+STxeHtF7EtWAMGGy1ykxn6WMsgfUkCnQknH0q/pDOQZoYuhzyE2dtF
9Ss872qj1g8JabrDz/ZCqsmawHnSu42ZCDTWE0dh8dogQoWTqGiduJt0VTH9rdbo
YtqbPB2DnVKuHV+ciLkQPEz1VOTfTt3Qv7dLLC5vkbRJ5Fq+EPUbgq4B4lNPwVO6
FoYw79TSO4PaOJvyFD4NNWvHYzPuQfxQc5ttcTUfbB7nGtmJdudbcLqAK8iyiVoL
fW4GF0apuVN8x31hxyGsn6iayqKP5XQiehmAfq+oiyBhsqwIW84flEEoaVOClsrB
WN/o+821KKTraYbFQurJbcD1r5dwKA6XJOuz19zlhP1Dj0YnZ2YRYsWhoYZ6KqeV
9v/iN4oyAXdlO1wSFMM4JYzavEnlftClE5cts/9kOxhO59drW28SgrTOlgOTbGA6
r+/SqDhw8vLlDu5bGxuDE4tUeaPSeKu2nzNOLn/oMdgrmFAjJqqbAvtvmm1qMoIW
xViQHyuF9jKxrcICzi+f7jV8jprsmXuMA541Kfe6WL48nZ0fwwb7n6b7sLkEAJb1
g+iyiNAEsOA=
=rtod
-----END PGP SIGNATURE-----

--=-DmDpSE5rv2M1vWM5N6+3--
