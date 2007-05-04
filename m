From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Fri, 04 May 2007 20:00:59 +0200
Message-ID: <463B74DB.8060509@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:6900 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031457AbXEDSBJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 14:01:09 -0400
Received: by wr-out-0506.google.com with SMTP id 76so982790wra
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 11:01:09 -0700 (PDT)
In-Reply-To: <463B71FA.8090005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

Mat=ED=ADas Alejandro Torres wrote:
>=20
>> Matias, are you still there?  If so, can you please test the attache=
d
>> patch and see whether it fixes your problem - ie. boots okay without
>> 'pci=3Dnomsi'?
>>
>> =20
>> --------------------------------------------------------------------=
----
> I've tried the patch and the kernel showsthe same behaviour. It does =
not
> work without the pci=3Dnomsi parameter.
>=20
> First, i tried with the 2.6.20.10 kernel and it did not work. Then i
> compile the kernel that i had when i start posting (2.6.20.4) but it =
was
> the same.
>=20
> The sata controller mode in the BIOS has been always set to NATIVE-ID=
E.
> The logs corresponding to the 2.6.20.4 has the bios controller mode s=
et
> to AHCI. But... that doesn't matter, does it?
>=20
> I simply patched the kernel, is there any option that i have to enabl=
e
> so the modifications take effect?

Well, making it work without pci=3Dnomsi is the whole point here.  I du=
nno
why this simple thing doesn't work.  Can you post the result of 'lspci
-nn' so that we can see the numeric ID?

--=20
tejun
