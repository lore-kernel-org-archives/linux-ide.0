From: Tejun Heo <tj@kernel.org>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 16:10:57 +0900
Message-ID: <48609E01.1050802@kernel.org>
References: <023701c8d4dd$d737fa10$85a7ee30$@com> <485F6830.1040000@pobox.com> <485F7356.5050605@kernel.org> <48609C8F.90805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55558 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYFXHLc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 03:11:32 -0400
In-Reply-To: <48609C8F.90805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Milo Medin <medin@m2znetworks.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> The 7042 is the best of the Marvell chips, for Linux.
>>
>> How high does it go bandwidth-wise?
> ..
> 
> The limiting factor will be the bus width of the card
> and the slot into which it is plugged, I suspect.
> 
> There are 4-lane PCIe cards out there, and one of those
> in a 4-lane ("4X") or wider PCIe slot ought to have no
> real limitations due to the 7042 side of things.

Cool.  I was asking because sil3124 and 32 seem to have inherent
bandwidth limit regardless of the bus it lives on.  I'm planning on
checking out 3132-2 chips to see whether they improved on that front.

Thanks.

-- 
tejun
