From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 2/3] pata_hpt366: fix cable detection
Date: Mon, 08 Dec 2008 16:59:02 +0300
Message-ID: <493D2826.1040106@ru.mvista.com>
References: <493CED7A.2010505@kernel.org>	<493CEE74.3060601@kernel.org>	<493D03A4.1090409@ru.mvista.com> <20081208114442.6310391d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34734 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751767AbYLHN7I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2008 08:59:08 -0500
In-Reply-To: <20081208114442.6310391d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello.

Alan Cox wrote:

>>> 	pci_read_config_byte(pdev, 0x5A, &ata66);
>>>-	if (ata66 & (1 << ap->port_no))
>>>+	if (ata66 & (2 >> ap->port_no))

>>   HPT36x are single channel per function, so the shift can be removed.

> In the case of two channels are you sure the bits appear as bit 2 in both
> cases ?

    Oops, they don't. The cable select register (0x5a) seems to be shared by 
both functions (with function 0 representing "primary" and the function 1 
"secondary" channel). But in this case, the logic remains broken -- I don't 
think that function #1 has its ap->port_no set to 1. The IDE driver appears 
broken as well then. Damn Highpoint for their brain damaged design...

> Alan

MBR, Sergei
