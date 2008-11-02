From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] read and write data in 4-byte blocks
Date: Mon, 03 Nov 2008 00:23:47 +0300
Message-ID: <490E1A63.3040507@ru.mvista.com>
References: <1225563098-11447-1-git-send-email-n0-1@freewrt.org> <1225563670-23236-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53018 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754024AbYKBVXx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Nov 2008 16:23:53 -0500
In-Reply-To: <1225563670-23236-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org

Hello.

Phil Sutter wrote:

> I forgot to include the one line changing rb532_pata_data_xfer()'s signature,
> sorry for that. So here's the correct version.
>
> * rename the offset definition to avoid abiguity with the standard ATA
>   IO address
> * read and write four bytes at once
> * use writesl() and readsl() which implicitly iterate over the data
> * fix the signature of rb532_pata_data_xfer() to mach the function
>   

   s/mach/match/

>   pointer definition and return the number of bytes consumed
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
>   

Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>

MBR, Sergei


