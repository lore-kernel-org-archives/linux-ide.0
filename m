From: Mark Lord <liml@rtr.ca>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 23:54:21 -0400
Message-ID: <47EDBD6D.1020207@rtr.ca>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca> <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2851 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYC2DyX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 23:54:23 -0400
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
..

One thing to try, to verify that my interpretation was correct,
is to try and read that exact sector.  It should fail, I think.

The hex values are in low:middle:high order,
so that translates to 0xf9240a, or decimal 16327690.

So you could try this, with the latest hdparm (from sourceforge.net):

   hdparm --read-sector 16327689
   hdparm --read-sector 16327690
   hdparm --read-sector 16327691

At least one of those ought to fail, if we've done this correctly.

Cheers
