From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: Re: PATA_ARTOP reads byte from PCI IO port without mapping it to
 the right address.
Date: Wed, 30 Mar 2011 20:48:26 +0100
Message-ID: <4D93890A.60307@danielpalmer.co.uk>
References: <4D937FDC.4090607@danielpalmer.co.uk> <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:34554 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754838Ab1C3Tsf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 15:48:35 -0400
In-Reply-To: <20110330202628.5dc8db5f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


>  That is the PCI port address.

I don't pretend to understand most of this fully.
On the board the PCI address space/PCI controller is apparently at 
0xfe240000
So I guess that when that byte is read it should read from 0xfe240000 + 
0x1400?
That doesn't happen and a read happens at 0x1400 and an oops results.
I don't know enough to point the finger really.

There are probably only 2 people using this board still too. So I doubt 
it really matters. :)

Cheers,

Daniel


