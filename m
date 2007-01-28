From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] siimage: PIO1/2 taskfile transfer overclocking fix
Date: Sun, 28 Jan 2007 23:48:35 +0300
Message-ID: <45BD0C23.8000004@ru.mvista.com>
References: <200701282346.55935.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16520 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932820AbXA1Ush (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 15:48:37 -0500
In-Reply-To: <200701282346.55935.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, I wrote:
> Fix two typos found by SiI680A documentation check.  They caused the taskfile
> transfer overclocking:
> 
> - in PIO mode 1 as 0x2283 must be used for both data and taskfile transfers;
> 
> - in PIO mode 2 as data and taskfile timings are swapped when writing to the
>   MMIO regs.
> 
> Fix coding style and trailing whitespace in enclosing statements while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Forgot to specify that this patch was against Linus' tree...

MBR, Sergei
