From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Wed, 26 Jan 2011 11:11:19 +0100
Message-ID: <20110126101119.GE12520@htj.dyndns.org>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
 <20110124170432.GH27510@htj.dyndns.org>
 <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
 <20110125105049.GQ27510@htj.dyndns.org>
 <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46836 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab1AZKLX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2011 05:11:23 -0500
Received: by fxm20 with SMTP id 20so776067fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2011 02:11:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Wed, Jan 26, 2011 at 10:00:57AM +0000, Dave Howorth wrote:
> Just a quick progress note. I'm most familiar with Suse and not familiar
> with kernel builds so last night I installed the pre-built
> Kernel:/HEAD/11.2 kernel from the opensuse build service. It's 2.6.37.

There are plenty of howtos on building kernel.  It takes some time to
get used to but once you get a hang of it there's nothing difficult
about it.  It usually is best to figure out small kernel configuration
which contain everything necessary to bring up the root filesystem and
other important hardware so that you don't have to worry about initrd
and modules.

> It was late so all I did was copy a 1.7 GB file to and from the new disk
> on the VT6241A controller. No errors were logged. Incidentally, what's
> the best way of testing for this type of reliability?

The best way would be finding out a workload which doesn't take too
much time but reliably triggers the issue on a problematic kernel.

> Tonight I plan to compile that kernel, which should confirm that I
> understand how to do it, and then I'll disable the VIA FIFO workaround
> as you suggest and see what happens.

Have fun!

-- 
tejun
