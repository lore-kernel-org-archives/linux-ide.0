From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Thu, 19 Apr 2007 09:18:20 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704190915320.30549@yvahk01.tjqt.qr>
References: <88SeR-5Sf-15@gated-at.bofh.it> <88Sov-662-3@gated-at.bofh.it>
 <88SHV-6uL-29@gated-at.bofh.it> <8agVk-3wc-81@gated-at.bofh.it>
 <8b3IR-4mE-25@gated-at.bofh.it> <8b3SA-4z3-5@gated-at.bofh.it>
 <8b42g-51N-15@gated-at.bofh.it> <8bbdm-7iS-27@gated-at.bofh.it>
 <E1He8dA-0000mw-LI@be1.lrz> <46260981.1040109@gmail.com>
 <20070418132904.3322ba5f@the-village.bc.nu> <46261337.3010406@gmail.com>
 <20070418140346.636879a1@the-village.bc.nu> <46261F92.2080607@seclark.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:54987 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbXDSHcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Apr 2007 03:32:16 -0400
In-Reply-To: <46261F92.2080607@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>


On Apr 18 2007 09:39, Stephen Clark wrote:
>>
> So this is the pop I hear on my new laptop that is using
> libata=combined_mode when I shut my system down. I didn't get the
> pop with the same disk drive in an older laptop that was only ide.
> It sounds like a relay closing or opening, but is really my drive
> head doing an emergency retract/park?

Most(?) disks' heads are spring-/power-based so that whenever
they lose power, the spring retracts the head back to the park zone.

Whether it is the disk head or something else.. take out the disk,
and retry. Might not be that easy with laptops, though.


Jan
-- 
