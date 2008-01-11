From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 19:30:36 +0000
Message-ID: <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55083 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759794AbYAKTc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 14:32:57 -0500
In-Reply-To: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>
Cc: linux-ide@vger.kernel.org

> I have the same kernel and configuration on my Dell D600 (an older
> version of the same laptop), and hdparm =E2=80=93d works just fine.

We you using the IDE driver for PATA devices and the SATA driver for SA=
TA
devices ? If so the really nasty hacks for that were dropped as current
libata PATA support is more than good enough for driving both ports and
having one driver for both cleaned up stuff a lot.

Alan
