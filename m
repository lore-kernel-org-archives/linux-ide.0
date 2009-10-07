From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] libata: fix incorrect link online check
 during probe
Date: Tue, 06 Oct 2009 21:03:40 -0400
Message-ID: <4ACBE8EC.3000609@pobox.com>
References: <4ACAFB08.8020501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:38307 "EHLO mail.dvmed.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933852AbZJGBEU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 21:04:20 -0400
In-Reply-To: <4ACAFB08.8020501@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, stable@kernel.org, Tim Blechmann <tim@klingt.org>

On 10/06/2009 04:08 AM, Tejun Heo wrote:
> While trying to work around spurious detection retries for
> non-existent devices on slave links, commit
> 816ab89782ac139a8b65147cca990822bb7e8675 incorrectly added link
> offline check logic before ata_eh_thaw() was called.  This means that
> if an occupied link goes down briefly at the time that offline check
> was performed, device class will be cleared to ATA_DEV_NONE and libata
> wouldn't retry thus failing detection of the device.
>
> The offline check should be done after the port is thawed together
> with online check so that such link glitches can be detected by the
> interrupt handler and handled properly.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Tim Blechmann<tim@klingt.org>
> Cc: stable@kernel.org
> --
>   drivers/ata/libata-eh.c |   50 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 18 deletions(-)

applied.  BTW, note your separator lost a dash... it should be three 
dashes (---).


