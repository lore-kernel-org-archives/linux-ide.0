From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Fri, 25 Jan 2008 20:07:59 -0500
Message-ID: <76366b180801251707j7b892d6w83fcf3560426aa19@mail.gmail.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com>
	 <47992BA3.3070104@gmail.com>
	 <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com>
	 <4799788E.1030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:48026 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbYAZBIA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 20:08:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so911044rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 17:07:59 -0800 (PST)
In-Reply-To: <4799788E.1030600@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Shane Huang <Shane.Huang@amd.com>, sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org

I'll try to get that configuration together.. right now I only have 2
1gb sticks installed on the board, so I would need to track down 2gb
ones. If I can find some laying around, I'll let you know.

Thanks,
-Andrew

On Jan 25, 2008 12:50 AM, Tejun Heo <htejun@gmail.com> wrote:
> Andrew Paprocki wrote:
> > I have an SB600/RS690 here with SATA drives connected. I haven't been
> > following this thread, but I can help test something if it would help.
>
> We're trying to determine whether SB600 ahci controller can do 64bit DMA
> or not.  Srihari's couldn't but Shane's test result tells a different
> story.  Do you have memory mapped over 4G (if you have 4G some of them
> will be over 4G, you can know this by looking at the e820 map printed
> during boot)?
>
> --
> tejun
>
>
