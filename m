From: Andrew Morton <akpm@osdl.org>
Subject: Re: sata_Re: sata_mv success on 2.6.16-rc6-mm2
Date: Tue, 21 Mar 2006 02:30:32 -0800
Message-ID: <20060321023032.20fc5aa3.akpm@osdl.org>
References: <200603191613.37386.lkml@rtr.ca>
	<20060321102603.GA10403@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:37048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932379AbWCUKds (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 05:33:48 -0500
In-Reply-To: <20060321102603.GA10403@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: lkml@rtr.ca, linux-ide@vger.kernel.org, jgarzik@pobox.com

Sander <sander@humilis.net> wrote:
>
> I'm sorry to say it doesn't fix the above output. Because it is
>  line-wrapped, I'll paste again for your convenience:
> 
>  [   83.489431] BUG: warning at drivers/scsi/sata_mv.c:1896/__msleep()

It won't fix that - the above is just a -mm-only warning that the driver is
being lame, sucky and sinful ;)

Don't worry aobut it.
