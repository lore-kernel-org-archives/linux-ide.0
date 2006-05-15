From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide_dma_speed() fixes
Date: Mon, 15 May 2006 15:08:55 +0100
Message-ID: <1147702135.26686.19.camel@localhost.localdomain>
References: <4463F4C8.9080608@ru.mvista.com>
	 <20060514050548.5399e3f4.akpm@osdl.org>  <446885BE.4090404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41698 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932423AbWEON40
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:56:26 -0400
In-Reply-To: <446885BE.4090404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 17:44 +0400, Sergei Shtylyov wrote:
>     That's what gcc thinks. The code is 100% correct -- it will never reach 
> the switch statement with mode > 0 (in which case ultra_mask isn't used) and 
> ultra_mask unitialized. I may add an explicit initializer in the declaration 
> if you like...

Please leave the warning, this was discussed recently in other threads
and hiding warnings is very dangerous.

