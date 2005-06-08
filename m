From: Mark Lord <liml@rtr.ca>
Subject: Re: [SATA] libata-dev queue updated
Date: Wed, 08 Jun 2005 04:37:18 -0400
Message-ID: <42A6AE3E.7070401@rtr.ca>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:22282 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261841AbVFGMhj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Jun 2005 08:37:39 -0400
In-Reply-To: <87u0kbhqsz.fsf@stark.xeocode.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>

Greg Stark wrote:
> Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
> site:
> 
>  bash-3.00$ smartctl -data -a /dev/sda
>  smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
>  Home page is http://smartmontools.sourceforge.net/
> 
>  Smartctl: Device Read Identity Failed (not an ATA/ATAPI device)

Oh, wait a sec -- Jeff just posted that he's nuked the "read identity" ioctl(),
so I suppose that has now broken smartmontools compatibility.

So Linux either goes without S.M.A.R.T. for SATA (again),
or Jeff puts it back, or smartmontools gets upgraded Real Soon Now.

Cheers
