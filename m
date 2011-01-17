From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP SMART error recovery and failure code decoding help
Date: Mon, 17 Jan 2011 14:26:23 +0100
Message-ID: <20110117132623.GD27123@htj.dyndns.org>
References: <20110116163950.GA691@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40925 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab1AQN02 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2011 08:26:28 -0500
Received: by fxm20 with SMTP id 20so6025610fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2011 05:26:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116163950.GA691@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-ide@vger.kernel.org

Hello,

On Sun, Jan 16, 2011 at 08:39:50AM -0800, Marc MERLIN wrote:
> Anyway, the problem happens with both drives that I manually spin down and
> drives that spin down on their own. I think it's not actually a 'real',
> error but more an issue where drives cannot answer some SMART error when
> they are spun down.

It could be that the drives need to spin up to answer the smart
command and the timeout on the smart commands is a bit too short for
that to happen.  Forcing a disk access before issuing the smart
command could work around the problem.

> That said, is it normal/expected for the PMP code to do a full bus reset
> because of a SMART command that couldn't go through?

Yeah, after a timeout, the driver doesn't know what state the
controller / PMP / devices are in, so it's kind of forced to do full
reset.

Thanks.

-- 
tejun
