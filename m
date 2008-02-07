From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: insert BUG_ON() into __ide_set_handler() (take 2)
Date: Thu, 7 Feb 2008 21:45:00 +0100
Message-ID: <200802072145.00777.bzolnier@gmail.com>
References: <200802072020.02585.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:58553 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbYBGUig (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 15:38:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so49181wah.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 12:38:33 -0800 (PST)
In-Reply-To: <200802072020.02585.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 07 February 2008, Sergei Shtylyov wrote:
> Replace the check for hwgroup->handler and printk(KERN_CRIT, ...) at the start
> of __ide_set_handler() with mere BUG_ON() while removing such from the caller,
> ide_execute_command(). Fix up the code formatting, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

thanks, applied
