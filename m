From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Marvell SATA for libata?
Date: Sun, 09 May 2004 22:51:46 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409EEE42.6070201@pobox.com>
References: <409D84A9.1090107@mailcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264477AbUEJCwF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 May 2004 22:52:05 -0400
In-Reply-To: <409D84A9.1090107@mailcan.com>
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leonw@mailcan.com>
Cc: linux-ide@vger.kernel.org

Leon Woestenberg wrote:
> Hello all, Jeff Garzik in particular,
> 
> we have interest in having the Marvell 88sx5040 SATA controller work
> under libata.
> 
> Did you happen to start development for this controller, as your
> latest libata status report seems to tell so?
> 
> We have the Marvell datasheet available (but under NDA) as well as
> the source code from SuperMicro and we would like to convert it to
> the libata framework.


In fact, I am working on it right now.

I also have the docs and the driver (albeit officially :)).

A non-queueing driver for Marvell will be fairly straightforward. 
Adding queueing will be much more of a chore, though.

	Jeff



