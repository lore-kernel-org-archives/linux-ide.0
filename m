From: Mark Lord <mlord@pobox.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 10:15:30 -0400
Message-ID: <44FD8682.1070305@pobox.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com> <44FD84E8.8000705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:1738 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S965069AbWIEOPh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2006 10:15:37 -0400
In-Reply-To: <44FD84E8.8000705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

ata_port_wait_eh

Tejun Heo wrote:
> ..
> For Ric's case, I'm waiting for more info.  If EH is looping forever 
> without reporting to upper layer, it definitely needs fixing, but I 
> don't think that's the case.

What happens with the loop in ata_port_wait_eh() for a drive
which never succeeds in the reset/reinit phase?

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

