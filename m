From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Tue, 08 Jan 2008 10:01:22 +0900
Message-ID: <4782CB62.7040901@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com> <4782C008.3030902@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:23375 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYAHBBm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 20:01:42 -0500
Received: by po-out-1718.google.com with SMTP id c31so1670860poi.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 17:01:42 -0800 (PST)
In-Reply-To: <4782C008.3030902@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Robert Hancock wrote:
>>> This has only been reported on one person's MSI board. Apparently
>>> another revision of the same board is reported to work, and I can't
>>> duplicate the problem on my Asus board, so it could just be some
>>> hardware problem on that motherboard.
>>
>> IIRC, I have two from suse bug reports and both resolved with adma=0.
>> I'm not too sure whether post 2.6.23-rcX changes would have fixed those
>> problems tho.  FWIW, I've disabled ADMA mode on all suse products.
> 
> A hotplug-related problem? Have a link to the reports?

Hmmm... I mis-remembered.  The reporter said it was okay in SL102
(2.6.18, no ADMA) but SL103 (2.6.22, ADMA is on) fell apart.  I asked
for retest w/ adma=0 but no response yet.

  https://bugzilla.novell.com/show_bug.cgi?id=347184

I tried to reproduce the problem on my a8n-e but couldn't.

>> Technically, they're regressions from pre-ADMA days - pretty grave ones
>> considering some of the failure modes include hard lock up.  Also, they
>> don't seem resolvable in foreseeable future at this point.  If this
>> isn't gonna improve, I think we should just drop ADMA support altogether
>> and concentrate on stabilizing non-ADMA operation.  Stability is far
>> more important than small performance improvements or feature supports.
> 
> The suspend/resume problem should be resolvable. It worked before and
> should be able to work again. Hopefully debug output with console
> enabled during resume may provide some hints..

Okay.

> The cache flush timeout problem is a bit onerous, but hopefully we can
> figure something out there with some more debugging by the reporter.

:-(

>> But, yeah, you're right in that the change might cause more problems.
>> What's your estimation of such possibility?  I generally feel good about
>> non-ADMA mode operation as they seem to solve most reported sata_nv bugs
>> but I haven't really followed sata_nv code changes recently.
> 
> It's hard to say what may come up if we do this. I seem to recall that
> there were some reports of wierd hotplug issues and high latencies on
> register access that went away with ADMA mode.
> 
> I do think it's likely too late in the -rc series to make such a change
> though. Hopefully by 2.6.25 we'll either have the issues fixed or have
> more of an idea whether they can be.

I feel pretty uncomfortable with the current situation.  Two mostly
working operation modes w/o any doc and known unresolved issues on both.
 Eeeek.  :-(

-- 
tejun
