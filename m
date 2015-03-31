From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] sata_mv: Manage SATA port multiplier while searching
 for active links
Date: Tue, 31 Mar 2015 09:15:22 +0200
Message-ID: <551A498A.2010008@free-electrons.com>
References: <1427736765-846-1-git-send-email-gregory.clement@free-electrons.com> <20150330173515.GC9974@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48039 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751413AbbCaHP0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2015 03:15:26 -0400
In-Reply-To: <20150330173515.GC9974@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hi Tejun,

On 30/03/2015 19:35, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 30, 2015 at 07:32:45PM +0200, Gregory CLEMENT wrote:
>> From: Nadav Haklai <nadavh@marvell.com>
>>
>> With this patch, when searching for active link, first search through
>> the port multiplier links. And then fall to the default ap active_tag
>> only if no there is no active link in the port multiplier.
> 
> What does this fix?  What was broken before?  What's the impact of the
> patch?  A patch description which just restates the patch content
> isn't all that useful.

I _thought_ that the purpose of this patch was to manage the port multiplier,
and without this patch we don't only handle it. I will ask more detail and
come back with a new version of the patch with a more useful description.

Thanks,

Gregory



> 
> Thanks.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
