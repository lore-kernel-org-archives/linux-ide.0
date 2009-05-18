From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.9.29.2: ide-tape: panic when probing device at boot
Date: Mon, 18 May 2009 15:18:13 +0200
Message-ID: <9ea470500905180618t3785d5e1s880c395896b9ba15@mail.gmail.com>
References: <20090509161801.GB5749@liondog.tnic>
	 <200905180532.n4I5Wxa1031243@turbo.physics.adelaide.edu.au>
	 <20090518063007.GA7818@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59979 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbZERNSO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 09:18:14 -0400
In-Reply-To: <20090518063007.GA7818@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Small correction:

>> > > Should I just push commit 1e75540ec5202cae63cd238c86bd880e3d4965=
46
>> > > ("ide-tape: remove back-to-back REQUEST_SENSE detection") to Lin=
us
>> > > or there is more needed to bring ide-tape to the world of living=
?
>> >
>> > The oops will probably fixed the above commit. =A0I don't have muc=
h idea
>> > about the DMA problem on 2.6.24 tho. =A0But even with the above co=
mmit
>> > fixed, I doubt it would work. =A0The buffer allocation code is bro=
ken
>> > and reliably triggered OOM on my test machine. =A0While trying to =
locate
>> > the bug, I realized the complex code didn't do much good to begin =
with
>> > and just stripped it down, so I didn't actually tracked down the
>> > actual bug && the patch to simplify buffer management is way too l=
arge
>> > for 2.6.29, so unless someone is willing to hunt down the bug just=
 for
>> > 2.6.29, we're kind of stuck. =A0:-(
>>
>> So I take it that 2.6.30 (or one of the RCs) is worth trying (at lea=
st in so
>> far as preventing the oops on boot)?
>
> You could try 30-rc6 which runs pretty stable on my machines. It has =
the
> patch mentioned above in it.

the patch mentioned above got actually merged after 30-rc6 so you could=
 try
30-rc7 - if there will be one - or a current linux-next release.

Thanks.

--=20
Regards/Gruss,
Boris
