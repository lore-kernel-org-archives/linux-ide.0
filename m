From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Wed, 09 Feb 2011 10:04:00 +0000
Message-ID: <4D526690.50205@mrc-lmb.cam.ac.uk>
References: <4D3EA771.3070206@mrc-lmb.cam.ac.uk> <20110125105049.GQ27510@htj.dyndns.org> <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk> <20110126101119.GE12520@htj.dyndns.org> <4D4693DB.4070009@mrc-lmb.cam.ac.uk> <20110131105322.GE7459@htj.dyndns.org> <4D46A8D3.3000807@mrc-lmb.cam.ac.uk> <20110131132430.GH7459@htj.dyndns.org> <4D4BEC87.9090006@mrc-lmb.cam.ac.uk> <4D512616.1060503@mrc-lmb.cam.ac.uk> <20110209094339.GB3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:54486 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1BIKED (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 05:04:03 -0500
In-Reply-To: <20110209094339.GB3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> Since I need to plug my new Via card back in anyway, I'll rerun the old
>> kernel with that just to see whether it still shows the problem when the
>> PATA drive is not in the system.
> 
> Alright, let us know if you encounter problems.

I returned the borrowed Sil card and plugged my new Via card back in
again and now see no problems even with the old kernel. That's with no
PATA disk in the system any longer, So it looks like having a PATA drive
plugged in to the motherboard is a precondition for the bus errors on
the adapter cards.

Too many variables, my head hurts. But at least it seems there are no
outstanding problems from this scenario going forward.

Cheers, Dave
