From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Sun, 30 Mar 2008 17:01:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
 <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
 <47EDBC87.8090109@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:46597 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYC3PCF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Mar 2008 11:02:05 -0400
In-Reply-To: <47EDBC87.8090109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Fri, 28 Mar 2008, Mark Lord wrote:

> One thing to try, if you have 12000 seconds to spare, :) is to simply 
> try this:
>
>  cat /dev/zero > /dev/sdX
>  sync
>  hdparm -F /dev/sdX
>
> And see if that completes without error. If it does, then the drive may 
> be fine.
>
> Software bugs are always possible, but do seem unlikely in this case. 
> But then, so does a hardware failure seem unlikely on a new drive.

completed without errors, no sectors reallocated...

//tlund
