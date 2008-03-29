From: Mark Lord <liml@rtr.ca>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 23:50:31 -0400
Message-ID: <47EDBC87.8090109@rtr.ca>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2886 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbYC2Duc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 23:50:32 -0400
In-Reply-To: <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

Tomas Lund wrote:
> On Fri, 28 Mar 2008, Mark Lord wrote:
> 
>> Mark Lord wrote:
>>
>> Duh..  actually, we were just discussing this very error in another 
>> thread. The drive is really telling us that it hit an unrecoverable 
>> WRITE error at sector 0a:24:f9 on the drive.  Bad sector.
> 
> Aha, ok :(
> 
>> There are patches queued up for 2.6.26 to automatically resume the 
>> cache flush after the failed sector, but you'll still lose data at 
>> that sector.
> 
> Lucky for me, there is no data yet on the system yet!
> 
>> Time for a low-level reformat, if the manufacturer has a utility for 
>> that. Otherwise, RMA it.
> 
> The drive is brand spanking new, less than 3 weeks, its going back!
> 
> I do however wonder, what is an "unrecoverable write error", does it 
> mean it even failed to re-allocate it? Reallocated_Sector_Ct is still 0 
> according to smartcl...
..

Mmm.. it does seem rather unlikely there, doesn't it ?

One thing to try, if you have 12000 seconds to spare, :)
is to simply try this:

   cat /dev/zero > /dev/sdX
   sync
   hdparm -F /dev/sdX

And see if that completes without error.
If it does, then the drive may be fine.

Software bugs are always possible, but do seem unlikely in this case.
But then, so does a hardware failure seem unlikely on a new drive.

Cheers
