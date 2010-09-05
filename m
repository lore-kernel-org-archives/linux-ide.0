From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: fix hang on failed softreset
Date: Sun, 05 Sep 2010 16:39:42 -0400
Message-ID: <4C84000E.1050906@garzik.org>
References: <4C7780BB.6030604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62808 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0IEUjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Sep 2010 16:39:46 -0400
Received: by qyk36 with SMTP id 36so1823317qyk.19
        for <linux-ide@vger.kernel.org>; Sun, 05 Sep 2010 13:39:46 -0700 (PDT)
In-Reply-To: <4C7780BB.6030604@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anssi Hannula <anssi.hannula@iki.fi>, Gwendal Grignou <gwendal@google.com>, stable <stable@kernel.org>

On 08/27/2010 05:09 AM, Tejun Heo wrote:
> ahci_do_softreset() compared the current time and deadline in reverse
> when calculating timeout for SRST issue.  The result is that if
> @deadline is in future, SRST is issued with 0 timeout, which hasn't
> caused any problem because it later waits for DRDY with the correct
> timeout.  If deadline is already exceeded by the time SRST is about to
> be issued, the timeout calculation underflows and if the device
> doesn't respond, timeout doesn't trigger for a _very_ long time.
>
> Reverse the incorrect comparison order.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Anssi Hannula<anssi.hannula@iki.fi>
> Tested-by: Gwendal Grignou<gwendal@google.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libahci.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied, good catch, sorry for the delay.


