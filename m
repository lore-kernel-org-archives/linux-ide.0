From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: sx8 driver
Date: Thu, 2 Mar 2006 17:08:24 +0200
Message-ID: <5d96567b0603020708w4ec17f78m89f43541a12c1547@mail.gmail.com>
References: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>
	 <440702BB.2000707@pobox.com>
	 <5d96567b0603020640w4a93a67bt7c5c8c3aaeb2c637@mail.gmail.com>
	 <440704D9.5080502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:37646 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751183AbWCBPIZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 10:08:25 -0500
Received: by wproxy.gmail.com with SMTP id 69so426394wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Mar 2006 07:08:24 -0800 (PST)
In-Reply-To: <440704D9.5080502@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I looked at the promise spec for SataII 150 sx8 .
i must confess i am a bit confused.
you say it has ncq support in your list,
they say they support only tcq.

Am i worng ?

thanks
raz

On 3/2/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Raz Ben-Jehuda(caro) wrote:
> > it is in the promise we site. just google for it.
> > http://www.promise.com/support/download/download2_eng.asp?productID=125&category=all&os=100
>
> Well poke Promise to fix...  The kernel has a driver that isn't broken
> and works on all architectures.  One grep of the Promise driver for
> VIRT_TO_BUS() tells me they haven't fixed any of the bugs in there.
>
>         Jeff
>
>
>
>


--
Raz
