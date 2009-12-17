From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream, v4] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Thu, 17 Dec 2009 01:28:01 -0500
Message-ID: <4B29CF71.7050408@pobox.com>
References: <1260350584.3568.12.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37806 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZLQG2D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:28:03 -0500
Received: by yxe17 with SMTP id 17so1670583yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:28:03 -0800 (PST)
In-Reply-To: <1260350584.3568.12.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 12/09/2009 04:23 AM, Shane Huang wrote:
> Implement SATA AHCI FIS-based switching support.
>
> Tested on AMD internal reference board.
>
> Signed-off-by: Shane Huang<shane.huang@amd.com>
> Cc: Tejun Heo<tj@kernel.org>
> ---
> Changes from the last version(v3):
> * Rediff for the current upstream kernel as Jeff Garzik asked.
>
> Changes from v2:
> * Move fbs_need_dec from struct ahci_port_priv to ahci_error_intr() as
>    a local variable.
> * Add BUG_ON(!pp->fbs_enabled) for ahci_fbs_dec_intr().
> * Refine the retry loop in ahci_fbs_dec_intr().
> * Refine the code to determine failed active link with ap->pmp_link in
>    ahci_error_intr().
> * WARN_ON() in ahci_port_intr() can storm the machine with consecutive
>    stack dumps, replace it with WARN_ON_ONCE().
> * Refine ahci_enable_fbs()/ahci_disable_fbs(), and discard the message
>    for controllers which do not support FBS.
> * Add a warning message in ahci_port_start() for those weird controllers
>    which support CAP.FBSS but do not support PxCMD.FBSCP.
> * Several small corrections for better coding style.

applied...  nice work, thanks!


