From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Fri, 10 Oct 2008 20:34:19 -0600
Message-ID: <48F010AB.7010009@shaw.ca>
References: <fa.Ke90oacfRjgiI4x5LejzjssRBEg@ifi.uio.no> <fa.5sGSpBgVBoMAsIwwLABWnjDzM38@ifi.uio.no> <fa.8TkQ+xA96EhlNKL9gIbVTxVrcUE@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:5247 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbYJKCeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 22:34:23 -0400
In-Reply-To: <fa.8TkQ+xA96EhlNKL9gIbVTxVrcUE@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>> Sorry, but I just have to ask 'why'? IDE is seeing a whole lot of churn
>> for something that should essentially be a stable code base in
>> maintenance mode, and now scalability improvements?
> 
> It is the stable code but being in "maintenance only mode" has never
> been true and as long as there are active users & developers there is
> really no reason to change it.

Are there really many active users at this point? I'm not aware of any 
new distributions that are using it. The only people I can see that 
might still want to be using it would be people with old setups or old 
embedded devices.. many of those wouldn't be using newer kernels anyway.

These kinds of changes only will really help scalability on multi-core 
machines which are unlikely to be using this code anyway.. They seem 
rather like putting makeup on a corpse to me..
