From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under kernel 2.6.18
Date: Sun, 08 Oct 2006 14:19:16 +0100
Message-ID: <op.tg3tyekpxci36i@akima>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------cWHS15Wly1j0xsOXPcFGAg
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11985 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751136AbWJHNTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 09:19:15 -0400
Received: by ug-out-1314.google.com with SMTP id o38so485574ugd
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 06:19:13 -0700 (PDT)
In-Reply-To: <45287FA6.5020906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

------------cWHS15Wly1j0xsOXPcFGAg
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: Quoted-Printable

On Sun, 08 Oct 2006 05:33:42 +0100, Tejun Heo <htejun@gmail.com> wrote:

> Hello.
>
> Jonathan Bell wrote:
>> The problem is that when copying a file off one drive on the controll=
er  =

>> to
>> another on the same controller, be it via dd or cp, the file that get=
s
>> written becomes corrupted along with the filesystem itself. Here is a=
n
>> extract from dmesg:
>
> That's very weird.
>
>> [12689.451466] attempt to access beyond end of device
>> [12689.451475] sdb1: rw=3D0, want=3D2339438600, limit=3D488392002
>> [12689.451480] attempt to access beyond end of device
>> [12689.451484] sdb1: rw=3D0, want=3D18446744056529747976, limit=3D488=
392002
>> [12689.453822] attempt to access beyond end of device
>> [12689.453831] sdb1: rw=3D0, want=3D2339438600, limit=3D488392002
>> [12689.453834] Buffer I/O error on device sdb1, logical block 2924298=
24
>> [12689.453935] attempt to access beyond end of device
>> [12689.453938] sdb1: rw=3D0, want=3D2339438600, limit=3D488392002
>> [12689.453941] Buffer I/O error on device sdb1, logical block 2924298=
24
> [--snip--]
>> I would like some help tracking down the cause of this problem as I h=
ave
>> practically exhausted the methods currently at my disposal - my best =
 =

>> guess
>> at the moment is that data being written to another port is being  =

>> trampled
>> on somehow but only when there is I/O active on another port. I will
>> continue testing to see if simultaneous writes to multiple drives on =
a
>> controller causes the same problem.
>
> Can you repeat the test using raw devices - /dev/sdX?  I don't think  =

> filesystem is at fault, so let's rule it out.  Also, please post the  =

> result of lspci -nvvvxxx
>
> Thanks.
>


See attached for the lspci output.

I have confirmed the problem still happens with the following command:

yes 0123456789 | dd of=3D/dev/sda1 & dd if=3D/dev/sdb1 of=3D/dev/null &

I killed it after a while, then did "uniq /dev/sda1"

The results were.... interesting - instead of just 0123456789 I ended up=
  =

with a whole load of variations on the theme of "0123456789". Attached i=
s  =

an extract. While this proved the problem still is there I don't really =
 =

know how to send you any useful information without sending you a ~256  =

megabyte dump of /dev/sda1 (compressed it is still approximately 1.8MB)

 From the looks of things the corruptions are few and far between - I  =

wouldn't know how to check how often they occur or what length they are =
 =

though.

Also, I probed the validity of the "Buffer I/O error" and found that the=
  =

logical block wasn't actually corrupted - dd read it just fine - it was =
 =

full of 0x00 (from badblocks I guess).


------------cWHS15Wly1j0xsOXPcFGAg
Content-Disposition: attachment; filename=lspci2.txt.gz
Content-Type: application/x-gzip; name=lspci2.txt.gz
Content-Transfer-Encoding: Base64

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
Mig6lgAA
------------cWHS15Wly1j0xsOXPcFGAg
Content-Disposition: attachment; filename=uniq.txt.gz
Content-Type: application/x-gzip; name=uniq.txt.gz
Content-Transfer-Encoding: Base64

H4sICEr5KEUAA3VuaXEudHh0AK1XO2wTQRAdbCJsJyYOKB9wIuxEMQm/nB0MWCB0
QrQoCUIIqEwKGhpaOgsaRIMRSAjRuEEBKoMEtUsEEroGOsQV0CKno+R2hzvWs7N7
PoSbmX33dmZ253Nnp1pbPV4/cfJUI+dIFfw7GShB8MugbP1Z9zbSlCtV8LfSSHiz
S0iVQ7mhSgGVw7iIVGh9rmNw2WUhVY55Gxd1qBofgftpSrryr2WlbF44JCThckY1
iK7Bfx9xuGM2ciEAzo8JKATeb/1E6Z1NG47C2aFyYBsFVA7jwmafcLnwQoU+o5vV
TZodDdAdcRGZcqzlpVVJhRCbFqdK1yqHLaPCy2MycYWHM0Ly6WarRKj2KnGq1Ah0
b49YXAQqeJVpDGgzi7I5ynAjg/0PK4KmG/vbKJfqgmHtAO2qVdUab9Dz5/bIQH1v
Tsr+9kFsiXTWuM1m0uqtYQqUh0MA3Kt5GZR7LyNl7+PYUCWncoxBUwDa7kT8VUP/
1zhe2OV9UsJilp/gro8jvrR9FKfriyKOvLkie1Hg3U9Ji+v1vVI6m+ih/3inLdFD
9uZQM7UOOwKPKRHmlVVaodaZGgLQfbUgoy69HdNiAPg6Lx821/K0ujljOXNFqSvz
7ZhKMqbAAa47Ir64qRy9UDrpJcFXOYwLUwY12HQeYxEM3nLny6x9XEXJaj/AEivV
ikLSF5Y+uUKEEmJHumkkxbapUOla5Zi3Rdn0lw/LU3amZ7Ch1iZ5b9EoWG8thffx
H4duw/aMf6RNFefugpC8Geh9q+AJn2CfdQqzsUUQbYbX+O7y5su2U/zDATlubPNq
wOBFNLf2y2jbN0el7E7laQsmeEUly5vKMW8bAI3HjOussIhbz4+AK/453CijPL8i
JbxLMPuE1GCtxkpPcSp444ums1EAeqdHsPKe7bbcJAVi3ln6WKkxH4T2QhGqBrDB
cWFbgjOVDAtzoJDDV+RwM0+DTFFylWE0on/6qdutvZM044n+5gQqNM9g4fUelaVs
fZ/E9cUD9mmccMZRQN1Dub8BrSqNMQAQAAA=

------------cWHS15Wly1j0xsOXPcFGAg--

