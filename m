From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Mon, 22 Feb 2010 08:41:10 -0600
Message-ID: <51f3faa71002220641n75c52dw661b86a77e44a0a1@mail.gmail.com>
References: <20100220142826.62dd5989@pluto-lenny.milky.way>
	 <4B802B54.1080009@gmail.com> <20100221022613.1096fd12@uranus>
	 <51f3faa71002210922i542c37f0j9e0e4a84d0977f90@mail.gmail.com>
	 <20100221225544.5a9ded51@pluto-lenny.milky.way>
	 <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com>
	 <20100222141802.2bcbf607@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f177.google.com ([209.85.223.177]:55872 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0BVOlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2010 09:41:11 -0500
Received: by iwn7 with SMTP id 7so2137306iwn.4
        for <linux-ide@vger.kernel.org>; Mon, 22 Feb 2010 06:41:10 -0800 (PST)
In-Reply-To: <20100222141802.2bcbf607@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

CCing Rafael, this should be added to the list of known regressions.

On Mon, Feb 22, 2010 at 7:18 AM, Benjamin S. <sbenni@gmx.de> wrote:
>
> On Sun, 21 Feb 2010 16:00:35 -0600
> Robert Hancock <hancockrwd@gmail.com> wrote:
>
>> Hmm.. Well, that's not it then.. I suspect a bisection is likely the
>> easiest route at this point..
>
> fb1e75389bd06fd5987e9cda1b4e0305c782f854 is the first bad commit
> commit fb1e75389bd06fd5987e9cda1b4e0305c782f854
> Author: Jens Axboe <jens.axboe@oracle.com>
> Date: =A0 Thu Jul 30 08:18:24 2009 +0200
>
> =A0 =A0block: improve queue_should_plug() by looking at IO depths
>
> =A0 =A0Instead of just checking whether this device uses block layer
> =A0 =A0tagging, we can improve the detection by looking at the maximu=
m
> =A0 =A0queue depth it has reached. If that crosses 4, then deem it a
> =A0 =A0queuing device.
>
> =A0 =A0This is important on high IOPS devices, since plugging hurts
> =A0 =A0the performance there (it can be as much as 10-15% of the sys
> =A0 =A0time).
>
> =A0 =A0Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
>
>
>
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3Dfb1e75389bd06fd5987e9cda1b4e0305c782f854
>
>
> Without that patch my SSD (Super Talent Ultradrive GX MLC 64GB)
> reaches about 200MB/s sequentiell read. After applying the patch it
> reaches only 70MB/s.
>
>
>
> Note: Added Jens to CC.
>
>
