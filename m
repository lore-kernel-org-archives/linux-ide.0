From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 15:56:27 -0400
Message-ID: <49BC0BEB.1020204@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>	<alpine.BSF.1.00.0903142010100.59456@anduin.net>	<49BC041B.4040700@garzik.org> <20090314194245.7d15a9ae@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32978 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbZCNT4j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 15:56:39 -0400
In-Reply-To: <20090314194245.7d15a9ae@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan-lkml@anduin.net>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> It is the same logical change, and therefore should not be broken up 
>> into 73 tiny patches.
> 
> I'd rather the functional changes ones were kept separated for bisection
> purposes but agreed

Were there functional changes in this patchset?

If yes, I missed that.  It looked like all no-functional-change 
replacement to me.

	Jeff



