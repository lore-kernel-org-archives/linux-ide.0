From: Tejun Heo <htejun@gmail.com>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Tue, 23 Oct 2007 17:00:28 +0900
Message-ID: <471DAA1C.4070608@gmail.com>
References: <47099C24.3010504@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:59806 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXJWIAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 04:00:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1418200rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 01:00:35 -0700 (PDT)
In-Reply-To: <47099C24.3010504@mandic.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: linux-ide@vger.kernel.org, miquels@cistron.nl

Renato S. Yamane wrote:
> Hi for all,
> I use Kernel 2.6.22.9 with CFS-v22 patch under Debian Etch.
> 
> I cc Miquel because he is commented in man page of shutdown utilitie.
> 
> When I shutdown my laptop, I see some warnings after "Will be halt now".
> This message is something about "Spindown error" (this message is very
> fast and I can't read all warnings, and don't found it on logs).
> 
> I read in www.linux-ata.org/shutdown.html that is about shutdown utilitie.
> 
> So, my questions is:
> - This is dangerous? Can damage something?

If your drive sounds funny on shutdown, it could.  Your drive is
supposed to sound the same way it sounds when you execute "hdparm -y
/dev/sdX".

> - How can I help to fix this warning?

I believe there's already update out but you can edit some configuration
file (can't remember which ATM) such that "-h" option is not passed to
halt.  Google should be able to tell you which file it is.

-- 
tejun
