From: Mark Lord <lkml@rtr.ca>
Subject: Re: Compact Flash performance...
Date: Wed, 30 May 2007 23:24:32 -0400
Message-ID: <465E3FF0.9010709@rtr.ca>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3887 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004AbXEaDYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 May 2007 23:24:33 -0400
In-Reply-To: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Daniel J Blueman wrote:
> I have a SanDisk Extreme IV 4GB CF card, capable of 40MB/s read, but
> am seeing 30MB/s read [1], connected directly to the IDE bus on my
> ICH8 controller.
> 
> How can I find out if this would be a timing or configuration issue?
> On 2.6.20.5 [2], the 120nS timing looks to be right [3], but perhaps
> no multi-word transfer is hurting here...alas, it can't be enabled
> with the libata subsystem and 'hdparm -m', so what else?

Please post the output from "hdparm --Istdout /dev/sdb" for this card.

Thanks
