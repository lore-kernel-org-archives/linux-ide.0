From: Mark Lord <liml@rtr.ca>
Subject: Re: Bug or HW? ata1: command timeout, stat 0x50 host_stat 0x4
Date: Tue, 04 Jul 2006 11:31:27 -0400
Message-ID: <44AA89CF.7000404@rtr.ca>
References: <20060627184320.GA16782@planetzork.ping.de> <44A222CB.1080300@gmail.com> <20060628080912.GA18463@planetzork.ping.de> <20060702000706.GA11103@planetzork.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:5251 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751256AbWGDPb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jul 2006 11:31:28 -0400
In-Reply-To: <20060702000706.GA11103@planetzork.ping.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jochen Heuer <jogi-kernel@planetzork.ping.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jochen Heuer wrote:
> On Wed, Jun 28, 2006 at 10:09:12AM +0200, Jochen Heuer wrote:
..
> also not increasing ... Are there any known issues in this area with SMP
> kernels?

Mmm.. there was another thread in lkml about the A8V, where somebody
reported that turning *off* CONFIG_PREEMPT results in much more stable
libata operation for some users.

I have an A8V here, but have not yet put a modern Linux installation onto it.

Cheers
