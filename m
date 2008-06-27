From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: Re: [PATCH] ht6560b: remove old history
Date: Fri, 27 Jun 2008 21:34:42 +0200
Message-ID: <486540D2.6050804@caiway.nl>
References: <48654085.9070605@caiway.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080906080405050204010506"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pelian3.kabelfoon.nl ([62.45.45.106]:65515 "EHLO
	pelian.kabelfoon.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758489AbYF0Teo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 15:34:44 -0400
In-Reply-To: <48654085.9070605@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080906080405050204010506
Content-Type: multipart/mixed;
 boundary="------------010008070006010701040006"

This is a multi-part message in MIME format.
--------------010008070006010701040006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ugh. patch. missing.

Jan Evert van Grootheest wrote:
> Hi Bart,
>
> Here's a patch to remove the ancient history from the ht6560b driver.
> I'm not entirely sure, but I'm listed as Author: in the patch. Do I 
> also need to add a signed-off line?
>
> Good luck,
> Jan Evert
>


--------------010008070006010701040006
Content-Type: text/x-diff;
 name="ht6560-history.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ht6560-history.diff"

commit 2ee832ffc4acd24e740fa609586cc326ef0e9aed
Author: Jan Evert van Grootheest <janevert@lappie.(none)>
Date:   Fri Jun 27 21:30:14 2008 +0200

    Remove the ancient version history. Git does a better job.

diff --git a/drivers/ide/legacy/ht6560b.c b/drivers/ide/legacy/ht6560b.c
index 46d6166..8b48e63 100644
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -3,28 +3,6 @@
  */
 
 /*
- *
- *  Version 0.01        Initial version hacked out of ide.c
- *
- *  Version 0.02        Added support for PIO modes, auto-tune
- *
- *  Version 0.03        Some cleanups
- *
- *  Version 0.05        PIO mode cycle timings auto-tune using bus-speed
- *
- *  Version 0.06        Prefetch mode now defaults no OFF. To set
- *                      prefetch mode OFF/ON use "hdparm -p8/-p9".
- *                      Unmask irq is disabled when prefetch mode
- *                      is enabled.
- *
- *  Version 0.07        Trying to fix CD-ROM detection problem.
- *                      "Prefetch" mode bit OFF for ide disks and
- *                      ON for anything else.
- *
- *  Version 0.08        Need to force prefetch for CDs and other non-disk
- *                      devices. (not sure which devices exactly need
- *                      prefetch)
- *
  *  HT-6560B EIDE-controller support
  *  To activate controller support use kernel parameter "ide0=ht6560b".
  *  Use hdparm utility to enable PIO mode support.

--------------010008070006010701040006--

--------------ms080906080405050204010506
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO7jCC
B3MwggVboAMCAQICAQMwDQYJKoZIhvcNAQEFBQAwgaUxCzAJBgNVBAYTAk5MMRMwEQYDVQQI
EwpHZWxkZXJsYW5kMRMwEQYDVQQHEwpIYXJkZXJ3aWprMRwwGgYDVQQKExNKLkUuIHZhbiBH
cm9vdGhlZXN0MSEwHwYDVQQDExhKYW4gRXZlcnQgdmFuIEdyb290aGVlc3QxKzApBgkqhkiG
9w0BCQEWHGouZS52YW4uZ3Jvb3RoZWVzdEBjYWl3YXkubmwwHhcNMDgwNDA4MDc1MTMxWhcN
MDkwNDA4MDc1MTMxWjCBpTELMAkGA1UEBhMCTkwxEzARBgNVBAgTCkdlbGRlcmxhbmQxEzAR
BgNVBAcTCkhhcmRlcndpamsxHDAaBgNVBAoTE0ouRS4gdmFuIEdyb290aGVlc3QxITAfBgNV
BAMTGEphbiBFdmVydCB2YW4gR3Jvb3RoZWVzdDErMCkGCSqGSIb3DQEJARYcai5lLnZhbi5n
cm9vdGhlZXN0QGNhaXdheS5ubDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMg4
3wenc42l/YlQzGBogfqvlBH0A/3MvVw/9Fa2hPDTs/sJ+iNiiKHKBn7GhjMf3VO4bjFInbPc
ZG0/b/A9bbvhRaNIAZmy2yz8IbFxU16g19cByyFKSEGbknS2r6fXMcCi02l65ZBmHV1XBB7M
62GRo0TKWIqOY00AR3ujF9pAzARLSBW92Ykf6jIzgtliGLt6YO+EZVHNUHcV+CA2kR/HXfju
M7+XOW+1IKSJyQ2aIlKBCtryxki/LqABTTL06jzJl+QW1oa7AIHhwI13qqyJfynTYrgAIwYS
92H6Cv+J2Buxykk9vBb/L73q+VdGmLw2z/6gDsjQOmk+WpICDZLNs+aI5W4UCNoE1rYCFPki
SI00TN/lAQXsp1mtNXs10RIW2OF2l0/ebM7Q6l4vj7l4LKjR/Qe3Yu3PzqBdDvaYeGMMpK2Q
kSvKfvA+gQCRVw3W+9V3GgSiQkFcUmM1gNCjwHIoEwfRaU9iionE5VHSsjm8DoTtjdeq1mBE
iFfsBQOkewAS2W3JFjGqOAYSh1UPgF57xdPzgjIzlnhji/NM3yy/9LCSZhVyf9eqZ7HvfI6s
nYcaZJosM+x96iauOwJF1GM/DABsIAxZPvkXMMHjrQGW/iA4Ik4IgSa3ueP+mzgfwsdQjRqX
oABun/mK/G3gJwJE2YsyYyawphg31kINAgMBAAGjggGqMIIBpjAJBgNVHRMEAjAAMBEGCWCG
SAGG+EIBAQQEAwIEsDArBglghkgBhvhCAQ0EHhYcVGlueUNBIEdlbmVyYXRlZCBDZXJ0aWZp
Y2F0ZTAdBgNVHQ4EFgQUZ/nkxP99q4jayO32sIUgzK3Ns7owgdoGA1UdIwSB0jCBz4AUloS2
O/+9zbmqj22/Ad/RDl49RnmhgaukgagwgaUxCzAJBgNVBAYTAk5MMRMwEQYDVQQIEwpHZWxk
ZXJsYW5kMRMwEQYDVQQHEwpIYXJkZXJ3aWprMRwwGgYDVQQKExNKLkUuIHZhbiBHcm9vdGhl
ZXN0MSEwHwYDVQQDExhKYW4gRXZlcnQgdmFuIEdyb290aGVlc3QxKzApBgkqhkiG9w0BCQEW
HGouZS52YW4uZ3Jvb3RoZWVzdEBjYWl3YXkubmyCCQCET9jqLUI66zAnBgNVHRIEIDAegRxq
LmUudmFuLmdyb290aGVlc3RAY2Fpd2F5Lm5sMCcGA1UdEQQgMB6BHGouZS52YW4uZ3Jvb3Ro
ZWVzdEBjYWl3YXkubmwwCwYDVR0PBAQDAgWgMA0GCSqGSIb3DQEBBQUAA4ICAQA2mHVdS8TG
hiV43nucHfmtqg57uO3xQr4epgXidUMQHIzkuDAeXSz1pjQ/QtEuOXxJzdhEk3Y099m5syma
7A3pvMowWBckOTjtfAA8gviY47fjFwTGSm37nUkUG5ndXrmhdSriLwypa6yF2vFgJZ5EXfox
w2Fm6U0IWYWdKH6HAiyQYLiQ64FaeUYu5vRpzbMAUQ9he2gelIGs5hpNMwT9GV78i6P1IE5D
wNdDiwurz53F4vgpH5/TGuyHfoe2H3hVeZLGpcjGv6oQbdtdldHltwzyc4rDSGTQOmLef48j
CR91ijKyULmvFm9VjB64ddmtWqJQg7nmwb39LnrgVkrkbduwoA2+1e7BAS82O44bFaVlT2Pq
EU9lLbKpGEcSTjcEZAzGZHGpG4MHQJZxxnh3YCUd2v7H0GFTiq21elgwlEKCuTHkTFKH6z8Y
bTA1wI7o3PKHSkRI7vXJ/rOths4U7TNxuIK0rP5aP1KoRkHsVm57W0Up0UojaNQxOBSU62cb
CeU4bThZekJ/HfBj6Vo0cWFFA0PGIkAbQKTKnlYzJC9mgWl5M+Fw0MiX9ybs94qj8lfIkIPI
bqhSwzZQcxKcm9ZGVoGbrTSEIhrlXxhQSC8OSmW229J2fNFuxrHZdZbTtERmqCGriDFKrObe
/TMrfVLQ3J19V28VMPyWoSPsFTCCB3MwggVboAMCAQICAQMwDQYJKoZIhvcNAQEFBQAwgaUx
CzAJBgNVBAYTAk5MMRMwEQYDVQQIEwpHZWxkZXJsYW5kMRMwEQYDVQQHEwpIYXJkZXJ3aWpr
MRwwGgYDVQQKExNKLkUuIHZhbiBHcm9vdGhlZXN0MSEwHwYDVQQDExhKYW4gRXZlcnQgdmFu
IEdyb290aGVlc3QxKzApBgkqhkiG9w0BCQEWHGouZS52YW4uZ3Jvb3RoZWVzdEBjYWl3YXku
bmwwHhcNMDgwNDA4MDc1MTMxWhcNMDkwNDA4MDc1MTMxWjCBpTELMAkGA1UEBhMCTkwxEzAR
BgNVBAgTCkdlbGRlcmxhbmQxEzARBgNVBAcTCkhhcmRlcndpamsxHDAaBgNVBAoTE0ouRS4g
dmFuIEdyb290aGVlc3QxITAfBgNVBAMTGEphbiBFdmVydCB2YW4gR3Jvb3RoZWVzdDErMCkG
CSqGSIb3DQEJARYcai5lLnZhbi5ncm9vdGhlZXN0QGNhaXdheS5ubDCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBAMg43wenc42l/YlQzGBogfqvlBH0A/3MvVw/9Fa2hPDTs/sJ
+iNiiKHKBn7GhjMf3VO4bjFInbPcZG0/b/A9bbvhRaNIAZmy2yz8IbFxU16g19cByyFKSEGb
knS2r6fXMcCi02l65ZBmHV1XBB7M62GRo0TKWIqOY00AR3ujF9pAzARLSBW92Ykf6jIzgtli
GLt6YO+EZVHNUHcV+CA2kR/HXfjuM7+XOW+1IKSJyQ2aIlKBCtryxki/LqABTTL06jzJl+QW
1oa7AIHhwI13qqyJfynTYrgAIwYS92H6Cv+J2Buxykk9vBb/L73q+VdGmLw2z/6gDsjQOmk+
WpICDZLNs+aI5W4UCNoE1rYCFPkiSI00TN/lAQXsp1mtNXs10RIW2OF2l0/ebM7Q6l4vj7l4
LKjR/Qe3Yu3PzqBdDvaYeGMMpK2QkSvKfvA+gQCRVw3W+9V3GgSiQkFcUmM1gNCjwHIoEwfR
aU9iionE5VHSsjm8DoTtjdeq1mBEiFfsBQOkewAS2W3JFjGqOAYSh1UPgF57xdPzgjIzlnhj
i/NM3yy/9LCSZhVyf9eqZ7HvfI6snYcaZJosM+x96iauOwJF1GM/DABsIAxZPvkXMMHjrQGW
/iA4Ik4IgSa3ueP+mzgfwsdQjRqXoABun/mK/G3gJwJE2YsyYyawphg31kINAgMBAAGjggGq
MIIBpjAJBgNVHRMEAjAAMBEGCWCGSAGG+EIBAQQEAwIEsDArBglghkgBhvhCAQ0EHhYcVGlu
eUNBIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUZ/nkxP99q4jayO32sIUgzK3N
s7owgdoGA1UdIwSB0jCBz4AUloS2O/+9zbmqj22/Ad/RDl49RnmhgaukgagwgaUxCzAJBgNV
BAYTAk5MMRMwEQYDVQQIEwpHZWxkZXJsYW5kMRMwEQYDVQQHEwpIYXJkZXJ3aWprMRwwGgYD
VQQKExNKLkUuIHZhbiBHcm9vdGhlZXN0MSEwHwYDVQQDExhKYW4gRXZlcnQgdmFuIEdyb290
aGVlc3QxKzApBgkqhkiG9w0BCQEWHGouZS52YW4uZ3Jvb3RoZWVzdEBjYWl3YXkubmyCCQCE
T9jqLUI66zAnBgNVHRIEIDAegRxqLmUudmFuLmdyb290aGVlc3RAY2Fpd2F5Lm5sMCcGA1Ud
EQQgMB6BHGouZS52YW4uZ3Jvb3RoZWVzdEBjYWl3YXkubmwwCwYDVR0PBAQDAgWgMA0GCSqG
SIb3DQEBBQUAA4ICAQA2mHVdS8TGhiV43nucHfmtqg57uO3xQr4epgXidUMQHIzkuDAeXSz1
pjQ/QtEuOXxJzdhEk3Y099m5syma7A3pvMowWBckOTjtfAA8gviY47fjFwTGSm37nUkUG5nd
XrmhdSriLwypa6yF2vFgJZ5EXfoxw2Fm6U0IWYWdKH6HAiyQYLiQ64FaeUYu5vRpzbMAUQ9h
e2gelIGs5hpNMwT9GV78i6P1IE5DwNdDiwurz53F4vgpH5/TGuyHfoe2H3hVeZLGpcjGv6oQ
bdtdldHltwzyc4rDSGTQOmLef48jCR91ijKyULmvFm9VjB64ddmtWqJQg7nmwb39LnrgVkrk
bduwoA2+1e7BAS82O44bFaVlT2PqEU9lLbKpGEcSTjcEZAzGZHGpG4MHQJZxxnh3YCUd2v7H
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
AA==
--------------ms080906080405050204010506--
