From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata passthru: support PIO multi commands
Date: Wed, 13 Jun 2007 14:55:06 -0400
Message-ID: <46703D8A.4040403@garzik.org>
References: <200706112200.l5BM0qFn005767@hera.kernel.org>	<20070611233917.4bd8c6d7@the-village.bc.nu>	<466DE438.70108@garzik.org>	<20070612111621.10074408@the-village.bc.nu>	<466EB937.6050807@garzik.org> <20070612170519.5f427a70@the-village.bc.nu> <466F5D11.7000404@tw.ibm.com> <46703DB1.9010702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38460 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbXFMSzP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jun 2007 14:55:15 -0400
In-Reply-To: <46703DB1.9010702@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: albertl@mail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
>    This is generally a bad practice to guess protocol based on opcode. 
> What if the code will have to handle a vendor unique command (or some 
> other command not yet known to it but known to issuer)?

Agreed -- we simply cannot rely on guessing protocol from opcode, we 
MUST take the protocol that is specified.

	Jeff


