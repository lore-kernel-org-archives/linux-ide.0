From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Tue, 27 Mar 2007 14:02:36 +0900
Message-ID: <4608A56C.5020605@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <46089F28.8060803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:44762 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964791AbXC0FCm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 01:02:42 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1797372wra
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 22:02:41 -0700 (PDT)
In-Reply-To: <46089F28.8060803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org, Conke Hu <conke.hu@gmail.com>

Mat=ED=ADas Alejandro Torres wrote:
>=20
>>
>> That's weird.  So, with irqpoll, 2.6.21-rc5 doesn't work while
>> 2.6.20.4 does?  I looked through the changelog but nothing looks
>> suspicious at the first glance.
>>
>> Can you try 'pci=3Dnomsi'?  At first, I though you weren't using MSI=
=2E=20
>> You apparently are.
>>
>=20
> Yes I can. It works too.

Thanks for the detailed reporting.  It seems MSI in those ATI chipsets
are broken.  CC'ing Conke Hu.  Conke Hu, the whole thread is available
at the following URL.  It seems we'll have to fix or disable MSI suppor=
t
in the affected chipsets.  Please advise.

  http://thread.gmane.org/gmane.linux.ide/17516

--=20
tejun
