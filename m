From: Jim Yeh <jimyeh98@acard.com>
Subject: Re: Fw: [PATCH] ahci: add ACard 8620 support (rough draft)
Date: Tue, 14 Apr 2009 10:28:00 +0800
Message-ID: <49E3F4B0.1080909@acard.com>
References: <000d01c9b815$73006700$b500a8c0@JasonWuNB> <49E31219.1000301@acard.com> <49E323E1.90907@garzik.org>
Reply-To: jimyeh98@acard.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:50660 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZDNDCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 23:02:46 -0400
In-Reply-To: <49E323E1.90907@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: jason wu <jason_wu@acard.com>, =?UTF-8?B?IuiOiuaWh+iIiShKYXNvbiBDaHVh?= =?UTF-8?B?bmcpIg==?= <jason@acard.com>, =?UTF-8?B?IumZs+WKm+iqoChSaWNoYXI=?= =?UTF-8?B?ZCBDaGVuKSI=?= <rchern@acard.com>, =?UTF-8?B?Iue/geiMguizgChEYQ==?= =?UTF-8?B?bmllbCBXZW5nKSI=?= <dweng@acard.com>, =?UTF-8?B?IuWQs+S9s+eSiyg=?= =?UTF-8?B?TGF1cmVuY2UgV3UpIg==?= <laurence@acard.com>, =?UTF-8?B?IumZs+W+tw==?= =?UTF-8?B?5aiBKERlcndlaSBDaGVuKSI=?= <derwei@acard.com>, =?UTF-8?B?IumZsw==?= =?UTF-8?B?6YeR5riFKEdlaW5nQ2hpbmcgQ2hlbiki?= <geingching@acard.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@linux-foundation.org, Tejun Heo <htejun@gmail.com>

Dear Jeff,

Thanks for your explanation. We agree with you.

 I'll prepare the hardware for your testing. The form factor of PCB wil=
l=20
be a 32bit PCI-base add-on card. Please advise the address for both of=20
yours. It is expected to be sent by next week.

Regards,
=20
Jim Yeh
Product Manager
Marketing Dept.
ACARD Technology Corp.
TEL:886-2-85122290#3244



Jeff Garzik =E6=8F=90=E5=88=B0:
> Jim Yeh wrote:
>> Dear Jeff,
>>
>> This is Jim,an IC PM from ACARD Technology. Thanks for your effort o=
n=20
>> building Linux driver for ACARD ATP8620. Since ACARD already have a=20
>> verified AHCI driver for ATP8620, we'd like to submit this one for=20
>> the kernel built-in driver (please see attachment). This driver=20
>> support Linux Kernel 2.6.29 AHCI mode for ATP8620 (2ch SATA IC) and=20
>> ATP8624 (4ch SATA IC). It already passed our own stability and=20
>> compatibility test with SATA devices like HDD, ODD, or=20
>> PortMultiplier. If you have any question or need the hardware for=20
>> testing, please don't hesitate to contact me. Thanks again for your=20
>> help.
>
> Thank you for your email.
>
> We understand you have verified your driver, but it is standard Linux=
=20
> driver policy to avoid code duplication.  Multiple implementations of=
=20
> AHCI drivers implies several negative factors:
>
> * each bug fix must be reviewed across multiple AHCI drivers, to=20
> determine if the bug fix must be copied
>
> * non-uniform user experience, depending on AHCI platform
>
> * Shared AHCI code gets much more testing and verification.
>
> * When a hardware vendor's AHCI chip reaches End Of Life, or the=20
> company goes out of business, users are not abandoned.
>
> So, for the official Linux kernel drivers that are shipped by Red Hat=
,=20
> Novell/SuSE, Canonical and other vendors, we will need to modify the=20
> existing Linux AHCI driver to support ATP8620 and ATP8624.
>
>
> And yes -- test hardware would be greatly appreciated!  If you could=20
> send these, that would be appreciated:
>
>     To Tejun Heo
>     ------------
>     1 x ATP8620
>     1 x ATP8624
>
>     To Jeff Garzik
>     --------------
>     1 x ATP8620
>     1 x ATP8624
>
> I assume this is PCI, PCI-X or PCI-Express form factor?
>
> Regards and thanks,
>
>     Jeff
>
>
>
>
>
> __________ Information from ESET NOD32 Antivirus, version of virus=20
> signature database 4005 (20090413) __________
>
> The message was checked by ESET NOD32 Antivirus.
>
> http://www.eset.com
>
>
>
>
