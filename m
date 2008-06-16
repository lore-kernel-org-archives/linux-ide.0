From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] palm_bk3710: fix resource management (take 2)
Date: Mon, 16 Jun 2008 22:10:39 +0200
Message-ID: <200806162210.39943.bzolnier@gmail.com>
References: <200806162351.07566.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:20116 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbYFPUJT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 16:09:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3210119ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2008 13:09:14 -0700 (PDT)
In-Reply-To: <200806162351.07566.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 16 June 2008, Sergei Shtylyov wrote:
> The driver expected a *virtual* address in the IDE platform device's memory
> resource and didn't request the memory region for the register block. Fix this
> taking into account the fact that DaVinci SoC devices are fixed-mapped to the
> virtual memory early and we can get their virtual addresses using IO_ADDRESS()
> macro, not having to call ioremap()...
> 
> While at it, also do some cosmetic changes...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Argh! I have finally run checkpatch.pl and it detected some whitespace damage.
> And of course, I then re-sent it without fixing that!
> So, here's take 2 of that stupid patch for real now. Sorry for the mess... :-<

I've already fixed it while applying "take 1" but I was too lazy to
mention it (not that single " " removal is worth mentioning)... :)

[ However please integrate checkpatch.pl into your workflow... ]
