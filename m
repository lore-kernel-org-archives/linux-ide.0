From: Sami Farin <safari-kernel@safari.iki.fi>
Subject: Re: SATA / DVD-RW: recovering from write errors without rebooting
Date: Tue, 23 Dec 2008 04:16:55 +0200
Message-ID: <20081223021655.jivflcnveq7m2m6f@m.safari.iki.fi>
References: <20081223012619.dj3ssmpbiff6zcvf@m.safari.iki.fi> <20081223015446.7d95ae5e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:39997 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbYLWCQ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 21:16:58 -0500
Received: from safari.iki.fi (80.223.84.180) by jenni1.inet.fi (8.5.014)
        id 48FC59C702E142BF for linux-ide@vger.kernel.org; Tue, 23 Dec 2008 04:16:56 +0200
Content-Disposition: inline
In-Reply-To: <20081223015446.7d95ae5e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux ide Mailing List <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Dec 23, 2008 at 01:54:46 +0000, Alan Cox wrote:
> > 2008-12-23 01:44:55.656349088 <3>[17524.249164] ata4.00: status: { DRDY }
> > 2008-12-23 01:44:55.656349714 <6>[17524.249171] ata4: hard resetting link
> > 2008-12-23 01:44:55.961280094 <6>[17524.554144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> Some drives seem to get stuck if we reset them and they think they have
> data to send us. I've sent Jeff some patches for that for 2.6.29 time.
> They may help in your case, they may not but if you'd like to see then
> let me know and I'll send you the relevant patch to apply.
> 
> Alan

Thanks, Alan, I'd like to try them out, I have nothing to lose.

-- 
"That man is the richest whose pleasures are the cheapest."
 - Henry David Thoreau

