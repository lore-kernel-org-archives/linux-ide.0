From: Erik Slagter <erik@slagter.name>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 12:51:14 +0100
Message-ID: <1137671474.20831.5.camel@localhost.localdomain>
References: <200601131909.07981.pvrusb2@toplitzer.net>
	 <200601181536.16868.pvrusb2@toplitzer.net>
	 <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
	 <200601190821.51702.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-Y8++iF969i+KUaFt3Kul"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from erik-slagter.demon.nl ([83.161.107.130]:35977 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1161203AbWASLvd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 06:51:33 -0500
Received: from skylla.slagter.name (skylla.slagter.name [172.31.4.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "skylla.slagter.name", Issuer "CA Cert Signing Authority" (verified OK))
	by artemis.slagter.name (Postfix) with ESMTP id 78EFF1434003
	for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2006 12:51:21 +0100 (CET)
In-Reply-To: <200601190821.51702.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-Y8++iF969i+KUaFt3Kul
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-01-19 at 08:21 +0100, Helmut Toplitzer wrote:
> Ok. I found another possible reason, did I?
>=20
> I read in several forums that HLT in KT333 chipsets
> of VIA is not enough to get the processor in powersafe
> and to disconnect from the FSB. You need to issuse
> the STPGNT command which also needs first
> to set some registers (because it degrades overall performance and
> so it's normaly disabled by BIOS).
> http://www.planet3dnow.de/vbulletin/archive/index.php/t-80854.html
> (German)
>=20
> It's called "Disconnect Enable when STPGNT Detected". And may cause
> other problems like sound distortion etc. because of high fluctuation
> in power current.

This is actually a common AMD Athlon problem. When STOPGRNT is not
enable, hlt does next to nothing. Some boards/bios'es set this bit by
itself, some don't, and some even crash when it's enabled (very bad,
imho).

Also my experience is that some PCI devices tend to stop working when
STOPGRNT is enabled, notably my Promise SX 150 tx2plus, that completely
freaks whenever it misses one single interrupt, which may very well
happen when the processor/board are in C1/C2 (apparently).

See also my other message on this matter:

On Tue, 2006-01-03 at 18:58 +0000, Alan Cox wrote:

> There is a known old bug with error handling in some cases on promise
> chips. The core kernel code tries to clean up any remaining data after
> an error (to handle chip prefetch/postwrite FIFOs) if DRQ_STAT is
> asserted. Its a nice trick, saves on resets and slow recovery but
isn't
> compatible with some promise controllers.
>=20
> The -mm tree has a partial but incomplete fix to this implemented, the
> base kernel does not have this fixed.
>=20
> Its been known for some time so perhaps the ide maintainers have
patches
> waiting for 2.6.16 now its opened ?

Is this patch supposed to fix this problem:

Promise SATAII150 TX2plus using libata_promise, when it misses one
single interrupt (or maybe it's not even missed but only delayed), it
goes crazy, kernel log is full with disk failures, and the disk is
kicked out of the md(1) array grmbl.

This happens when amd76x_pm is used, even with the irq watcher in the
utter most conservative setting.

Any clue otherwise?


--=-Y8++iF969i+KUaFt3Kul
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIILzCCAnIw
ggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYDVQQE
EwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlqbiBT
bGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGYNW5L
vevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI0gVv
gY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFn
dGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8WcuJ7Q1
eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xNdkFU
mhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPkyITCC
AnIwggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYD
VQQEEwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlq
biBTbGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGY
NW5Lvevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI
0gVvgY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0Bz
bGFndGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8Wcu
J7Q1eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xN
dkFUmhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPky
ITCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1
bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMT
G1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJl
ZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNa
LIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUq
VIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1Ud
HwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWls
Q0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVs
Mi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa
9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggJmMIICYgIBATBpMGIxCzAJ
BgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMAkGBSsOAwIaBQCgggFT
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MDExOTExNTExMFow
IwYJKoZIhvcNAQkEMRYEFN4+RoHLLvnkTy6xY0wReZI1s3k5MHgGCSsGAQQBgjcQBDFrMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMP8QQwegYLKoZIhvcNAQkQ
Agsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMA0G
CSqGSIb3DQEBAQUABIGAVoLoWGeuriklB1WTSv8Wo9RDQz9mSwrRG2/s4sUvWPXffXZlVIZAvK5h
VimnDXNNGTXLeaYSbTCwr9J5QI/BUzrOVaLD2rdjgaqgzi2BMGb8Wop5hA8O3diiPqp8jdDL9R7Z
zazgvVrXBCyR2tyK2ySDmDG1KsMLLQUrKKQi6WEAAAAAAAA=


--=-Y8++iF969i+KUaFt3Kul--
