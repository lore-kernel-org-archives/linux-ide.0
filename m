From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/68] ide2libata
Date: Tue, 02 Feb 2010 18:10:07 -0500
Message-ID: <4B68B0CF.1040907@garzik.org>
References: <20100201114824.29682015@lxorguk.ukuu.org.uk>	<20100201.044813.27473014.davem@davemloft.net>	<20100201125845.3f468363@lxorguk.ukuu.org.uk> <20100201.051432.226757615.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:65500 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756928Ab0BBXKQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:10:16 -0500
In-Reply-To: <20100201.051432.226757615.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/01/2010 06:17 AM, David Miller wrote:
> And then once that hard work is done, we kind of just toss it
> for one side of the equation?
[...]

On 02/01/2010 08:14 AM, David Miller wrote:
> I have not advocated the ifdef implementation.
>
> I have advocated one where the data structures are actually
> the same, and there are no ifdefs.

It all sounds like the exact opposite of what you said seven months ago:

	I'm going to treat IDE as pure legacy, rather than as
	competition with the PATA drivers which is what people whould
	be moving over to.

	And more importantly I refuse to apply any driver patch that
	isn't actually tested on said hardware.

It's either legacy, or it isn't.  It's either bug-fixes-only, or it 
isn't.  Touching, quite literally, _100%_ of the IDE drivers does not 
meet the criteria of "pure legacy" nor likely "actually tested on said 
hardware."

But hey...  if you want to accept patches slowly turning IDE into 
libata, that's your call :)  It just seems quite contrary to what has 
been sold to the remaining IDE users.

	Jeff



