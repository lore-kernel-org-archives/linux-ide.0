From: Jens Axboe <axboe@suse.de>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Fri, 31 Oct 2003 14:00:41 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031031130041.GI7314@suse.de>
References: <200310301601.55588.schlicht@uni-mannheim.de> <200310301848.19065.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:34208 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263293AbTJaNAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2003 08:00:40 -0500
Content-Disposition: inline
In-Reply-To: <200310301848.19065.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Oct 30 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> [ Jens - IDE TCQ maintainer 8) added to cc: ]

Not really (added, that is :)

> Could you also send dmesg output and retry with vanilla -test9?

It's probably via + tcq, that drive is known good with ide-tcq. At least
I've never seen problems with it.

-- 
Jens Axboe

