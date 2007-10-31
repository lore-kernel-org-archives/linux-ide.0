From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: ATAPI devices in AHCI mode not working
Date: Wed, 31 Oct 2007 16:42:00 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701EE3C42@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com><20071029203028.35645f26@the-village.bc.nu><39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com> <20071029221332.1c9525a9@the-village.bc.nu> <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com> <472837B4.3000109@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701EE38E6@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C81C17.A278311E"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11554 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935AbXJaXma (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 19:42:30 -0400
Content-class: urn:content-classes:message
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701EE38E6@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81C17.A278311E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>>Yeah, there has been quite some update in libata between SLES10_SP1
and
>>2.6.24-rc1.  The controller being ahci, I wonder whether this is
caused
>>by the different in check_atapi_dma().
>>
>>1. Does other optical drives have the same problem?  If not, please
>post
>>the result of "hdparm -I /dev/sr0" with the problematic one attached.
>>
>>2. If you apply the attached patch to 2.6.24-rc1, does it behave the
>>same as the SLES10SP1 kernel?
>>
>>--
>>Tejun
>
>All of the ATAPI drives seem to have the issue of taking a while to
slow
>down and start working.  I will try the patch and see what happens.  I
>will also get the hdparm info from all of the drives I am using to see
>if something stands out.
>
>Thanks,
>
>Jason

Tejun,

Attached are the hdparm -I /dev/cdrom results for the three other drives
I am using.  These do not include the original drive that had the major
issues on, TSSTcorpCD/DVDW SH-S183L.

Applying the patch to the 2.6.24-rc kernel did not cause the same
behavior, which I am seeing with older kernels.  Instead, everything
seemed to be fine until I tried to automount the drive, which said that
there was no media.  I was however, able to manually mount the drive.

Thanks,

Jason


------_=_NextPart_001_01C81C17.A278311E
Content-Type: application/octet-stream;
	name="hdparm_cdrom"
Content-Transfer-Encoding: base64
Content-Description: hdparm_cdrom
Content-Disposition: attachment;
	filename="hdparm_cdrom"

Ci9kZXYvY2Ryb206CgpBVEFQSSBDRC1ST00sIHdpdGggcmVtb3ZhYmxlIG1lZGlhCglNb2RlbCBO
dW1iZXI6ICAgICAgIEFUQVBJICAgRFZEIEQgIERIMTZEMlMgICAgICAgICAgICAgICAgICAKCVNl
cmlhbCBOdW1iZXI6ICAgICAgCglGaXJtd2FyZSBSZXZpc2lvbjogIEVQNTIgICAgClN0YW5kYXJk
czoKCVVzZWQ6IEFUQVBJIGZvciBDRC1ST01zLCBTRkYtODAyMGksIHIyLjUKCVN1cHBvcnRlZDog
Q0QtUk9NIEFUQVBJLTMgLTQgLTUgLTYgCkNvbmZpZ3VyYXRpb246CglEUlEgcmVzcG9uc2U6IDUw
dXMuCglQYWNrZXQgc2l6ZTogMTIgYnl0ZXMKQ2FwYWJpbGl0aWVzOgoJTEJBLCBJT1JEWShjYW4g
YmUgZGlzYWJsZWQpCglETUE6IG1kbWEwIG1kbWExIG1kbWEyIHVkbWEwIHVkbWExIHVkbWEyIHVk
bWEzIHVkbWE0ICp1ZG1hNSAKCSAgICAgQ3ljbGUgdGltZTogbWluPTEyMG5zIHJlY29tbWVuZGVk
PTEyMG5zCglQSU86IHBpbzAgcGlvMSBwaW8yIHBpbzMgcGlvNCAKCSAgICAgQ3ljbGUgdGltZTog
bm8gZmxvdyBjb250cm9sPTM4M25zICBJT1JEWSBmbG93IGNvbnRyb2w9MTIwbnMKQ29tbWFuZHMv
ZmVhdHVyZXM6CglFbmFibGVkCVN1cHBvcnRlZDoKCSAgICAJUEFDS0VUIGNvbW1hbmQgZmVhdHVy
ZSBzZXQKCSAgICAJREVWSUNFX1JFU0VUIGNvbW1hbmQKCSAgICoJTWFuZGF0b3J5IEZMVVNIX0NB
Q0hFCgkgICAqCVNBVEEtSSBzaWduYWxpbmcgc3BlZWQgKDEuNUdiL3MpCgkgICAqCVNvZnR3YXJl
IHNldHRpbmdzIHByZXNlcnZhdGlvbgoKL2Rldi9jZHJvbToKCkFUQVBJIENELVJPTSwgd2l0aCBy
ZW1vdmFibGUgbWVkaWEKCU1vZGVsIE51bWJlcjogICAgICAgTElURS1PTiBEVkRSVyBMSC0yMEEx
UyAgICAgICAgICAgICAgICAgIAoJU2VyaWFsIE51bWJlcjogICAgICAKCUZpcm13YXJlIFJldmlz
aW9uOiAgOUwwOCAgICAKU3RhbmRhcmRzOgoJVXNlZDogQVRBUEkgZm9yIENELVJPTXMsIFNGRi04
MDIwaSwgcjIuNQoJU3VwcG9ydGVkOiBDRC1ST00gQVRBUEktMiAKQ29uZmlndXJhdGlvbjoKCURS
USByZXNwb25zZTogNTB1cy4KCVBhY2tldCBzaXplOiAxMiBieXRlcwpDYXBhYmlsaXRpZXM6CglM
QkEsIElPUkRZKGNhbiBiZSBkaXNhYmxlZCkKCURNQTogKnNkbWEwICpzZG1hMSAqc2RtYTIgc2Rt
YTMgc2RtYTQgc2RtYTcgbWRtYTAgbWRtYTEgbWRtYTIgdWRtYTAgdWRtYTEgdWRtYTIgdWRtYTMg
dWRtYTQgKnVkbWE1ICg/KQoJICAgICBDeWNsZSB0aW1lOiBtaW49MTIwbnMgcmVjb21tZW5kZWQ9
MTIwbnMKCVBJTzogcGlvMCBwaW8xIHBpbzIgcGlvMyBwaW80IAoJICAgICBDeWNsZSB0aW1lOiBu
byBmbG93IGNvbnRyb2w9MTIwbnMgIElPUkRZIGZsb3cgY29udHJvbD0xMjBucwpDb21tYW5kcy9m
ZWF0dXJlczoKCUVuYWJsZWQJU3VwcG9ydGVkOgoJICAgKglQQUNLRVQgY29tbWFuZCBmZWF0dXJl
IHNldAoJICAgKglERVZJQ0VfUkVTRVQgY29tbWFuZAoJICAgKglNYW5kYXRvcnkgRkxVU0hfQ0FD
SEUKCSAgICoJU0FUQS1JIHNpZ25hbGluZyBzcGVlZCAoMS41R2IvcykKCSAgICoJSG9zdC1pbml0
aWF0ZWQgaW50ZXJmYWNlIHBvd2VyIG1hbmFnZW1lbnQKCSAgICoJUGh5IGV2ZW50IGNvdW50ZXJz
CgkgICAgCURldmljZS1pbml0aWF0ZWQgaW50ZXJmYWNlIHBvd2VyIG1hbmFnZW1lbnQKCSAgICoJ
dW5rbm93biA3OFs1XQoJICAgKglTb2Z0d2FyZSBzZXR0aW5ncyBwcmVzZXJ2YXRpb24KCi9kZXYv
Y2Ryb206CgpBVEFQSSBDRC1ST00sIHdpdGggcmVtb3ZhYmxlIG1lZGlhCglNb2RlbCBOdW1iZXI6
ICAgICAgIFBMRVhUT1IgRFZEUiAgIFBYLTcxNkEgICAgICAgICAgICAgICAgICAKCVNlcmlhbCBO
dW1iZXI6ICAgICAgMTcxOTU2CglGaXJtd2FyZSBSZXZpc2lvbjogIDEuMDggICAgClN0YW5kYXJk
czoKCUxpa2VseSB1c2VkIENELVJPTSBBVEFQSS0xCkNvbmZpZ3VyYXRpb246CglEUlEgcmVzcG9u
c2U6IDUwdXMuCglQYWNrZXQgc2l6ZTogMTIgYnl0ZXMKQ2FwYWJpbGl0aWVzOgoJTEJBLCBJT1JE
WShjYW4gYmUgZGlzYWJsZWQpCglETUE6IG1kbWEwIG1kbWExIG1kbWEyIHVkbWEwIHVkbWExIHVk
bWEyICp1ZG1hMyB1ZG1hNCAKCSAgICAgQ3ljbGUgdGltZTogbWluPTEyMG5zIHJlY29tbWVuZGVk
PTEyMG5zCglQSU86IHBpbzAgcGlvMSBwaW8yIHBpbzMgcGlvNCAKCSAgICAgQ3ljbGUgdGltZTog
bm8gZmxvdyBjb250cm9sPTEyMG5zICBJT1JEWSBmbG93IGNvbnRyb2w9MTIwbnMKSFcgcmVzZXQg
cmVzdWx0czoKCUNCTElELSBiZWxvdyBWaWgKCURldmljZSBudW0gPSAwCg==

------_=_NextPart_001_01C81C17.A278311E--
