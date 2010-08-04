From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream] sata_fsl,mv,nv: prepare for NCQ command
 completion update
Date: Wed, 04 Aug 2010 00:22:47 -0400
Message-ID: <4C58EB17.6080803@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C247B54.2050900@garzik.org> <4C247C36.6040007@kernel.org> <4C24A903.4060908@kernel.org> <4C5607AF.8020109@garzik.org> <4C567137.9060407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43493 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab0HDEXi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2010 00:23:38 -0400
In-Reply-To: <4C567137.9060407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org, Ashish Kalra <ashish.kalra@freescale.com>, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>

On 08/02/2010 03:18 AM, Tejun Heo wrote:
> Hello, Jeff.
>
> On 08/02/2010 01:47 AM, Jeff Garzik wrote:
>>> So, something like this.  I tested both flavors of sata_nv but don't
>>> have access to sata_mv or sata_fsl, but the conversion is pretty
>>> straight forward and failures should be pretty easy to catch.
>>
>> applied
>
> Are you planning on applying the second patch too?

sata_mv is behaving weirdly in 2.6.35 + these patches, on the older 6081 
chip, embedded in a Dell server box.  Looking into it...

	Jeff



