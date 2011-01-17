From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP SMART error recovery and failure code decoding help
Date: Mon, 17 Jan 2011 18:12:09 +0100
Message-ID: <20110117171209.GH27123@htj.dyndns.org>
References: <20110116163950.GA691@merlins.org>
 <20110117132623.GD27123@htj.dyndns.org>
 <20110117164340.GD27342@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38239 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab1AQRMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2011 12:12:14 -0500
Received: by fxm20 with SMTP id 20so6263397fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2011 09:12:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110117164340.GD27342@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 17, 2011 at 08:43:40AM -0800, Marc MERLIN wrote:
> > It could be that the drives need to spin up to answer the smart
> > command and the timeout on the smart commands is a bit too short for
> > that to happen.  Forcing a disk access before issuing the smart
> > command could work around the problem.
>  
> Right, although the idea is of course to keep the drives spun down :)
> I haven't been able to find which SMART call is causing those errors yet.
> Does cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 translate to anything useful?

That's SMART ENABLE OPERATIONS.  It turns on SMART.

> > > That said, is it normal/expected for the PMP code to do a full bus reset
> > > because of a SMART command that couldn't go through?
> > 
> > Yeah, after a timeout, the driver doesn't know what state the
> > controller / PMP / devices are in, so it's kind of forced to do full
> > reset.
> 
> Fair enough. I guess it's one of the downsides of PMP.

The device would still be reset even if it's attached directly.  The
only different is that everything under PMP is reset together instead
of individual ones.

Thanks.

-- 
tejun
