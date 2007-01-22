From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Mon, 22 Jan 2007 23:28:51 +0300
Message-ID: <45B51E83.1010904@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	<20070119003226.14846.87052.sendpatchset@localhost.localdomain>	<45B4FFBD.40507@ru.mvista.com> <20070122184620.1c8b87ac@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36756 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751980AbXAVU24 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Jan 2007 15:28:56 -0500
In-Reply-To: <20070122184620.1c8b87ac@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan wrote:

>>    Ugh, I'm not seeing any *actual* support for MW/SW DMA in this driver... 

> Thats long been broken. Should be correct in the libata driver

    Here's a surprise for you. pata_cmd64x copied the SW/MW DMA setup code 
from the IDE driver.  No way it could be working.  You may check against the 
PC64x datasheets (if you have them -- if you don't I think I may share) and 
see for yourself -- it's abolutely idiotic.

> Alan

WBR, Sergei
