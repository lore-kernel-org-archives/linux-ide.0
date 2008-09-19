From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/4 v2] Add documentation for hard disk shockprotection interface
Date: Fri, 19 Sep 2008 11:50:51 +0200
Message-ID: <87iqssmpl0.fsf@denkblock.local>
References: <87d4j2n3dn.fsf@denkblock.local>
	<20080917163145.9870.8575.stgit@denkblock.local>
	<1221724782.3261.13.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:45154 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbYISJw3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Sep 2008 05:52:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz Ben-Yehuda <razb@bitband.com>
Cc: linux-ide@vger.kernel.org

[ For some reason your email has not shown up on linux-ide. ]

"Raz Ben-Yehuda" <razb@bitband.com> wrote:
> Elias
> looks very interesting.
> 1. How will it impact VM , swappers , raids ?  

What exactly do you want to know? As long as the disk is parked, you can
do no I/O on it, i.e. no swapping is possible. Since I don't know
anything about the implementation of raids and don't have a raid setup
here, I can't really tell how a raid device will behave exactly when one
of its disks has been parked. Generally, all I/O will be delayed until
the disk is unparked again.

> 2. you said it has no value for servers ? did you try ?

Again, I'm not quite sure what you want to know. Obviously, desktops or
servers for that matter can have disks installed that support the unload
feature. On these devices you can use the interface as described in my
document. All I'm saying is that the interface has been designed with
laptops in mind because I don't see in which situation immediate head
unloading would be required or even desirable in a classical server
environment.

Regards,

Elias
