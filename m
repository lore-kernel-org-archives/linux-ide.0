From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Wed, 10 Dec 2008 10:58:10 +0900
Message-ID: <493F2232.8070105@kernel.org>
References: <493E289F.1010000@kernel.org> <493E8B4C.4090604@ru.mvista.com> <493EBF57.7090200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47649 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbYLJB6k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 20:58:40 -0500
In-Reply-To: <493EBF57.7090200@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello, Sergei.

Sergei Shtylyov wrote:
>>    Alas, NAK.
> 
>    If you say that it does work, then the datasheet appears to be wrong,
> so have my:
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Yeah, AFAICS, it does work.  The ata66 register is always 0x3 with 40c
cable and 0x1 with 80c regardless of the PCI function.

Thanks.

-- 
tejun
