From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Sat, 29 Mar 2008 11:39:46 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803291128030.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
 <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
 <47EDBD6D.1020207@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:35683 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbYC2Kj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 06:39:58 -0400
In-Reply-To: <47EDBD6D.1020207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Fri, 28 Mar 2008, Mark Lord wrote:

> One thing to try, to verify that my interpretation was correct, is to 
> try and read that exact sector.  It should fail, I think.
>
> The hex values are in low:middle:high order, so that translates to 
> 0xf9240a, or decimal 16327690.
>
> So you could try this, with the latest hdparm (from sourceforge.net):
>
>  hdparm --read-sector 16327689
>  hdparm --read-sector 16327690
>  hdparm --read-sector 16327691
>
> At least one of those ought to fail, if we've done this correctly.

envy:/usr/src/hdparm-8.6# for i in 16327689 16327690 16327691 ; do ./hdparm --read-sector $i /dev/sdb ; done | egrep ^reading
reading sector 16327689: succeeded
reading sector 16327690: succeeded
reading sector 16327691: succeeded

(and just to be sure, i also tried 664825 (ie: 0x0a24f9 instead), works 
fine too.)

On Fri, 28 Mar 2008, Mark Lord wrote:

>  cat /dev/zero > /dev/sdX
>  sync
>  hdparm -F /dev/sdX

kicked disk from array and running it now. didnt want to wait for results 
before i posted this because of the hdparm --read-sector results...

//tlund
