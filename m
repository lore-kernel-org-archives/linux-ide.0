From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide-tape: use time_after(), time_after_eq()
Date: Thu, 1 Dec 2005 12:25:34 +0100
Message-ID: <20051201112533.GV15804@suse.de>
References: <20051130214119.GC12551@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:3924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932158AbVLALYf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 06:24:35 -0500
Content-Disposition: inline
In-Reply-To: <20051130214119.GC12551@mipter.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Gadi Oxman <gadio@netvision.net.il>, Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Thu, Dec 01 2005, Alexey Dobriyan wrote:
> From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
> 
> They deal with wrapping correctly and are nicer to read.

The wrapping is actually dealt with just fine in the code you replace
there, however it is nicer/easier to read with the time_* macros.

-- 
Jens Axboe

