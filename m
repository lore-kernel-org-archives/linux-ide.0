From: Mark Lord <liml@rtr.ca>
Subject: Re: PATCH: Add full Compact Flash support to libata
Date: Thu, 27 Jul 2006 13:41:57 -0400
Message-ID: <44C8FAE5.1000400@rtr.ca>
References: <1154016810.13509.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:53189 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750961AbWG0Rl7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jul 2006 13:41:59 -0400
In-Reply-To: <1154016810.13509.61.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> This is mostly interesting from the embedded end of the universe
> where people use the CFA high speed non UDMA modes more. Some generic
> controllers can do PIO5 and friends, that will follow later on.

Cool.  Do you have one to test with?

If so, please send/post the output of "hdparm --Istdout" from such a device.

Thanks!
