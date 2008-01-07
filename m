From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Tue, 08 Jan 2008 08:56:56 +0900
Message-ID: <4782BC48.4000309@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.180]:32238 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYAGX5D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 18:57:03 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2142890roc.5
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 15:57:02 -0800 (PST)
In-Reply-To: <4782B73B.8080309@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Hello, guys.
>>> 
>>> We still have three problems with ADMA.
>>> 
>>> * hard lockup during resume * occasional hard lockup after
>>> hotplug or other erros (probably related to the above?)
> 
> This has only been reported on one person's MSI board. Apparently 
> another revision of the same board is reported to work, and I can't 
> duplicate the problem on my Asus board, so it could just be some 
> hardware problem on that motherboard.

IIRC, I have two from suse bug reports and both resolved with adma=0.
I'm not too sure whether post 2.6.23-rcX changes would have fixed those
problems tho.  FWIW, I've disabled ADMA mode on all suse products.

> I still can't say I'm really in favor of it.. In particular to do so
> for 2.6.24 right now seems excessive, as none of these problems are
> regressions from 2.6.23, and these controllers haven't been tested in
> non-ADMA mode very much since it was made the default, so that change
> might actually cause regressions.

Technically, they're regressions from pre-ADMA days - pretty grave ones
considering some of the failure modes include hard lock up.  Also, they
don't seem resolvable in foreseeable future at this point.  If this
isn't gonna improve, I think we should just drop ADMA support altogether
and concentrate on stabilizing non-ADMA operation.  Stability is far
more important than small performance improvements or feature supports.

But, yeah, you're right in that the change might cause more problems.
What's your estimation of such possibility?  I generally feel good about
non-ADMA mode operation as they seem to solve most reported sata_nv bugs
but I haven't really followed sata_nv code changes recently.

Maybe this can be resolved by going through one more -rc cycle after the
change if that's possible.

Thanks.

-- 
tejun
