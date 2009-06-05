From: Grozdan <neutrino8@gmail.com>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Fri, 5 Jun 2009 14:43:51 +0200
Message-ID: <c5bd819b0906050543l42320f0r44e0306a7638b1b9@mail.gmail.com>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	 <c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
	 <20090603131407.57c490ed@lxorguk.ukuu.org.uk>
	 <c5bd819b0906030552w6f23185etb394f83c8b630e6@mail.gmail.com>
	 <20090603140140.491a8ea8@lxorguk.ukuu.org.uk>
	 <c5bd819b0906030639o5f9c34ffg500e132d3a0b5117@mail.gmail.com>
	 <c5bd819b0906040750w75e0389cod2a03b89ce838d1b@mail.gmail.com>
	 <20090605100505.41b3b818@lxorguk.ukuu.org.uk>
	 <c5bd819b0906050335i4e813887sc8f4d901da86a1aa@mail.gmail.com>
	 <20090605114245.175499e1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:63265 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZFEMnv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 08:43:51 -0400
In-Reply-To: <20090605114245.175499e1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hancockrwd@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2009/6/5 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> I've relayed your reply to the pata_amd user on the forum. As for my
>> case with pata_via, until this is fixed, is there any way to force i=
t
>> to use a higher UDMA? Is there a flag that can be passed in, for
>
> In your case given the BIOS appears to be informing us you have a 40w=
ire
> cable there isn't much that can be fixed
>
>> example, in /sys somewhere? hdparm fails to set a higher UDMA and I
>> looked at sdparm but don't see anything in it to increase UDMA...
>
> Tejun some time ago added stuff to override all of these things:
>
> See Documentation/kernel-parameters.txt
>
> =A0 =A0 =A0 =A0libata.force=3D
>
> which will let you override all sorts of autodetection for quirky boa=
rds
>

Thanks, I will try out the kernel params. However, I still wonder why
older kernels have no problems setting the correct UDMA while 2.6.30
does have problems. Something must have definitely changed in this
latest kernel. I'll go dig in my BIOS to see if I may need to
change/force something.
