From: "Kristin Vadas Marsicano" <kristin.marsicano@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 14:49:46 -0500
Message-ID: <7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	 <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:13846 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbYAKTtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 14:49:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1937369wah.23
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 11:49:47 -0800 (PST)
In-Reply-To: <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Both laptops have IDE drives.  The kernel image booted on the two
laptops are exactly the same.  Please let me know if this doesn't
answer your question -- I'm new to this and not quite sure I
understand the question.

Thanks for the quick reply!

On 1/11/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I have the same kernel and configuration on my Dell D600 (an older
> > version of the same laptop), and hdparm =96d works just fine.
>
> We you using the IDE driver for PATA devices and the SATA driver for =
SATA
> devices ? If so the really nasty hacks for that were dropped as curre=
nt
> libata PATA support is more than good enough for driving both ports a=
nd
> having one driver for both cleaned up stuff a lot.
>
> Alan
>


--=20
Kristin Vadas Marsicano
kristin.marsicano@gmail.com
kristinisme.blogspot.com
