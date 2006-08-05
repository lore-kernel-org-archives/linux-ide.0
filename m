From: Martin =?ISO-8859-1?Q?Ammerm=FCller?= <tenco@gmx.de>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Sat, 05 Aug 2006 15:36:45 +0200
Message-ID: <1154785005.9220.1.camel@localhost>
References: <1151182247.5566.18.camel@localhost>
	 <449DFDC4.5050207@gmail.com> <1153729271.3860.14.camel@localhost>
	 <44CD1512.1060802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U33QZx/3WPpoyJd/Rnnv"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57732 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751067AbWHEOZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Aug 2006 10:25:33 -0400
In-Reply-To: <44CD1512.1060802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com


--=-U33QZx/3WPpoyJd/Rnnv
Content-Type: multipart/mixed; boundary="=-lcPNZjsWYxb423CE3y3s"


--=-lcPNZjsWYxb423CE3y3s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am Montag, den 31.07.2006, 05:22 +0900 schrieb Tejun Heo:=20
> Martin Ammerm=C3=BCller wrote:
> > With high disk I/O and a 2.6.18-rc1 kernel i get these errors (dependin=
g
> > upon the work i do, up to several times a day):
> >=20
> > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2 frozen
> > ata1.00: (BMDMA stat 0x20)
> > ata1.00: tag 0 cmd 0xc8 Emask 0x2 stat 0x58 err 0x0 (HSM violation)
>=20
> Hmm... Interesting.  It gets HSM violation first.
>=20
> > ata1: soft resetting port
> > ata1: port is slow to respond, please be patient
> > ata1: port failed to respond (30 secs)
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ATA: abnormal status 0xD8 on port 0xDCA18087
> > ATA: abnormal status 0xD8 on port 0xDCA18087
> > ATA: abnormal status 0xD8 on port 0xDCA18087
> > ATA: abnormal status 0xD8 on port 0xDCA18087
> > ATA: abnormal status 0xD8 on port 0xDCA18087
> > ata1.00: qc timeout (cmd 0xec)
> > ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> > ata1.00: revalidation failed (errno=3D-5)
> > ata1: failed to recover some devices, retrying in 5 secs
> > ata1: hard resetting port
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata1.00: configured for UDMA/100
> > ata1: EH complete
>=20
> Then two timeouts while recovering.
>=20
> > SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> > sda: Write Protect is off
> > sda: Mode Sense: 00 3a 00 00
> > SCSI device sda: drive cache: write back
> >=20
> >> Anyways, if your harddisk is doing this regularly,=20
> >> your hardware is faulty.  Maybe the connection between the controller=20
> >> and the disk is the problem or the disk itself.
> >=20
> > I did not get those errors with Windows XP and i am not the only one wh=
o
> > has problems running this particular laptop model with a linux kernel.
> > Ok, to be honest, there's actually only one person i know of which
> > bothered enough about exactly the same errors to send me an e-mail (he
> > discovered at least one of my messages to this list). But in my
> > experience there are almost always others getting the same error, but
> > which remain silent.
>=20
> It might be that the drive is quirky and raises interrupts prematurely=20
> sometimes.  Depending on how the driver performs recovery, the effect=20
> can be hidden from user.  Can you try the attached patch and see how the=20
> kernel acts?

I tried the patch, but i couldn't see any changes in kerneloutput. I
also noticed, that there are actually two slightly different
error-messages.

#1 (shorter one, without HSM violation):
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x21)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

#2 (longer, with HSM violation):
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x2 stat 0x58 err 0x0 (HSM violation)
ata1: soft resetting port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ATA: abnormal status 0xD8 on port 0xDCA44087
ATA: abnormal status 0xD8 on port 0xDCA44087
ATA: abnormal status 0xD8 on port 0xDCA44087
ATA: abnormal status 0xD8 on port 0xDCA44087
ATA: abnormal status 0xD8 on port 0xDCA44087
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: revalidation failed (errno=3D-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

Additionally, i attached the output of "smartctl --all -d ata /dev/sda"

Regards,
Martin Ammerm=C3=BCller

--=-lcPNZjsWYxb423CE3y3s
Content-Disposition: attachment; filename=smart_all
Content-Type: text/plain; name=smart_all; charset=utf-8
Content-Transfer-Encoding: base64

c21hcnRjdGwgdmVyc2lvbiA1LjM0IFtpNjg2LXBjLWxpbnV4LWdudV0gQ29weXJpZ2h0IChDKSAy
MDAyLTUgQnJ1Y2UgQWxsZW4NCkhvbWUgcGFnZSBpcyBodHRwOi8vc21hcnRtb250b29scy5zb3Vy
Y2Vmb3JnZS5uZXQvDQoNCj09PSBTVEFSVCBPRiBJTkZPUk1BVElPTiBTRUNUSU9OID09PQ0KRGV2
aWNlIE1vZGVsOiAgICAgVE9TSElCQSBNSzgwMzJHU1gNClNlcmlhbCBOdW1iZXI6ICAgIDI2R0k1
NTYwUw0KRmlybXdhcmUgVmVyc2lvbjogQVMxMTFHDQpVc2VyIENhcGFjaXR5OiAgICA4MC4wMjYu
MzYxLjg1NiBieXRlcw0KRGV2aWNlIGlzOiAgICAgICAgTm90IGluIHNtYXJ0Y3RsIGRhdGFiYXNl
IFtmb3IgZGV0YWlscyB1c2U6IC1QIHNob3dhbGxdDQpBVEEgVmVyc2lvbiBpczogICA2DQpBVEEg
U3RhbmRhcmQgaXM6ICBFeGFjdCBBVEEgc3BlY2lmaWNhdGlvbiBkcmFmdCB2ZXJzaW9uIG5vdCBp
bmRpY2F0ZWQNCkxvY2FsIFRpbWUgaXM6ICAgIFNhdCBBdWcgIDUgMTU6MzM6MTkgMjAwNiBDRVNU
DQpTTUFSVCBzdXBwb3J0IGlzOiBBdmFpbGFibGUgLSBkZXZpY2UgaGFzIFNNQVJUIGNhcGFiaWxp
dHkuDQpTTUFSVCBzdXBwb3J0IGlzOiBFbmFibGVkDQoNCj09PSBTVEFSVCBPRiBSRUFEIFNNQVJU
IERBVEEgU0VDVElPTiA9PT0NClNNQVJUIG92ZXJhbGwtaGVhbHRoIHNlbGYtYXNzZXNzbWVudCB0
ZXN0IHJlc3VsdDogUEFTU0VEDQoNCkdlbmVyYWwgU01BUlQgVmFsdWVzOg0KT2ZmbGluZSBkYXRh
IGNvbGxlY3Rpb24gc3RhdHVzOiAgKDB4MDApCU9mZmxpbmUgZGF0YSBjb2xsZWN0aW9uIGFjdGl2
aXR5DQoJCQkJCXdhcyBuZXZlciBzdGFydGVkLg0KCQkJCQlBdXRvIE9mZmxpbmUgRGF0YSBDb2xs
ZWN0aW9uOiBEaXNhYmxlZC4NClNlbGYtdGVzdCBleGVjdXRpb24gc3RhdHVzOiAgICAgICggICAw
KQlUaGUgcHJldmlvdXMgc2VsZi10ZXN0IHJvdXRpbmUgY29tcGxldGVkDQoJCQkJCXdpdGhvdXQg
ZXJyb3Igb3Igbm8gc2VsZi10ZXN0IGhhcyBldmVyIA0KCQkJCQliZWVuIHJ1bi4NClRvdGFsIHRp
bWUgdG8gY29tcGxldGUgT2ZmbGluZSANCmRhdGEgY29sbGVjdGlvbjogCQkgKCAzMzEpIHNlY29u
ZHMuDQpPZmZsaW5lIGRhdGEgY29sbGVjdGlvbg0KY2FwYWJpbGl0aWVzOiAJCQkgKDB4NWIpIFNN
QVJUIGV4ZWN1dGUgT2ZmbGluZSBpbW1lZGlhdGUuDQoJCQkJCUF1dG8gT2ZmbGluZSBkYXRhIGNv
bGxlY3Rpb24gb24vb2ZmIHN1cHBvcnQuDQoJCQkJCVN1c3BlbmQgT2ZmbGluZSBjb2xsZWN0aW9u
IHVwb24gbmV3DQoJCQkJCWNvbW1hbmQuDQoJCQkJCU9mZmxpbmUgc3VyZmFjZSBzY2FuIHN1cHBv
cnRlZC4NCgkJCQkJU2VsZi10ZXN0IHN1cHBvcnRlZC4NCgkJCQkJTm8gQ29udmV5YW5jZSBTZWxm
LXRlc3Qgc3VwcG9ydGVkLg0KCQkJCQlTZWxlY3RpdmUgU2VsZi10ZXN0IHN1cHBvcnRlZC4NClNN
QVJUIGNhcGFiaWxpdGllczogICAgICAgICAgICAoMHgwMDAzKQlTYXZlcyBTTUFSVCBkYXRhIGJl
Zm9yZSBlbnRlcmluZw0KCQkJCQlwb3dlci1zYXZpbmcgbW9kZS4NCgkJCQkJU3VwcG9ydHMgU01B
UlQgYXV0byBzYXZlIHRpbWVyLg0KRXJyb3IgbG9nZ2luZyBjYXBhYmlsaXR5OiAgICAgICAgKDB4
MDEpCUVycm9yIGxvZ2dpbmcgc3VwcG9ydGVkLg0KCQkJCQlHZW5lcmFsIFB1cnBvc2UgTG9nZ2lu
ZyBzdXBwb3J0ZWQuDQpTaG9ydCBzZWxmLXRlc3Qgcm91dGluZSANCnJlY29tbWVuZGVkIHBvbGxp
bmcgdGltZTogCSAoICAgMikgbWludXRlcy4NCkV4dGVuZGVkIHNlbGYtdGVzdCByb3V0aW5lDQpy
ZWNvbW1lbmRlZCBwb2xsaW5nIHRpbWU6IAkgKCAgNjUpIG1pbnV0ZXMuDQoNClNNQVJUIEF0dHJp
YnV0ZXMgRGF0YSBTdHJ1Y3R1cmUgcmV2aXNpb24gbnVtYmVyOiAxNg0KVmVuZG9yIFNwZWNpZmlj
IFNNQVJUIEF0dHJpYnV0ZXMgd2l0aCBUaHJlc2hvbGRzOg0KSUQjIEFUVFJJQlVURV9OQU1FICAg
ICAgICAgIEZMQUcgICAgIFZBTFVFIFdPUlNUIFRIUkVTSCBUWVBFICAgICAgVVBEQVRFRCAgV0hF
Tl9GQUlMRUQgUkFXX1ZBTFVFDQogIDEgUmF3X1JlYWRfRXJyb3JfUmF0ZSAgICAgMHgwMDBiICAg
MTAwICAgMTAwICAgMDUwICAgIFByZS1mYWlsICBBbHdheXMgICAgICAgLSAgICAgICAwDQogIDIg
VGhyb3VnaHB1dF9QZXJmb3JtYW5jZSAgMHgwMDA1ICAgMTAwICAgMTAwICAgMDUwICAgIFByZS1m
YWlsICBPZmZsaW5lICAgICAgLSAgICAgICAwDQogIDMgU3Bpbl9VcF9UaW1lICAgICAgICAgICAg
MHgwMDI3ICAgMTAwICAgMTAwICAgMDAxICAgIFByZS1mYWlsICBBbHdheXMgICAgICAgLSAgICAg
ICAyMTA0DQogIDQgU3RhcnRfU3RvcF9Db3VudCAgICAgICAgMHgwMDMyICAgMTAwICAgMTAwICAg
MDAwICAgIE9sZF9hZ2UgICBBbHdheXMgICAgICAgLSAgICAgICA0ODINCiAgNSBSZWFsbG9jYXRl
ZF9TZWN0b3JfQ3QgICAweDAwMzMgICAxMDAgICAxMDAgICAwNTAgICAgUHJlLWZhaWwgIEFsd2F5
cyAgICAgICAtICAgICAgIDANCiAgNyBTZWVrX0Vycm9yX1JhdGUgICAgICAgICAweDAwMGIgICAx
MDAgICAxMDAgICAwNTAgICAgUHJlLWZhaWwgIEFsd2F5cyAgICAgICAtICAgICAgIDANCiAgOCBT
ZWVrX1RpbWVfUGVyZm9ybWFuY2UgICAweDAwMDUgICAxMDAgICAxMDAgICAwNTAgICAgUHJlLWZh
aWwgIE9mZmxpbmUgICAgICAtICAgICAgIDANCiAgOSBQb3dlcl9Pbl9Ib3VycyAgICAgICAgICAw
eDAwMzIgICAwOTYgICAwOTYgICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5cyAgICAgICAtICAgICAg
IDE3MjkNCiAxMCBTcGluX1JldHJ5X0NvdW50ICAgICAgICAweDAwMzMgICAxMDkgICAxMDAgICAw
MzAgICAgUHJlLWZhaWwgIEFsd2F5cyAgICAgICAtICAgICAgIDANCiAxMiBQb3dlcl9DeWNsZV9D
b3VudCAgICAgICAweDAwMzIgICAxMDAgICAxMDAgICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5cyAg
ICAgICAtICAgICAgIDM5NA0KMTkyIFBvd2VyLU9mZl9SZXRyYWN0X0NvdW50IDB4MDAzMiAgIDEw
MCAgIDEwMCAgIDAwMCAgICBPbGRfYWdlICAgQWx3YXlzICAgICAgIC0gICAgICAgOTcNCjE5MyBM
b2FkX0N5Y2xlX0NvdW50ICAgICAgICAweDAwMzIgICAwODkgICAwODkgICAwMDAgICAgT2xkX2Fn
ZSAgIEFsd2F5cyAgICAgICAtICAgICAgIDExMTUwNw0KMTk0IFRlbXBlcmF0dXJlX0NlbHNpdXMg
ICAgIDB4MDAyMiAgIDEwMCAgIDEwMCAgIDAwMCAgICBPbGRfYWdlICAgQWx3YXlzICAgICAgIC0g
ICAgICAgMzcgKExpZmV0aW1lIE1pbi9NYXggMTUvNTApDQoxOTYgUmVhbGxvY2F0ZWRfRXZlbnRf
Q291bnQgMHgwMDMyICAgMTAwICAgMTAwICAgMDAwICAgIE9sZF9hZ2UgICBBbHdheXMgICAgICAg
LSAgICAgICAwDQoxOTcgQ3VycmVudF9QZW5kaW5nX1NlY3RvciAgMHgwMDMyICAgMTAwICAgMTAw
ICAgMDAwICAgIE9sZF9hZ2UgICBBbHdheXMgICAgICAgLSAgICAgICAwDQoxOTggT2ZmbGluZV9V
bmNvcnJlY3RhYmxlICAgMHgwMDMwICAgMTAwICAgMTAwICAgMDAwICAgIE9sZF9hZ2UgICBPZmZs
aW5lICAgICAgLSAgICAgICAwDQoxOTkgVURNQV9DUkNfRXJyb3JfQ291bnQgICAgMHgwMDMyICAg
MjAwICAgMjAwICAgMDAwICAgIE9sZF9hZ2UgICBBbHdheXMgICAgICAgLSAgICAgICAwDQoyMjAg
RGlza19TaGlmdCAgICAgICAgICAgICAgMHgwMDAyICAgMTAwICAgMTAwICAgMDAwICAgIE9sZF9h
Z2UgICBBbHdheXMgICAgICAgLSAgICAgICAxMjINCjIyMiBMb2FkZWRfSG91cnMgICAgICAgICAg
ICAweDAwMzIgICAwOTggICAwOTggICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5cyAgICAgICAtICAg
ICAgIDExNjgNCjIyMyBMb2FkX1JldHJ5X0NvdW50ICAgICAgICAweDAwMzIgICAxMDAgICAxMDAg
ICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5cyAgICAgICAtICAgICAgIDANCjIyNCBMb2FkX0ZyaWN0
aW9uICAgICAgICAgICAweDAwMjIgICAxMDAgICAxMDAgICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5
cyAgICAgICAtICAgICAgIDANCjIyNiBMb2FkLWluX1RpbWUgICAgICAgICAgICAweDAwMjYgICAx
MDAgICAxMDAgICAwMDAgICAgT2xkX2FnZSAgIEFsd2F5cyAgICAgICAtICAgICAgIDMyNA0KMjQw
IEhlYWRfRmx5aW5nX0hvdXJzICAgICAgIDB4MDAwMSAgIDEwMCAgIDEwMCAgIDAwMSAgICBQcmUt
ZmFpbCAgT2ZmbGluZSAgICAgIC0gICAgICAgMA0KDQpTTUFSVCBFcnJvciBMb2cgVmVyc2lvbjog
MQ0KTm8gRXJyb3JzIExvZ2dlZA0KDQpTTUFSVCBTZWxmLXRlc3QgbG9nIHN0cnVjdHVyZSByZXZp
c2lvbiBudW1iZXIgMQ0KTnVtICBUZXN0X0Rlc2NyaXB0aW9uICAgIFN0YXR1cyAgICAgICAgICAg
ICAgICAgIFJlbWFpbmluZyAgTGlmZVRpbWUoaG91cnMpICBMQkFfb2ZfZmlyc3RfZXJyb3INCiMg
MSAgRXh0ZW5kZWQgb2ZmbGluZSAgICBDb21wbGV0ZWQgd2l0aG91dCBlcnJvciAgICAgICAwMCUg
ICAgICAxNzI5ICAgICAgICAgLQ0KIyAyICBTaG9ydCBvZmZsaW5lICAgICAgIENvbXBsZXRlZCB3
aXRob3V0IGVycm9yICAgICAgIDAwJSAgICAgIDE3MjggICAgICAgICAtDQojIDMgIFNob3J0IG9m
ZmxpbmUgICAgICAgQ29tcGxldGVkIHdpdGhvdXQgZXJyb3IgICAgICAgMDAlICAgICAgMTEyOCAg
ICAgICAgIC0NCg0KU01BUlQgU2VsZWN0aXZlIHNlbGYtdGVzdCBsb2cgZGF0YSBzdHJ1Y3R1cmUg
cmV2aXNpb24gbnVtYmVyIDENCiBTUEFOICBNSU5fTEJBICBNQVhfTEJBICBDVVJSRU5UX1RFU1Rf
U1RBVFVTDQogICAgMSAgICAgICAgMCAgICAgICAgMCAgTm90X3Rlc3RpbmcNCiAgICAyICAgICAg
ICAwICAgICAgICAwICBOb3RfdGVzdGluZw0KICAgIDMgICAgICAgIDAgICAgICAgIDAgIE5vdF90
ZXN0aW5nDQogICAgNCAgICAgICAgMCAgICAgICAgMCAgTm90X3Rlc3RpbmcNCiAgICA1ICAgICAg
ICAwICAgICAgICAwICBOb3RfdGVzdGluZw0KU2VsZWN0aXZlIHNlbGYtdGVzdCBmbGFncyAoMHgw
KToNCiAgQWZ0ZXIgc2Nhbm5pbmcgc2VsZWN0ZWQgc3BhbnMsIGRvIE5PVCByZWFkLXNjYW4gcmVt
YWluZGVyIG9mIGRpc2suDQpJZiBTZWxlY3RpdmUgc2VsZi10ZXN0IGlzIHBlbmRpbmcgb24gcG93
ZXItdXAsIHJlc3VtZSBhZnRlciAwIG1pbnV0ZSBkZWxheS4NCg0K


--=-lcPNZjsWYxb423CE3y3s--

--=-U33QZx/3WPpoyJd/Rnnv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE1J7tFjFZ/qjkvZARAs5DAJ93jiwCekYg4YzEZePGedsarQhjZQCdGHMi
oJtldcJLgPRhSQXG9hAO7Ac=
=Jt/7
-----END PGP SIGNATURE-----

--=-U33QZx/3WPpoyJd/Rnnv--

