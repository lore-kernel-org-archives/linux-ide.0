From: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 18:23:52 +0100
Message-ID: <4788F7A8.4080707@twam.info>
References: <200801101824.04863.Tobias_Mueller@twam.info> <200801121538.47692.bzolnier@gmail.com> <4788CECE.5090207@twam.info> <200801121709.26920.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050304020001090906040405"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:35040 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381AbYALRYK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Jan 2008 12:24:10 -0500
Received: from [192.168.23.51] (p5B2EE4A7.dip.t-dialin.net [91.46.228.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.twam.info (Postfix) with ESMTP id 6276620959
	for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 18:24:12 +0100 (CET)
In-Reply-To: <200801121709.26920.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050304020001090906040405
Content-Type: multipart/mixed;
 boundary="------------080307030709020900050700"

This is a multi-part message in MIME format.
--------------080307030709020900050700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi

Bartlomiej Zolnierkiewicz schrieb:
> As a workaround you can try using IDE subsystem siimage driver and pass=

> "idex=3Data66" option or modify Tejun's patch to also override device s=
ide
> cable detection by replacing ATA_CBL_PATA80 with ATA_CBL_PATA40_SHORT.
I changed some code in libata=3Dcore.c in ata_dev_xfermask (see patch2), =

that xfer_mask &=3D ~(0xF8 << ATA_SHIFT_UDMA) isn't set, when forcing 80c=
=2E

Everything seems to work now. I have a about 41 MB/s while reading.

Regards
   Tobias


dmesg says

[   40.854101] ata7: PATA max UDMA/133 irq 16
[   40.854162] ata8: PATA max UDMA/133 irq 16
[   41.008881] ata7: forcing 80c
[   41.008949] ata7.00: ATA-4: SanDisk SDCFX4-8192, HDX 4.20, max UDMA/66=

[   41.009014] ata7.00: 16007040 sectors, multi 0: LBA
[   41.009751] ata7.00: configured for UDMA/66
[   41.168606] ata8: forcing 80c
[   41.168673] ata8.00: ATA-4: SanDisk SDCFX3-2048, HDX 4.08, max MWDMA2
[   41.168738] ata8.00: 4001760 sectors, multi 0: LBA
[   41.188267] ata8.00: configured for MWDMA2
[   41.188418] scsi 6:0:0:0: Direct-Access     ATA      SanDisk SDCFX4-8 =

HDX  PQ: 0 ANSI: 5
[   41.188622] sd 6:0:0:0: [sdc] 16007040 512-byte hardware sectors=20
(8196 MB)
[   41.188696] sd 6:0:0:0: [sdc] Write Protect is off
[   41.188759] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   41.188776] sd 6:0:0:0: [sdc] Write cache: disabled, read cache:=20
enabled, doesn't support DPO or FUA
[   41.188918] sd 6:0:0:0: [sdc] 16007040 512-byte hardware sectors=20
(8196 MB)
[   41.188990] sd 6:0:0:0: [sdc] Write Protect is off
[   41.189054] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   41.189070] sd 6:0:0:0: [sdc] Write cache: disabled, read cache:=20
enabled, doesn't support DPO or FUA
[   41.189167]  sdc: sdc1 sdc2
[   41.189880] sd 6:0:0:0: [sdc] Attached SCSI disk
[   41.190092] scsi 7:0:0:0: Direct-Access     ATA      SanDisk SDCFX3-2 =

HDX  PQ: 0 ANSI: 5
[   41.190283] sd 7:0:0:0: [sdd] 4001760 512-byte hardware sectors (2049 =
MB)
[   41.190357] sd 7:0:0:0: [sdd] Write Protect is off
[   41.190419] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   41.190436] sd 7:0:0:0: [sdd] Write cache: disabled, read cache:=20
enabled, doesn't support DPO or FUA
[   41.190567] sd 7:0:0:0: [sdd] 4001760 512-byte hardware sectors (2049 =
MB)
[   41.190640] sd 7:0:0:0: [sdd] Write Protect is off
[   41.190702] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   41.190719] sd 7:0:0:0: [sdd] Write cache: disabled, read cache:=20
enabled, doesn't support DPO or FUA
[   41.190815]  sdd: sdd1
[   41.191733] sd 7:0:0:0: [sdd] Attached SCSI disk


hdparm -I /dev/sda

[...]
Capabilities:
         LBA, IORDY(may be)(cannot be disabled)
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max =3D 4   Current =3D 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
              Cycle time: min=3D120ns recommended=3D120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=3D120ns  IORDY flow control=3D1=
20ns
[...]



dd if=3D/dev/sdc of=3D/dev/null bs=3D1M count=3D16 iflag=3Ddirect

16+0 Datens=C3=A4tze ein
16+0 Datens=C3=A4tze aus
16777216 Bytes (17 MB) kopiert, 0,402367 s, 41,7 MB/s


--------------080307030709020900050700
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch2"

ZGlmZiAtLWdpdCBhL2xpbnV4LTIuNi4yNC1yYzcvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUu
YyBiL2xpbnV4LTIuNi4yNC1yYzctdHdhbS9kcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jCmlu
ZGV4IDQ3NTNhMTguLmFjNWEwZDQgMTAwNjQ0Ci0tLSBhL2xpbnV4LTIuNi4yNC1yYzcvZHJp
dmVycy9hdGEvbGliYXRhLWNvcmUuYworKysgYi9saW51eC0yLjYuMjQtcmM3LXR3YW0vZHJp
dmVycy9hdGEvbGliYXRhLWNvcmUuYwpAQCAtMTE5LDYgKzExOSwxMCBAQCBpbnQgbGliYXRh
X25vYWNwaSA9IDA7CiBtb2R1bGVfcGFyYW1fbmFtZWQobm9hY3BpLCBsaWJhdGFfbm9hY3Bp
LCBpbnQsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyhub2FjcGksICJEaXNhYmxlcyB0aGUg
dXNlIG9mIEFDUEkgaW4gcHJvYmUvc3VzcGVuZC9yZXN1bWUgd2hlbiBzZXQiKTsKIAoraW50
IGxpYmF0YV9mb3JjZV9jYmwgPSAwOworbW9kdWxlX3BhcmFtX25hbWVkKGZvcmNlX2NibCwg
bGliYXRhX2ZvcmNlX2NibCwgaW50LCAwNjQ0KTsKK01PRFVMRV9QQVJNX0RFU0MoZm9yY2Vf
Y2JsLCAiZm9yY2UgUEFUQSBjYWJsZSB0eXBlICgwPWtlZXAsIDQwPTQwYywgODA9ODBjKSIp
OworCiBNT0RVTEVfQVVUSE9SKCJKZWZmIEdhcnppayIpOwogTU9EVUxFX0RFU0NSSVBUSU9O
KCJMaWJyYXJ5IG1vZHVsZSBmb3IgQVRBIGRldmljZXMiKTsKIE1PRFVMRV9MSUNFTlNFKCJH
UEwiKTsKQEAgLTQzMTgsMTYgKzQzMjIsMjkgQEAgc3RhdGljIHZvaWQgYXRhX2Rldl94ZmVy
bWFzayhzdHJ1Y3QgYXRhX2RldmljZSAqZGV2KQogCSAqIGRyaXZlIHNpZGUgYXMgd2VsbC4g
Q2FzZXMgd2hlcmUgd2Uga25vdyBhIDQwd2lyZSBjYWJsZQogCSAqIGlzIHVzZWQgc2FmZWx5
IGZvciA4MCBhcmUgbm90IGNoZWNrZWQgaGVyZS4KIAkgKi8KLQlpZiAoeGZlcl9tYXNrICYg
KDB4RjggPDwgQVRBX1NISUZUX1VETUEpKQotCQkvKiBVRE1BLzQ0IG9yIGhpZ2hlciB3b3Vs
ZCBiZSBhdmFpbGFibGUgKi8KLQkJaWYgKChhcC0+Y2JsID09IEFUQV9DQkxfUEFUQTQwKSB8
fAotCQkgICAgKGF0YV9pc180MHdpcmUoZGV2KSAmJgotCQkgICAgKGFwLT5jYmwgPT0gQVRB
X0NCTF9QQVRBX1VOSyB8fAotCQkgICAgIGFwLT5jYmwgPT0gQVRBX0NCTF9QQVRBODApKSkg
ewotCQkJYXRhX2Rldl9wcmludGsoZGV2LCBLRVJOX1dBUk5JTkcsCi0JCQkJICJsaW1pdGVk
IHRvIFVETUEvMzMgZHVlIHRvIDQwLXdpcmUgY2FibGVcbiIpOwotCQkJeGZlcl9tYXNrICY9
IH4oMHhGOCA8PCBBVEFfU0hJRlRfVURNQSk7CisJaWYgKHhmZXJfbWFzayAmICgweEY4IDw8
IEFUQV9TSElGVF9VRE1BKSkgeworICAgICAgICAgICAgICAgIHN3aXRjaCAobGliYXRhX2Zv
cmNlX2NibCkgeworICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSA0MDoKKwkJCQkvKiBs
aW1pdCB0byBVRE1BLzMzICovCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0
YV9kZXZfcHJpbnRrKGRldiwgS0VSTl9JTkZPLCAiZm9yY2luZyA0MGNcbiIpOworCQkJCXhm
ZXJfbWFzayAmPSB+KDB4RjggPDwgQVRBX1NISUZUX1VETUEpOworCQkJCWJyZWFrOworICAg
ICAgICAgICAgICAgICAgICAgICAgY2FzZSA4MDoKKwkJCQkvKiBpZ25vcmUgY2FibGUgY2hl
Y2tzICovCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0YV9kZXZfcHJpbnRr
KGRldiwgS0VSTl9JTkZPLCAiZm9yY2luZyA4MGNcbiIpOworCQkJCWJyZWFrOworCQkJZGVm
YXVsdDoKKwkJCQkvKiBVRE1BLzQ0IG9yIGhpZ2hlciB3b3VsZCBiZSBhdmFpbGFibGUgKi8K
KwkJCQlpZiAoKGFwLT5jYmwgPT0gQVRBX0NCTF9QQVRBNDApIHx8CisJCQkJICAgIChhdGFf
aXNfNDB3aXJlKGRldikgJiYKKwkJCQkgICAgKGFwLT5jYmwgPT0gQVRBX0NCTF9QQVRBX1VO
SyB8fAorCQkJCSAgICAgYXAtPmNibCA9PSBBVEFfQ0JMX1BBVEE4MCkpKSB7CisJCQkJCWF0
YV9kZXZfcHJpbnRrKGRldiwgS0VSTl9XQVJOSU5HLAorCQkJCQkJICJsaW1pdGVkIHRvIFVE
TUEvMzMgZHVlIHRvIDQwLXdpcmUgY2FibGVcbiIpOworCQkJCQl4ZmVyX21hc2sgJj0gfigw
eEY4IDw8IEFUQV9TSElGVF9VRE1BKTsKKwkJCQl9CiAJCX0KKwl9CiAKIAlhdGFfdW5wYWNr
X3hmZXJtYXNrKHhmZXJfbWFzaywgJmRldi0+cGlvX21hc2ssCiAJCQkgICAgJmRldi0+bXdk
bWFfbWFzaywgJmRldi0+dWRtYV9tYXNrKTsKZGlmZiAtLWdpdCBhL2xpbnV4LTIuNi4yNC1y
YzcvZHJpdmVycy9hdGEvbGliYXRhLWVoLmMgYi9saW51eC0yLjYuMjQtcmM3LXR3YW0vZHJp
dmVycy9hdGEvbGliYXRhLWVoLmMKaW5kZXggZjAxMjRhOC4uN2M2MDdlMCAxMDA2NDQKLS0t
IGEvbGludXgtMi42LjI0LXJjNy9kcml2ZXJzL2F0YS9saWJhdGEtZWguYworKysgYi9saW51
eC0yLjYuMjQtcmM3LXR3YW0vZHJpdmVycy9hdGEvbGliYXRhLWVoLmMKQEAgLTIyODgsOSAr
MjI4OCwyNyBAQCBzdGF0aWMgaW50IGF0YV9laF9yZXZhbGlkYXRlX2FuZF9hdHRhY2goc3Ry
dWN0IGF0YV9saW5rICpsaW5rLAogCiAJLyogUERJQUctIHNob3VsZCBoYXZlIGJlZW4gcmVs
ZWFzZWQsIGFzayBjYWJsZSB0eXBlIGlmIHBvc3QtcmVzZXQgKi8KIAlpZiAoYXRhX2lzX2hv
c3RfbGluayhsaW5rKSAmJiBhcC0+b3BzLT5jYWJsZV9kZXRlY3QgJiYKLQkgICAgKGVoYy0+
aS5mbGFncyAmIEFUQV9FSElfRElEX1JFU0VUKSkKKwkgICAgKGVoYy0+aS5mbGFncyAmIEFU
QV9FSElfRElEX1JFU0VUKSkgewogCQlhcC0+Y2JsID0gYXAtPm9wcy0+Y2FibGVfZGV0ZWN0
KGFwKTsKIAorCQlpZiAoIShhcC0+ZmxhZ3MgJiBBVEFfRkxBR19TQVRBKSAmJiBsaWJhdGFf
Zm9yY2VfY2JsKSB7CisJCQlzd2l0Y2ggKGxpYmF0YV9mb3JjZV9jYmwpIHsKKwkJCWNhc2Ug
NDA6CisJCQkJYXRhX3BvcnRfcHJpbnRrKGFwLCBLRVJOX0lORk8sICJmb3JjaW5nIDQwY1xu
Iik7CisJCQkJYXAtPmNibCA9IEFUQV9DQkxfUEFUQTQwOworCQkJCWJyZWFrOworCQkJY2Fz
ZSA4MDoKKwkJCQlhdGFfcG9ydF9wcmludGsoYXAsIEtFUk5fSU5GTywgImZvcmNpbmcgODBj
XG4iKTsKKwkJCQlhcC0+Y2JsID0gQVRBX0NCTF9QQVRBODA7CisJCQkJYnJlYWs7CisJCQlk
ZWZhdWx0OgorCQkJCWF0YV9wb3J0X3ByaW50ayhhcCwgS0VSTl9XQVJOSU5HLAorCQkJCQkJ
ImludmFsaWQgZm9yY2VfY2JsIHZhbHVlICVkXG4iLAorCQkJCQkJbGliYXRhX2ZvcmNlX2Ni
bCk7CisJCQl9CisJCX0KKwl9CisKIAkvKiBDb25maWd1cmUgbmV3IGRldmljZXMgZm9yd2Fy
ZCBzdWNoIHRoYXQgdXNlciBkb2Vzbid0IHNlZQogCSAqIGRldmljZSBkZXRlY3Rpb24gbWVz
c2FnZXMgYmFja3dhcmRzLgogCSAqLwpkaWZmIC0tZ2l0IGEvbGludXgtMi42LjI0LXJjNy9k
cml2ZXJzL2F0YS9saWJhdGEuaCBiL2xpbnV4LTIuNi4yNC1yYzctdHdhbS9kcml2ZXJzL2F0
YS9saWJhdGEuaAppbmRleCBiYmU1OWMyLi5iOTkwYThkIDEwMDY0NAotLS0gYS9saW51eC0y
LjYuMjQtcmM3L2RyaXZlcnMvYXRhL2xpYmF0YS5oCisrKyBiL2xpbnV4LTIuNi4yNC1yYzct
dHdhbS9kcml2ZXJzL2F0YS9saWJhdGEuaApAQCAtNjAsNiArNjAsNyBAQCBleHRlcm4gaW50
IGF0YXBpX2RtYWRpcjsKIGV4dGVybiBpbnQgYXRhcGlfcGFzc3RocnUxNjsKIGV4dGVybiBp
bnQgbGliYXRhX2Z1YTsKIGV4dGVybiBpbnQgbGliYXRhX25vYWNwaTsKK2V4dGVybiBpbnQg
bGliYXRhX2ZvcmNlX2NibDsKIGV4dGVybiBzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKmF0YV9x
Y19uZXdfaW5pdChzdHJ1Y3QgYXRhX2RldmljZSAqZGV2KTsKIGV4dGVybiBpbnQgYXRhX2J1
aWxkX3J3X3RmKHN0cnVjdCBhdGFfdGFza2ZpbGUgKnRmLCBzdHJ1Y3QgYXRhX2RldmljZSAq
ZGV2LAogCQkJICAgdTY0IGJsb2NrLCB1MzIgbl9ibG9jaywgdW5zaWduZWQgaW50IHRmX2Zs
YWdzLAo=
--------------080307030709020900050700--

--------------ms050304020001090906040405
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJmzCC
AygwggKRoAMCAQICEDdfXmLiPCut3WRIWKcEfrgwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTIxMTE0NDIyNVoX
DTA4MTIxMDE0NDIyNVowgYcxEDAOBgNVBAQTB011ZWxsZXIxIDAeBgNVBCoTF1RvYmlhcyBX
b2xmZ2FuZyBBbmRyZWFzMSgwJgYDVQQDEx9Ub2JpYXMgV29sZmdhbmcgQW5kcmVhcyBNdWVs
bGVyMScwJQYJKoZIhvcNAQkBFhhUb2JpYXNfTXVlbGxlckB0d2FtLmluZm8wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3vN/xQv+Nqk74OxgDpqJHwYGdwWOemIfl/W1sOlIE
FXzO9IDR57fa4FlqIUFrezqlolzipm1ZJAfxVhO4pdSjtwNj/4Z6ap5c3LbTjZYwL2abiFPi
qQPrwyIzYYKTyRpWetnTs0BVohEHMR38/sA3LMI4VQQEBYAd/XnPQPOLObLqbUggI1JZwmgO
zLEI1GSUEI2fUVyMeKIyXqX293cgw/5zQuoyZ87PQX80LsBkRx7JOnyUZ94+togZU/NtHso4
u+GcxVK8II/BN5wXYCoIQvNxsR0jc1AGJ7Y2xnjACjUVFeK/n1gZYTa4ZPPm3F/4XyGbd88U
3Qd2cBgP4cF5AgMBAAGjNTAzMCMGA1UdEQQcMBqBGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5m
bzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACk9SGx4seRUhysubF04VghMmHFt
ap3+um/34i+t7rAFxAjA3Fj1NRxyTDuy3TT6M0yO4Toak4778ssDJP8fWIY71DvP5VYhHUJw
F+nCPacU2HRORLTXf61GhqzQzrvujj/yj3Z6z6c2OLc90CaDaoVjTb3nf9F6+1L7ID5ecozo
MIIDKDCCApGgAwIBAgIQN19eYuI8K63dZEhYpwR+uDANBgkqhkiG9w0BAQUFADBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDcxMjExMTQ0MjI1
WhcNMDgxMjEwMTQ0MjI1WjCBhzEQMA4GA1UEBBMHTXVlbGxlcjEgMB4GA1UEKhMXVG9iaWFz
IFdvbGZnYW5nIEFuZHJlYXMxKDAmBgNVBAMTH1RvYmlhcyBXb2xmZ2FuZyBBbmRyZWFzIE11
ZWxsZXIxJzAlBgkqhkiG9w0BCQEWGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5mbzCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBALe83/FC/42qTvg7GAOmokfBgZ3BY56Yh+X9bWw6
UgQVfM70gNHnt9rgWWohQWt7OqWiXOKmbVkkB/FWE7il1KO3A2P/hnpqnlzcttONljAvZpuI
U+KpA+vDIjNhgpPJGlZ62dOzQFWiEQcxHfz+wDcswjhVBAQFgB39ec9A84s5suptSCAjUlnC
aA7MsQjUZJQQjZ9RXIx4ojJepfb3dyDD/nNC6jJnzs9BfzQuwGRHHsk6fJRn3j62iBlT820e
yji74ZzFUrwgj8E3nBdgKghC83GxHSNzUAYntjbGeMAKNRUV4r+fWBlhNrhk8+bcX/hfIZt3
zxTdB3ZwGA/hwXkCAwEAAaM1MDMwIwYDVR0RBBwwGoEYVG9iaWFzX011ZWxsZXJAdHdhbS5p
bmZvMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAKT1IbHix5FSHKy5sXThWCEyY
cW1qnf66b/fiL63usAXECMDcWPU1HHJMO7LdNPozTI7hOhqTjvvyywMk/x9YhjvUO8/lViEd
QnAX6cI9pxTYdE5EtNd/rUaGrNDOu+6OP/KPdnrPpzY4tz3QJoNqhWNNved/0Xr7UvsgPl5y
jOgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDZDCCA2ACAQEwdjBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDdfXmLiPCut3WRIWKcEfrgwCQYF
Kw4DAhoFAKCCAcMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDgwMTEyMTcyMzUyWjAjBgkqhkiG9w0BCQQxFgQUDfjUPRqcalIivmZYLAwOyVx7WuowUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64
MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64MA0GCSqGSIb3DQEBAQUABIIBAHd33czg
m7zD9D1eA9hNG5n78P69/Wk3bDyglX0yhFV2gJk7rX491T1/fgDAEm1DzxX3LjdBDTq5J5rn
pBit/FEW2uooF5tp378sBKT7bq6nHfiQIcfvBfY04KEf50iQOcErwyPQfGKqf8Xax3w79ROa
Rl6zWkjAkVBMHTCsuOtXb0iHGhr7Q3tPAcMF8BWkUTGGfWN/33VcGxcVCOzZGPnPtl9pQVRi
rlpv3OiMwwIaLUxm/cxAbRSSIyT4Nb5DdYxT3+P1Q+oL1p1VQl3VRfL25MiEup5pekC31N8P
4sS8qmi4UNEWCALeeoBNW8iIZeEFf+/ndelTWtkw8+CUwRsAAAAAAAA=
--------------ms050304020001090906040405--
