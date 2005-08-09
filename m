From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: libata for SATA HDs.
Date: Tue, 09 Aug 2005 23:27:51 +0100
Message-ID: <42F92DE7.9070301@superbug.demon.co.uk>
References: <42EEA9D5.5080304@superbug.demon.co.uk> <42F8B264.5010706@rtr.ca> <42F8EE0B.7000706@superbug.demon.co.uk> <20050809180411.GD10315@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3850 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S965008AbVHIW1y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 18:27:54 -0400
In-Reply-To: <20050809180411.GD10315@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Aug 09, 2005 at 06:55:23PM +0100, James Courtier-Dutton wrote:
> 
>>Mark Lord wrote:
>>
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>Google did not help me.
>>>>
>>>>Can I use the kernel libata and do commands like this now? :
>>>>hdparm -S60 /dev/sda
>>>
>>>
>>>Yes, but only if you manually apply the "libata-passthru" patch.
>>>
>>>The copy (below) works with 2.6.12, and I'm including it here
>>>for the benefit of the many who aren't yet ready to adopt a new
>>>religion (git) just for obtaining this vital functionality.
>>>
>>>Cheers
>>>
>>
>>So, why hasn't that patch got into the kernel?
> 
> 
> Because there are several reports of it causing problems, when used on a
> loaded system.
> 
> 	Jeff
> 

Jeff,

What sort of problems? Loss of data?
I don't really have the time to do a full restore cycle just to try libata.

James

