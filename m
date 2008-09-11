From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Thu, 11 Sep 2008 19:18:04 +0400
Message-ID: <48C936AC.1080309@ru.mvista.com>
References: <48C6B768.4010200@ru.mvista.com>	<20080911.003222.51867360.anemo@mba.ocn.ne.jp>	<48C7EDE4.3090400@ru.mvista.com> <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42802 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751908AbYIKPRY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 11:17:24 -0400
In-Reply-To: <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Atsushi Nemoto wrote:

>>>But the "Command Transfer Mode Select" bits affects access timings on
>>>setting task registers for DMA command.

>>    So what? PIO and DMA are different protocols on IDE bus, so they shouldn't 
>>affect each other. The IDE core will always tune the best PIO mode for you, so 
>>the optimal command timings will be set.

> Hmm, that would be a thing I had misunderstood.  I thought
> set_pio_mode is not called when the drive was DMA capable.

    PIO autotuning was optional before (done only if the driver requested it 
via setting drive->autotune), but now done always.

MBR, Sergei
