From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Tue, 08 Feb 2011 11:16:38 +0000
Message-ID: <4D512616.1060503@mrc-lmb.cam.ac.uk>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk> <20110124170432.GH27510@htj.dyndns.org> <4D3EA771.3070206@mrc-lmb.cam.ac.uk> <20110125105049.GQ27510@htj.dyndns.org> <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk> <20110126101119.GE12520@htj.dyndns.org> <4D4693DB.4070009@mrc-lmb.cam.ac.uk> <20110131105322.GE7459@htj.dyndns.org> <4D46A8D3.3000807@mrc-lmb.cam.ac.uk> <20110131132430.GH7459@htj.dyndns.org> <4D4BEC87.9090006@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:46117 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab1BHLQj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 06:16:39 -0500
In-Reply-To: <4D4BEC87.9090006@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Dave Howorth wrote:
> Tejun Heo wrote:
>>> Since we don't yet know whether a recent kernel fixes my sil problem and
>>> if it does we don't have any idea of a particular patch, that suggests
>>> the strategy would be bisection, which probably involves more compiles
>>> than I'm up for.
>> If sil shows the problem, I'll provide debug patches so that you'll
>> only need to build libata and sata_via.
> 
> OK, I fixed my backup system and I feel a bit more relaxed now, so I did
> a quick test. I borrowed the Sil 3512-based card again and ran it with
> Knoppix and also with the SUSE 2.6.37 kernel. Neither of them indicated
> any errors with the drive so I suppose that some change between 2.6.32
> and 2.6.37 has already fixed whatever my problem was with that
> controller. One less thing to worry about.
> 
> I haven't got around to doing any of the other things I mentioned yet :(

Hmm, Things are not quite so clear cut. Yesterday, with the Sil card
still in the system, I happened to reboot the original unpatched 2.6.32
kernel and unfortunately everything worked perfectly!

So there must be some other factor involved. Most likely is that after
running the main batch of tests I have removed an old PATA drive from
the system, which was connected to the mainboard. It's also
theoretically possible of course that every other time I tested the
system I systematically misaligned a SATA cable when running the old
kernel or somesuch. Anyway, I no longer have a failing test case for the
Sil card.

Since I need to plug my new Via card back in anyway, I'll rerun the old
kernel with that just to see whether it still shows the problem when the
PATA drive is not in the system.

Cheers, Dave

PS I guess since I haven't heard from you recently, it might be
appropriate to wish you Happy New Year!
