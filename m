From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: PMP and Smart Enclosure ...
Date: Tue, 29 Mar 2011 00:46:42 +0200
Message-ID: <20110328224642.GJ25384@MAIL.13thfloor.at>
References: <20110322145440.GA15541@MAIL.13thfloor.at> <20110322152529.GB15541@MAIL.13thfloor.at> <20110328085211.GD16530@htj.dyndns.org> <20110328123623.GD25384@MAIL.13thfloor.at> <20110328160136.GC6736@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:41469 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab1C1Wqq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2011 18:46:46 -0400
Content-Disposition: inline
In-Reply-To: <20110328160136.GC6736@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Mon, Mar 28, 2011 at 06:01:36PM +0200, Tejun Heo wrote:
> On Mon, Mar 28, 2011 at 02:36:23PM +0200, Herbert Poetzl wrote:
>> sure, any specific debug options and/or config settings
>> you want me to use for the test?

> CONFIG_PRINTK_TIME would be nice.

http://vserver.13thfloor.at/Stuff/SATAPMP/dmesg_2.6.38.txt

note that it seems to be fixed in 2.6.38.2, I'm now
checking 2.6.38.1 as well to narrow down what fixed
it ...

thanks,
Herbert

> Thanks.

> -- 
> tejun
