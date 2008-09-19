From: raz ben yehuda <razb@bitband.com>
Subject: Re: [PATCH 4/4 v2] Add documentation for hard disk shockprotection
	interface
Date: Fri, 19 Sep 2008 22:03:06 +0200
Message-ID: <1221854586.7473.16.camel@raz>
References: <87d4j2n3dn.fsf@denkblock.local>
	 <20080917163145.9870.8575.stgit@denkblock.local>
	 <1221724782.3261.13.camel@raz>  <87iqssmpl0.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:29807 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754009AbYISUDK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Sep 2008 16:03:10 -0400
In-Reply-To: <87iqssmpl0.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org


On Fri, 2008-09-19 at 11:50 +0200, Elias Oltmanns wrote:
> [ For some reason your email has not shown up on linux-ide. ]
yes. I noticed too.
> "Raz Ben-Yehuda" <razb@bitband.com> wrote:
> > Elias
> > looks very interesting.
> > 1. How will it impact VM , swappers , raids ?  
> 
> What exactly do you want to know? As long as the disk is parked, you can
> do no I/O on it, i.e. no swapping is possible. Since I don't know
> anything about the implementation of raids and don't have a raid setup
> here, I can't really tell how a raid device will behave exactly when one
> of its disks has been parked. Generally, all I/O will be delayed until
> the disk is unparked again.
> > 2. you said it has no value for servers ? did you try ?
> 
> Again, I'm not quite sure what you want to know. Obviously, desktops or
> servers for that matter can have disks installed that support the unload
> feature. On these devices you can use the interface as described in my
> document. All I'm saying is that the interface has been designed with
> laptops in mind because I don't see in which situation immediate head
> unloading would be required or even desirable in a classical server
> environment.
I will rephrase. does head parking increase reliability ( MTBF ... MTTF ) of a disk ? 
My servers hardly generate IOs at night times, does head parking at nights extend 
the life of a disk ? or is it the opposite ? does it matter ?
thank you again
raz

> Regards,
> 
> Elias
