From: Mark Lord <liml@rtr.ca>
Subject: Re: Very old IDE hard drive (240 MB) detected as 1.1 TB
Date: Sat, 14 Feb 2009 09:25:07 -0500
Message-ID: <4996D443.4060103@rtr.ca>
References: <200902131428.40212.hanno@hboeck.de> <499584FC.2050104@gmail.com> <200902141352.24277.hanno@hboeck.de> <4996C563.9090900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753205AbZBNOZ1@vger.kernel.org>
In-Reply-To: <4996C563.9090900@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
>=20
> Hanno B=C3=B6ck wrote:
>=20
>>> That would be worth investigating, yes.. If you can provide the dme=
sg
>>> output from bootup, as well as the output of hdparm --Istdout on th=
e
>>> disk device, that would be useful..
>>>    =20
>>
>> That (and a bit more, normal hdparm output, smartctl output) here:
>> http://files.hboeck.de/conner/
>>  =20
>=20
>   It has the current capacity in words 57-58 swapped:
>=20
> /dev/sdb:
> 0c5a 037f 0000 000a 8723 0275 0037 0030
> 000a 0000 2020 2020 2020 2020 2020 424d
> 3948 4d31 5020 2020 0003 0040 0004 302e
> 3336 2020 2020 436f 6e6e 6572 2050 6572
> 6970 6865 7261 6c73 2032 3430 4d42 202d
> 2043 5033 3032 3534 2020 2020 2020 8010
> 0000 0001 0000 0200 0202 0001 037f 000a
> 0037 0007 82da 0000 0000 0000 0000 0000
>=20
>=20
>   It must be 82da 0007, not 0007 82da.
>   IIRC, the IDE core doesn't trust the value reported in these words=20
=2E.

That's right.  I wrote the IDE code that way
*specifically* due to a (different) Conner drive
I had here at the time.

Cheers
