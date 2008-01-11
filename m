From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Sat, 12 Jan 2008 00:18:13 +0100
Message-ID: <20080111231813.GB7052@boogie.lpds.sztaki.hu>
References: <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com> <477BDEA5.8040701@garzik.org> <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com> <477C2A99.9010208@shaw.ca> <477C61D3.30009@rtr.ca> <477C6A85.9020607@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505598@hqemmail07.nvidia.com> <4782BF75.9040803@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:46197 "EHLO
	boogie.lpds.sztaki.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026AbYAKXSP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 18:18:15 -0500
Content-Disposition: inline
In-Reply-To: <4782BF75.9040803@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Allen Martin <AMartin@nvidia.com>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

On Mon, Jan 07, 2008 at 06:10:29PM -0600, Robert Hancock wrote:

> Gabor, I just noticed you said that it worked OK in 2.6.20, yet 2.6.22  
> fails. 2.6.20 had ADMA support as well, so I wonder what change started  
> causing the problem. Would it be possible for you to do a git bisect (or  
> at least try 2.6.21 to try and narrow it down)?

I've now booted 2.6.21.7, we'll see. The problem with the bisection is
that I can't explicitely trigger the bug so I can't say for sure if a
kernel is good or it is just needs more time to trigger. The average
uptime of this machine is just a couple hours a day.

For example, with 2.6.24-rc6 it took over 3 hours for the first disk to
trigger the bug and the second disk needed more than 7 hours. This
machine is seldom turned on for that long.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
