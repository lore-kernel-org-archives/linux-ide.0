From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 #upstream] sata_fsl,mv,nv: prepare for NCQ command
 completion update
Date: Mon, 02 Aug 2010 09:18:15 +0200
Message-ID: <4C567137.9060407@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C247B54.2050900@garzik.org> <4C247C36.6040007@kernel.org> <4C24A903.4060908@kernel.org> <4C5607AF.8020109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35250 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab0HBHS5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Aug 2010 03:18:57 -0400
In-Reply-To: <4C5607AF.8020109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org, Ashish Kalra <ashish.kalra@freescale.com>, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>

Hello, Jeff.

On 08/02/2010 01:47 AM, Jeff Garzik wrote:
>> So, something like this.  I tested both flavors of sata_nv but don't
>> have access to sata_mv or sata_fsl, but the conversion is pretty
>> straight forward and failures should be pretty easy to catch.
> 
> applied

Are you planning on applying the second patch too?

Thanks.

-- 
tejun
