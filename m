From: Mark Lord <mlord@pobox.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 09:48:43 -0400
Message-ID: <44FD803B.3040000@pobox.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:32185 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S965069AbWIENsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2006 09:48:51 -0400
In-Reply-To: <44FD662A.6060404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
>
> So, no, libata won't drop a drive unless it fails to respond to recovery 
> sequence.  libata just doesn't have enough information about how devices 
> are used to determine whether a device is failing too often to be useful.

Sure it does.  It can determine the number of consecutive failures on
the same drive/channel, and it can also count intervening successes, if any.

>From that, at a minimum, it could notice that the same drive has gone 'round
the error treadmill (say) 20 times in a row, with no other I/O possible on it
because it has yet to successfully complete the reset+reinit phase.

Such a drive is a candidate for pushing the error upstairs,
and possibly for getting offlined.

Fancier fault-handling is also possible, but the bare minimum is that we
must not get stuck forever looping in the EH code.  Eventually a failed status
has to be returned to the layers above, I think.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

