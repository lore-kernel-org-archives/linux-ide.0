From: Jens Axboe <axboe@suse.de>
Subject: Re: ide cdrom performance issue
Date: Mon, 6 Oct 2003 09:37:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031006073732.GV966@suse.de>
References: <1065375332.1355.9.camel@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14232 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262781AbTJFHhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Oct 2003 03:37:42 -0400
Content-Disposition: inline
In-Reply-To: <1065375332.1355.9.camel@server>
List-Id: linux-ide@vger.kernel.org
To: Yossi Down-Under <fcp@pop.co.za>
Cc: linux-ide@vger.kernel.org

On Sun, Oct 05 2003, Yossi Down-Under wrote:
> Running RH9 with xcdroast and three recorders each on its own ide
> channel configured for ide-scsi. Having trouble with buffer underruns.
> Am told by xcdroast author that it is a kernel ide driver issue,
> specifically not using dma for transfers and recommended I try a newer
> kernel.
> 
> My question is whether the 2.5.75 kernel is going to improve this
> situation before going to the trouble to install it?

2.5.75?! That kernel is ancient, you should download 2.6-test6 and give
that a try. Note that you should not then use ide-scsi (don't config it
in), and you need to give -dev=/dev/hdc as device argument to cdrecord.
Replace hdc with whatever is your cd-r drive.

-- 
Jens Axboe

