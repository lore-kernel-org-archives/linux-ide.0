From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: sata_via bus errors fixed?
Date: Mon, 31 Jan 2011 10:50:03 +0000
Message-ID: <4D4693DB.4070009@mrc-lmb.cam.ac.uk>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk> <20110124170432.GH27510@htj.dyndns.org> <4D3EA771.3070206@mrc-lmb.cam.ac.uk> <20110125105049.GQ27510@htj.dyndns.org> <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk> <20110126101119.GE12520@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35403 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab1AaKuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2011 05:50:05 -0500
In-Reply-To: <20110126101119.GE12520@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> There are plenty of howtos on building kernel.  It takes some time to
> get used to but once you get a hang of it there's nothing difficult
> about it.

Hmm, I've finally managed to get the compilation to work often enough to
run my tests but I don't think I'll be taking up kernel compiling as a
hobby :(

> The best way would be finding out a workload which doesn't take too
> much time but reliably triggers the issue on a problematic kernel.

That would be booting then :) The dmesg reliably has or does not have
the error messages.

>> Tonight I plan to compile that kernel, which should confirm that I
>> understand how to do it, and then I'll disable the VIA FIFO workaround
>> as you suggest and see what happens.

OK. So the results are now in:

(1) stock SUSE HEAD/11.2 (2.6.37) - works fine with no problem
(2) SUSE 2.6.37 with the 'magic patch' commented out - shows the problem
(3) stock updated SUSE 11.2 (2.6.31.14) - shows the problem
(4) stock SUSE 11.2 with the 'magic patch' added (2.6.31.5) - works fine
with no problem

I think that's fairly indicative that the 'magic patch' is able to cure
my problem with a VT 6241A controller and a Samsung HD103SJ drive.

One thing I still need to investigate is why Ubuntu 10.04 was showing
the problem, but perhaps I never got as far as updating the kernel after
installing it. (AFAIK as installed it is 2.6.31, whilst the current
update is 2.6.32-28 which I think should have the patch)

Thanks for your help.
Dave
