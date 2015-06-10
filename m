From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Question about HighPoint RocketRAID 642L SCSI driver conflict
 with Linux AHCI driver
Date: Wed, 10 Jun 2015 23:47:14 +0100
Message-ID: <20150610234714.76db2719@lxorguk.ukuu.org.uk>
References: <002a01d09e84$22be8f90$683baeb0$@highpoint-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:34019 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbFJWrh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2015 18:47:37 -0400
In-Reply-To: <002a01d09e84$22be8f90$683baeb0$@highpoint-tech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux <linux@highpoint-tech.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 4 Jun 2015 13:05:49 +0800
"linux" <linux@highpoint-tech.com> wrote:

> Dear Tejun Heo,
> 
>   This is HighPoint Linux Team. We found Linux AHCI driver since kernel 3.16
> has added ID (0x06421103) to support RocketRAID 642L which is not what we
> expected. If we want to load HighPoint RR642L RAID version Linux SCSI
> driver, it becomes conflict each other. This affects our customers who need
> to use our RAID version driver stack.

If your stack existed in full open source form upstream we might be able
to add it the supported raid formats, which would make life even easier
for your customers.

>   Hence,  this is to ask Linux how to solve this conflict with AHCI driver?
> and why Linux wants to add RR642L ID (0x06421103) into AHCI driver? 

So that users can use the hardware with the standard kernel AHCI drivers
because they are best freely available and integrated driver available.

> Is there > any way to prevent this in the future?

Apart from having your customers reconfigure their kernel or carefully
set stuff up at boot time, no.

Alan
