From: Mark Lord <liml@rtr.ca>
Subject: Re: More ATA corner cases
Date: Wed, 16 Aug 2006 18:50:37 -0400
Message-ID: <44E3A13D.20102@rtr.ca>
References: <1155731962.24077.346.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:26521 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932310AbWHPWuj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2006 18:50:39 -0400
In-Reply-To: <1155731962.24077.346.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> Any objection to me adding a new cable type for "40 wire ATA66 capable"
> to indicate the laptop vendor has been sneaky and we should do full UDMA
> ranges regardless of drive or other controller reporting.

Good.  I'll need that feature for a little mini-ITX box here as well.
It uses a *really short* 40W cable for UDMA4 operation.

Cheers 
