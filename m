From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Wed, 9 Feb 2011 10:43:39 +0100
Message-ID: <20110209094339.GB3770@htj.dyndns.org>
References: <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
 <20110125105049.GQ27510@htj.dyndns.org>
 <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
 <20110126101119.GE12520@htj.dyndns.org>
 <4D4693DB.4070009@mrc-lmb.cam.ac.uk>
 <20110131105322.GE7459@htj.dyndns.org>
 <4D46A8D3.3000807@mrc-lmb.cam.ac.uk>
 <20110131132430.GH7459@htj.dyndns.org>
 <4D4BEC87.9090006@mrc-lmb.cam.ac.uk>
 <4D512616.1060503@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55224 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab1BIJnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 04:43:45 -0500
Received: by fxm20 with SMTP id 20so7207243fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 01:43:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D512616.1060503@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Tue, Feb 08, 2011 at 11:16:38AM +0000, Dave Howorth wrote:
> Hmm, Things are not quite so clear cut. Yesterday, with the Sil card
> still in the system, I happened to reboot the original unpatched 2.6.32
> kernel and unfortunately everything worked perfectly!
> 
> So there must be some other factor involved. Most likely is that after
> running the main batch of tests I have removed an old PATA drive from
> the system, which was connected to the mainboard. It's also
> theoretically possible of course that every other time I tested the
> system I systematically misaligned a SATA cable when running the old
> kernel or somesuch. Anyway, I no longer have a failing test case for the
> Sil card.

Hmmm... interesting.

> Since I need to plug my new Via card back in anyway, I'll rerun the old
> kernel with that just to see whether it still shows the problem when the
> PATA drive is not in the system.

Alright, let us know if you encounter problems.

> PS I guess since I haven't heard from you recently, it might be
> appropriate to wish you Happy New Year!

Happy new year!

-- 
tejun
