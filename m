From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.20) pata_oldpiix: fix PIO2 underclocking
Date: Mon, 01 Jun 2009 18:21:51 +0400
Message-ID: <4A23E3FF.7080307@ru.mvista.com>
References: <200702051945.38972.sshtylyov@ru.mvista.com>	<4A22853A.2050600@ru.mvista.com> <20090601144112.55538667@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52717 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750965AbZFAOUf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jun 2009 10:20:35 -0400
In-Reply-To: <20090601144112.55538667@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:

>>Hello, I wrote:

>>>Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
>>>fast timing bank starting with PIO2, just like the ata_piix driver does.
>>>Also, fix/rephrase some comments while at it.

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>   Hm, looks like pata_efar still needs the same fix...

> I can't find the original email (not in my archive for 2008 or 2009) but
> the comment makes sense

    It was the patch merged back in 2007. I'll submit the pata_efar patch 
shortly.

MBR, Sergei
