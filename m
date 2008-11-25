From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 21:41:38 +0300
Message-ID: <492C46E2.90904@ru.mvista.com>
References: <492B56B0.9030409@caviumnetworks.com>	<1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>	<492C2F23.8050105@garzik.org> <20081125171224.297931b2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:42280 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752632AbYKYSlj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 13:41:39 -0500
In-Reply-To: <20081125171224.297931b2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello.

Alan Cox wrote:

>>>The forthcoming OCTEON SOC Compact Flash driver needs a few more
>>>timing values than were available in the ata_timing table.  I add new
>>>columns for write_hold, read_hold, and read_holdz times.  The values
>>>were obtained from the Compact Flash specification Rev 4.1.

>>>Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>---
>>> drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
>>> include/linux/libata.h    |   14 ++++++--
>>> 2 files changed, 52 insertions(+), 38 deletions(-)

>>I would be happy to go ahead and apply this...  Alan, any last minute 
>>objections?

> Its close but I think Sergei is right about columns with all the same
> value - they can be constants and just computed into the final timing
> data in terms of clocks.

    The problem is that there's no exported libata API to compute just one 
arbitrary timing.

WBR, Sergei
