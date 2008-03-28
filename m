From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,SCAN]_HWIF
 ioctls
Date: Fri, 28 Mar 2008 15:14:36 -0400
Message-ID: <47ED439C.9030400@rtr.ca>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain> <20080208004606.17746.90799.sendpatchset@localhost.localdomain> <47EBDBAA.2020308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1983 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757818AbYC1TOh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 15:14:37 -0400
In-Reply-To: <47EBDBAA.2020308@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> hdparm explicitely marks HDIO_[UNREGISTER,SCAN]_HWIF ioctls as DANGEROUS
>> and given the number of bugs we can assume that there are no real users:
..

There is the odd user of these, actually.

But the most recent to email me (a few weeks ago),
reported that the SCAN function was no longer working on his kernel.

I'll remove the -R and -U flags completely from hdparm-8.7.

Cheers
