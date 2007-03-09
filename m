From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core: Fix the iordy methods
Date: Fri, 9 Mar 2007 16:49:10 +0000
Message-ID: <20070309164910.70d9c85d@lxorguk.ukuu.org.uk>
References: <20070308232259.661e1564@lxorguk.ukuu.org.uk>
	<45F17C5C.7010306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36798 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2993124AbXCIPpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 10:45:23 -0500
In-Reply-To: <45F17C5C.7010306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

>     I'm afraid that the logic is still a bit wrong for non-IORDY drives. If 
> the drive doesn't support IORDY, the only mode we can use is the one indicated 
> by the word 51 of identify data (we cannot issue Set Transfer Mode with 
> argument 00001xxxb to such drives); that is, drive-wise -- on the host side we 

Yep - the drive side command issue is handled seperately.

> can set any mode from 0 to this one.  But PIO2 should be still *valid* for 
> this case, according to ATA-1.
>     Oh well, these drives should be really prehistoric, so my comment doesn't 
> matter much anyway... :-)

I'll double check the older specs again. Such fun ;)

Alan
