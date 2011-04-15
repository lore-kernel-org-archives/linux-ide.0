From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: RE: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Fri, 15 Apr 2011 05:15:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1104150510181.14027@uplift.swm.pp.se>
References: <C1438B59050E1B4C9482FF3266AD6BA32C7493557A@gretna.indigovision.com> <C1438B59050E1B4C9482FF3266AD6BA32C7493559F@gretna.indigovision.com> <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:49022 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab1DODXy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Apr 2011 23:23:54 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 8 Apr 2011, Bruce Stenning wrote:

> The 2.6.38.2 kernel still exhibits the same lockups that we see with the 
> 2.6.26 kernel.

Hi.

I have some input on this. I have one of these controllers and had 
problems with one channel where if I had a drive in that hotswap bay, the 
controller wouldn't even POST at boot. It just stuck in the detection 
phase in the controller BIOS.

When I tested hotplugging into that bay when the system was running, I 
received a kernel warning (it's not powered on at the moment so I can't 
provide the output, if it's important I can get it).

My point is that there might be a problem with this controller hw or 
firmware that doesn't handle all behaviour/situations properly. I 
re-seated the SATA cable at both ends and after that couldn't reproduce 
the problem (which was reproduced with two different make harddrives 
several times before re-seating the cable).

This was with the 2.6.32 debian stable kernel, AMD64 version.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
