From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Check return code from pdc20621_i2c_read()
Date: Sun, 02 Aug 2015 13:22:19 -0700
Message-ID: <1438546939.29569.0.camel@perches.com>
References: <1438510340-21568-1-git-send-email-barletz@gmail.com>
	 <55BDFA5C.3040506@cogentembedded.com>
	 <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
	 <CAO-S75DznUxvYg9RPcDOaw1H8XK8MuXxFGOARVt-5OtW2_RJnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:42907 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751605AbbHBUWW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2015 16:22:22 -0400
In-Reply-To: <CAO-S75DznUxvYg9RPcDOaw1H8XK8MuXxFGOARVt-5OtW2_RJnA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2015-08-02 at 10:55 -0700, Tomer Barletz wrote:
> On Sun, Aug 2, 2015 at 4:09 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> 
> >    Please use pr_err() instead. And "0x%d" makes no sense at all, 
> > please use "%#x" instead.
> > 
> 
> Yeah, not sure what I was drinking before writing this 0x%d thing...

btw: you and a few others ([dui]: debugging under the influence?):

$ git grep -n -E "0x[\*\d\.]*%[dui]"
drivers/block/DAC960.c:2957:            DAC960_Error("IO port 0x%d busy for Controller at\n",
drivers/block/DAC960.c:2993:            DAC960_Error("IO port 0x%d busy for Controller at\n",
drivers/block/cciss.c:3857:     dev_dbg(&h->pdev->dev, "   Max outstanding commands = 0x%d\n",
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c:523:    mfc_debug(2, "stream buf addr: 0x%08lx, size: 0x%d\n",
drivers/misc/sgi-gru/grumain.c:286:     gru_dbg(grudev, "gid %d, gts %p, gms %p, ctxnum 0x%d, asidmap 0x%lx\n",
sound/soc/atmel/atmel_ssc_dai.c:293:    pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",

I'll send a few patches...
