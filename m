From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: Re: [PATCH] libata-core: Allow longer timeout for drive spinup from
 PUIS
Date: Sat, 2 Apr 2016 12:23:02 +0000
Message-ID: <D088F533-0243-4414-9B03-BC177DC1D35C@hgst.com>
References: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
 <20160330183846.GK7822@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_D088F533024344149B03BC177DC1D35Chgstcom_"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sjc00mx1.hitachigst.com ([199.255.44.36]:52081 "EHLO
	sjc00mx1.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbcDBMXH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Apr 2016 08:23:07 -0400
In-Reply-To: <20160330183846.GK7822@mtj.duckdns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

--_002_D088F533024344149B03BC177DC1D35Chgstcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E05DC030C9BD97438C6C2C4E249DE73B@namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Tejun,

>On Tue, Mar 22, 2016 at 08:22:22AM +0000, Damien Le Moal wrote:
>> diff --git a/include/linux/ata.h b/include/linux/ata.h
>> index c1a2f34..f460e7f 100644
>> --- a/include/linux/ata.h
>> +++ b/include/linux/ata.h
>> @@ -371,7 +371,8 @@ enum {
>>  	SETFEATURES_AAM_ON	=3D 0x42,
>>  	SETFEATURES_AAM_OFF	=3D 0xC2,
>>  =

>> -	SETFEATURES_SPINUP	=3D 0x07, /* Spin-up drive */
>> +	SETFEATURES_SPINUP		=3D 0x07, /* Spin-up drive */
>> +	SETFEATURES_SPINUP_TIMEOUT	=3D 30, /* 30s timeout for drive spin-up fr=
om PUIS */
>
>Other timeout constants are defined in msecs.  Let's do the same here.
>Also, can you please send the email as plain-text without the base64
>encoding?  If you can't, please send the patch as an attachment
>instead.

Sorry about the email format (I am sending emails in plain text, but my
Outlook exchange client/exchange server does not seem to be respecting
that format).

Here is the patch as attachment, reworked to define the timeout in
milliseconds as you suggested.

Thank you.

Best regards.


--
Damien Le Moal, Ph.D.
Sr Manager, System Software Group, WW Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.hgst.com <http://www.hgst.com>
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.

--_002_D088F533024344149B03BC177DC1D35Chgstcom_
Content-Type: application/octet-stream;
	name="set-features-spinup-timeout.patch"
Content-Description: set-features-spinup-timeout.patch
Content-Disposition: attachment;
	filename="set-features-spinup-timeout.patch"; size=2361;
	creation-date="Sat, 02 Apr 2016 12:23:02 GMT";
	modification-date="Sat, 02 Apr 2016 12:23:02 GMT"
Content-ID: <584CBA0415EBC645B149ECBF83392F2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

Y29tbWl0IGM3NWFiNjdkY2JmNWFjMWU4OGFiZDk2N2IwN2EwMjc5YWI0ODg1NTkKQXV0aG9yOiBE
YW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBoZ3N0LmNvbT4KRGF0ZTogICBUdWUgTWFyIDIy
IDEwOjM2OjQ4IDIwMTYgKzA5MDAKCiAgICBsaWJhdGEtY29yZTogQWxsb3cgbG9uZ2VyIHRpbWVv
dXQgZm9yIGRyaXZlIHNwaW51cCBmcm9tIFBVSVMKICAgIAogICAgV2hlbiBzcGlubmluZyB1cCBh
IGRyaXZlIGZyb20gcG93ZXJlZCBvbiBzdGFuZGJ5IG1vZGUgKFBVSVMpLAogICAgU0VURkVBVFVS
RVNfU1BJTlVQIGlzIGV4ZWN1dGVkIHdpdGggdGhlIGRlZmF1bHQgdGltZW91dCB1c2VkCiAgICBm
b3IgYW55IFNFVEZFQVRVUkVTIHN1YmNvbW1hbmQsIHRoYXQgaXMgNSsxMCBzZWNvbmRzLiBUaGUK
ICAgIHRvdGFsIDE1cyBpcyB0b28gc2hvcnQgZm9yIHNvbWUgZHJpdmVzIHRvIGNvbXBsZXRlIHNw
aW51cAogICAgKGUuZy4gZHJpdmVzIHdpdGggYSBsYXJnZSBpbmRpcmVjdGlvbiB0YWJsZSBzdG9y
ZWQgb24gbWVkaWEpLAogICAgcmVzdWx0aW5nIGluIGF0YV9kZXZfcmVhZF9pZCB0byBmYWlsIHR3
aWNlIG9uIHRoZSBleGVjdXRpb24KICAgIG9mIFNFVEZFQVRVUkVTX1NQSU5VUC4gRm9yIHRoaXMg
ZmVhdHVyZSwgYWxsb3cgYSBsYXJnZXIKICAgIGRlZmF1bHQgdGltZW91dCBvZiAzMCBzZWNvbmRz
LiBIb3dldmVyLCBpbiB0aGUgc2FtZSBzcGlyaXQKICAgIGFzIHdpdGggdGhlIHRpbWVvdXQgb2Yg
b3RoZXIgZmVhdHVyZSBzdWJjb21tYW5kcywgZG8gbm90CiAgICBpZ25vcmUgYXRhX3Byb2JlX3Rp
bWVvdXQgaWYgaXQgaXMgc2V0KS4KICAgIAogICAgU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1v
YWwgPGRhbWllbi5sZW1vYWxAaGdzdC5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGli
YXRhLWNvcmUuYyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMKaW5kZXggNTVlMjU3Yy4uYzk0
YTJhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYworKysgYi9kcml2ZXJz
L2F0YS9saWJhdGEtY29yZS5jCkBAIC00NTI4LDYgKzQ1MjgsNyBAQCB1bnNpZ25lZCBpbnQgYXRh
X2Rldl9zZXRfZmVhdHVyZShzdHJ1Y3QgYXRhX2RldmljZSAqZGV2LCB1OCBlbmFibGUsIHU4IGZl
YXR1cmUpCiB7CiAJc3RydWN0IGF0YV90YXNrZmlsZSB0ZjsKIAl1bnNpZ25lZCBpbnQgZXJyX21h
c2s7CisJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gMDsKIAogCS8qIHNldCB1cCBzZXQtZmVhdHVy
ZXMgdGFza2ZpbGUgKi8KIAlEUFJJTlRLKCJzZXQgZmVhdHVyZXMgLSBTQVRBIGZlYXR1cmVzXG4i
KTsKQEAgLTQ1MzksNyArNDU0MCwxMCBAQCB1bnNpZ25lZCBpbnQgYXRhX2Rldl9zZXRfZmVhdHVy
ZShzdHJ1Y3QgYXRhX2RldmljZSAqZGV2LCB1OCBlbmFibGUsIHU4IGZlYXR1cmUpCiAJdGYucHJv
dG9jb2wgPSBBVEFfUFJPVF9OT0RBVEE7CiAJdGYubnNlY3QgPSBmZWF0dXJlOwogCi0JZXJyX21h
c2sgPSBhdGFfZXhlY19pbnRlcm5hbChkZXYsICZ0ZiwgTlVMTCwgRE1BX05PTkUsIE5VTEwsIDAs
IDApOworCWlmIChlbmFibGUgPT0gU0VURkVBVFVSRVNfU1BJTlVQKQorCQl0aW1lb3V0ID0gYXRh
X3Byb2JlX3RpbWVvdXQgPworCQkJICBhdGFfcHJvYmVfdGltZW91dCAqIDEwMDAgOiBTRVRGRUFU
VVJFU19TUElOVVBfVElNRU9VVDsKKwllcnJfbWFzayA9IGF0YV9leGVjX2ludGVybmFsKGRldiwg
JnRmLCBOVUxMLCBETUFfTk9ORSwgTlVMTCwgMCwgdGltZW91dCk7CiAKIAlEUFJJTlRLKCJFWElU
LCBlcnJfbWFzaz0leFxuIiwgZXJyX21hc2spOwogCXJldHVybiBlcnJfbWFzazsKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvYXRhLmggYi9pbmNsdWRlL2xpbnV4L2F0YS5oCmluZGV4IGMxYTJm
MzQuLmY0NjBlN2YgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYXRhLmgKKysrIGIvaW5jbHVk
ZS9saW51eC9hdGEuaApAQCAtMzcxLDcgKzM3MSw4IEBAIGVudW0gewogCVNFVEZFQVRVUkVTX0FB
TV9PTgk9IDB4NDIsCiAJU0VURkVBVFVSRVNfQUFNX09GRgk9IDB4QzIsCiAKLQlTRVRGRUFUVVJF
U19TUElOVVAJPSAweDA3LCAvKiBTcGluLXVwIGRyaXZlICovCisJU0VURkVBVFVSRVNfU1BJTlVQ
CQk9IDB4MDcsIC8qIFNwaW4tdXAgZHJpdmUgKi8KKwlTRVRGRUFUVVJFU19TUElOVVBfVElNRU9V
VAk9IDMwMDAwLCAvKiAzMHMgdGltZW91dCBmb3IgZHJpdmUgc3Bpbi11cCBmcm9tIFBVSVMgKi8K
IAogCVNFVEZFQVRVUkVTX1NBVEFfRU5BQkxFID0gMHgxMCwgLyogRW5hYmxlIHVzZSBvZiBTQVRB
IGZlYXR1cmUgKi8KIAlTRVRGRUFUVVJFU19TQVRBX0RJU0FCTEUgPSAweDkwLCAvKiBEaXNhYmxl
IHVzZSBvZiBTQVRBIGZlYXR1cmUgKi8K

--_002_D088F533024344149B03BC177DC1D35Chgstcom_--

