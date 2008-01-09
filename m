From: Mark Lord <lkml@rtr.ca>
Subject: Re: Do SATA tape drives work?
Date: Wed, 09 Jan 2008 01:09:21 -0500
Message-ID: <47846511.30805@rtr.ca>
References: <200801090329.m093T7Op019488@turbo.physics.adelaide.edu.au> <4784591D.3060000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1837 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYAIGJX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 01:09:23 -0500
In-Reply-To: <4784591D.3060000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> [cc'ing linux-ide]
> 
> Jonathan Woithe wrote:
>> Hi guys
>>
>> I was wondering whether anyone can shed any light on the status of SATA tape
>> drives.  There's very little info on the net about this at least in the
>> places I've checked; the only thing of any significance I've found thus far
>> is a note in a Bacula document dated April 2007 which states that drives
>> other than real SCSI units don't generally work with Bacula.
>>
>> To put this into context, I'm looking at purchasing a Sony SDX470VRB SATA
>> AIT-1 tape drive for use with the SATA controller on an Intel DG31PR
>> mainboard.  The drive will be used primarily with tar/cpio.  Obvsiouly
>> however I only want to make the purchase if there's a reasonable chance of
>> it working.
>>
>> I would appreciate any information you can shed on this issue.
> 
> It's supposed to with recent updates.  Mark, right?
..

I wouldn't buy anything with "Sony" on it,
but Albert thinks ATAPI tapes should be working now
(he has my old drive now).
 

