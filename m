From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Inclusion of patch for Promise SATAII 150 TX4 in mainline 2.6
 kernel?
Date: Tue, 08 Feb 2005 08:19:00 +0400
Message-ID: <42083DB4.7050408@wasp.net.au>
References: <Pine.LNX.4.44.0502071601140.31011-100000@coffee.psychology.mcmaster.ca> <4207DFF4.8010208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:51860 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261461AbVBHETI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2005 23:19:08 -0500
In-Reply-To: <4207DFF4.8010208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org, Johannes Resch <jr@xor.at>

Jeff Garzik wrote:
> Mark Hahn wrote:
> 
>>
>> I had good luck with this patch as well.  I think the SATA-SMART patches
>> should go in too, even if they aren't perfect yet...
> 
> 
> The Promise SATAII patch went in today.
> 
> The SMART patches absolutely -should not- go in.  Certain common hdparm 
> commands can cause data corruption rather than produce expected results.

In addition to the bug Andy Warner mentioned previously about the passthrough extensions causing 
oopses on SMP machines. For basic use on UP they are fine, I have been beating on the for months 
now, but they still have holes big enough to shoot through if you are not careful.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
