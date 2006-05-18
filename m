From: Doug Maxey <dwm@bebe.enoyolf.org>
Subject: Re: About the naming of ata_drive_probe_reset()
Date: Thu, 18 May 2006 12:15:50 -0500
Message-ID: <200605181715.k4IHFoTE008976@bebe.enoyolf.org>
References: <446BE350.5000504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:6593 "EHLO
	bebe.enoyolf.org") by vger.kernel.org with ESMTP id S1751111AbWERRRJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 13:17:09 -0400
In-reply-to: <446BE8D5.5010404@gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>


On Thu, 18 May 2006 12:24:05 +0900, Tejun Heo wrote:
>  I still want to 
> signify that the function isn't actually a callback but something that 
> can be used to drive a callback.  I like 'drive' but as you have pointed 
> out it can be confused with hard 'drive'.  Maybe ata_steer_*()?  Any 
> other ideas?

a comment from the peanut gallery - how about something along the lines 
of:
ata_exec
ata_run
ata_init
ata_start
ata_kick

?

++doug

