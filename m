From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 17:35:35 +0400
Message-ID: <45056627.7030202@ru.mvista.com>
References: <20060911132250.GA5178@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50738 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S932336AbWIKNdd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2006 09:33:33 -0400
In-Reply-To: <20060911132250.GA5178@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Hello.

Jeff Garzik wrote:
> The following libata changes are queued for 2.6.19:
> 
> General
> -------
> * Increase lba28 max sectors from 200 to 256

[...]

> Jeff Garzik:
[...]
>       [ATA] Increase lba48 max-sectors from 200 to 256.

    So was it for LBA28 or for LBA48?
    As for LBA28, it might be quite dangerous. Particularly, I know that IBM 
drives used to mistreated 256 as 0 in the past (bumped into that on a 8-year 
old drive which is still alive though).

WBR, Sergei
