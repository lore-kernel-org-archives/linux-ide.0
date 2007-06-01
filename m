From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.22-rc3
Date: Fri, 01 Jun 2007 12:50:42 -0400
Message-ID: <46604E62.1000105@pobox.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>  <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>  <46599E6B.1000209@pobox.com>  <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>  <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>  <9d2cd630705271315x7030c91ew2f175c921c022880@mail.gmail.com>  <465AA536.6080608@gmail.com> <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com> <465BF244.5080200@gmail.com> <alpine.LFD.0.98.0705290924350.26602@woody.linux-foundation.org> <465F6F48.8080804@gmail.com> <alpine.LFD.0.98.0705311830360.26602@woody.linux-foundation.org> <465F8230.2040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53568 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760941AbXFAQur (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jun 2007 12:50:47 -0400
In-Reply-To: <465F8230.2040105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Most BIOSen, Windows and old IDE driver don't reset at all during
> probing.  They first issue IDENTIFY unconditionally, if that fails,
> IDENTIFY_PACKET.  From the beginning, libata has issued reset during

Not true for BIOS.  A large sub-section of BIOS (Phoenix and/or 
Award-based BIOSen) do SRST along with the Hale Landis device detection 
(ata_devchk in libata-core.c).  Ditto for several ATA vendor BIOS found 
on the card.

I'm about to dive into some heads-down RHEL backporting (whee), so I 
cannot look at the code in depth this weekend, but here are my basic 
thoughts:

* We knew there would be fallout from the new reset-sequence code, and 
this is clearly in that category.

* It worked before #reset-seq merge AFAICT, which implies the old method 
of probing -- which included SRST -- worked.

* If this was a major problem, I would think there would be a flood of 
bug reports for Fedora 7 (just released, and in testing w/ #reset-seq 
for a little while), since it is using libata for PATA as well as SATA. 
  So this, just this one bug report right?


I would go back and look at the differences in the low-level register 
bitbanging, and what specifically changed there.  If the old stuff 
worked, that tends to imply a problem with the new stuff...

	Jeff


