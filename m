From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_via bus errors fixed?
Date: Mon, 31 Jan 2011 11:53:22 +0100
Message-ID: <20110131105322.GE7459@htj.dyndns.org>
References: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
 <20110124170432.GH27510@htj.dyndns.org>
 <4D3EA771.3070206@mrc-lmb.cam.ac.uk>
 <20110125105049.GQ27510@htj.dyndns.org>
 <4D3FF0D9.5040006@mrc-lmb.cam.ac.uk>
 <20110126101119.GE12520@htj.dyndns.org>
 <4D4693DB.4070009@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1AaKx1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2011 05:53:27 -0500
Received: by fxm20 with SMTP id 20so5445463fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 31 Jan 2011 02:53:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4693DB.4070009@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 31, 2011 at 10:50:03AM +0000, Dave Howorth wrote:
> (1) stock SUSE HEAD/11.2 (2.6.37) - works fine with no problem
> (2) SUSE 2.6.37 with the 'magic patch' commented out - shows the problem
> (3) stock updated SUSE 11.2 (2.6.31.14) - shows the problem
> (4) stock SUSE 11.2 with the 'magic patch' added (2.6.31.5) - works fine
> with no problem
> 
> I think that's fairly indicative that the 'magic patch' is able to cure
> my problem with a VT 6241A controller and a Samsung HD103SJ drive.

I see, so the via issue was the same FIFO configuration problem.

> One thing I still need to investigate is why Ubuntu 10.04 was showing
> the problem, but perhaps I never got as far as updating the kernel after
> installing it. (AFAIK as installed it is 2.6.31, whilst the current
> update is 2.6.32-28 which I think should have the patch)

Most likely.  So, that leaves the problem sil was seeing.  Are you
interested in digging that down too?

Thank you.

-- 
tejun
