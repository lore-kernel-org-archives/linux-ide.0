From: Tim Small <tim@seoss.co.uk>
Subject: Re: Power-up-in-standby Hitachi 5K3000 fails with either sata_sil24
 or pmp, but not direct to AHCI controllers
Date: Fri, 10 Jun 2011 17:15:47 +0100
Message-ID: <4DF24333.2010208@seoss.co.uk>
References: <4DF0C797.201@seoss.co.uk> <20110610102550.GF15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:34836 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1FJQP4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 12:15:56 -0400
In-Reply-To: <20110610102550.GF15235@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 10/06/11 11:25, Tejun Heo wrote:
> On Thu, Jun 09, 2011 at 02:16:07PM +0100, Tim Small wrote:
>   
>> ... if I then didn't power down the drive, but instead attached it
>> to the Marvell controller, it didn't come back, so I'd guess the
>> interaction with the 3124 has wedged the drive permanently.
>>     
> Heh, that's interesting.  The feature isn't very well tested and it
> wouldn't be too surprising if there are some bugs on all sides
> (driver, controller and drive firmware).  Can you please try with a
> drive from a different vendor and see whether it fares any
> differently?
>   

OK, I'll see what I can get hold of in the way drives which support that
feature...

Cheers,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

