From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: DRDY ata message > 2.6.24.7-rt14, not before.
Date: Fri, 27 Feb 2009 17:54:38 -0500
Message-ID: <49A86F2E.3080701@pobox.com>
References: <3aa654a40902270944h3edeadf4pc9fb7587b76d7e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43113 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472AbZB0Wyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 17:54:45 -0500
In-Reply-To: <3aa654a40902270944h3edeadf4pc9fb7587b76d7e9e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Avuton Olrich <avuton@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@pobox.com>

Avuton Olrich wrote:
> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata4.00: cmd 35/00:10:b0:70:75/00:00:1f:00:00/e0 tag 0 dma 8192 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)


Since you are seeing generic timeouts, without additional information, I 
would guess either a problem with interrupt delivery (not uncommon in 
-rt kernels) or you need to force your drives to 1.5Gbps.

	Jeff


