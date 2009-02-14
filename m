From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Very old IDE hard drive (240 MB) detected as 1.1 TB
Date: Sat, 14 Feb 2009 16:21:39 +0300
Message-ID: <4996C563.9090900@ru.mvista.com>
References: <200902131428.40212.hanno@hboeck.de> <499584FC.2050104@gmail.com> <200902141352.24277.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:19956 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751596AbZBNNVt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Feb 2009 08:21:49 -0500
In-Reply-To: <200902141352.24277.hanno@hboeck.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Hanno_B=F6ck?= <hanno@hboeck.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Hello.

Hanno B=F6ck wrote:

>> That would be worth investigating, yes.. If you can provide the dmes=
g
>> output from bootup, as well as the output of hdparm --Istdout on the
>> disk device, that would be useful..
>>    =20
>
> That (and a bit more, normal hdparm output, smartctl output) here:
> http://files.hboeck.de/conner/
>  =20

   It has the current capacity in words 57-58 swapped:

/dev/sdb:
0c5a 037f 0000 000a 8723 0275 0037 0030
000a 0000 2020 2020 2020 2020 2020 424d
3948 4d31 5020 2020 0003 0040 0004 302e
3336 2020 2020 436f 6e6e 6572 2050 6572
6970 6865 7261 6c73 2032 3430 4d42 202d
2043 5033 3032 3534 2020 2020 2020 8010
0000 0001 0000 0200 0202 0001 037f 000a
0037 0007 82da 0000 0000 0000 0000 0000


   It must be 82da 0007, not 0007 82da.
   IIRC, the IDE core doesn't trust the value reported in these words=20
(and I have knowledge of some other old disks reporting a bogus value=20
there), but liabata does (naively :-).

MBR, Sergei


