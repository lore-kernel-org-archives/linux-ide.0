From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] ata_set_mode() to send SET FEATURES first
Date: Mon, 15 Nov 2004 16:57:37 +0800
Message-ID: <007c01c4caf1$46ec31f0$fa534109@tw.ibm.com>
References: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com> <4196B3A7.1020303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:39661 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261556AbUKOI6o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Nov 2004 03:58:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

  I got it. It is the right thing to disable that hardware feature, rather
than change the sequence in ata_set_mode().

  I just checked the Promise manual but cannot find any hint to disable 
that feature. I'll ask Promise engineers how to do that. 
Thanks for the comments.

Albert

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Albert Lee" <albertcc@tw.ibm.com>
Cc: "IDE Linux" <linux-ide@vger.kernel.org>
Sent: Sunday, November 14, 2004 9:23 AM
Subject: Re: [PATCH/RFC] ata_set_mode() to send SET FEATURES first


> I basically agree with Doug, but for a different reason.
> 
> If the hardware is setting an incorrect timing value, then the solution
> is to disable that hardware feature, and manually set the timings.
> 
> Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
