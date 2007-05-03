From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Thu, 03 May 2007 13:37:03 +0200
Message-ID: <4639C95F.9080507@gmail.com>
References: <463828F6.7020209@jogback.se> <46388862.1020709@gmail.com> <4638928E.60700@jogback.se> <4639A6A3.20001@gmail.com> <4639C1DB.3030501@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:29684 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbXECLhT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 07:37:19 -0400
Received: by wr-out-0506.google.com with SMTP id 76so484054wra
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 04:37:17 -0700 (PDT)
In-Reply-To: <4639C1DB.3030501@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

Lars Michael Jogb=E4ck wrote:
> Tejun Heo wrote:
>> I was hoping to see some error logs but no.  Hardware_ECC_Recovered
>> count seems high (385707184) but I dunno whether the value is normal=
 or
>> not.  Different manufacturers use different norms in counting them. =
 If
>> you have other disks of the same model, you can compare the values a=
nd
>> see whether if it's unusually high.
>>  =20
> I think that is normal for that kind of disk. This is another disk bu=
t
> the same model (this one is attached to a 3ware 9500-controller)
> and it shows the same.

I see.

> May  1 23:53:36 cleopatra kernel: ata5.00: tag 0 cmd 0xea Emask 0x4 s=
tat
> 0x40 err 0x0 (timeout)
>=20
> and then it continues with approx 1/hour of the above. So it seems
> something is strange in the interface between the drive and the
> computer. I can swap the drive (it's in an raid5-array) to another dr=
ive
> of the same model if helps in any way; but I suspect that it will sho=
w
> the same result.

The fact that the first slot is always the one causing problem bothers
me.  Can you try to connect the disk to a different controller and use
different power connector?  Let's see to which the problem is attached =
-
disk, port or something else.

--=20
tejun
