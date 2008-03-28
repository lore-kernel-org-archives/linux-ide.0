From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 23:21:30 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
 <47ED15D2.3080403@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:42216 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625AbYC1WVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 18:21:43 -0400
In-Reply-To: <47ED15D2.3080403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Fri, 28 Mar 2008, Mark Lord wrote:

> Mark Lord wrote:
>
> Duh..  actually, we were just discussing this very error in another 
> thread. The drive is really telling us that it hit an unrecoverable 
> WRITE error at sector 0a:24:f9 on the drive.  Bad sector.

Aha, ok :(

> There are patches queued up for 2.6.26 to automatically resume the cache 
> flush after the failed sector, but you'll still lose data at that 
> sector.

Lucky for me, there is no data yet on the system yet!

> Time for a low-level reformat, if the manufacturer has a utility for 
> that. Otherwise, RMA it.

The drive is brand spanking new, less than 3 weeks, its going back!

I do however wonder, what is an "unrecoverable write error", does it mean 
it even failed to re-allocate it? Reallocated_Sector_Ct is still 0 
according to smartcl...

//tlund
