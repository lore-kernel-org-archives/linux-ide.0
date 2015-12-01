From: Tejun Heo <tj@kernel.org>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Tue, 1 Dec 2015 14:04:10 -0500
Message-ID: <20151201190410.GA21252@mtj.duckdns.org>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35572 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbbLATEN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2015 14:04:13 -0500
Content-Disposition: inline
In-Reply-To: <20151201161715.GA12922@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Tue, Dec 01, 2015 at 11:17:15AM -0500, Tejun Heo wrote:
> So, I suppose this is a fallout from 9faa643855df ("libata: use
> READ_LOG_DMA_EXT").  The description just says "we should try use it"
> but is there any benefit from using NCQ variant of read log page?  I
> mean, it's used during config and error handling, so it's not like
> queueing is gonna help anything.  It ends up issuing NCQ commands on
> controllers which don't support NCQ and causes failures on devices
> which lie about supporting the feature.

Hmmm... so, the controller locks up on READ_LOG_EXT issued as pio?
That's just weird.  I suppose you can blacklist the controller so that
any attempt to read the log page fails without actually issuing the
command.

Thanks.

-- 
tejun
