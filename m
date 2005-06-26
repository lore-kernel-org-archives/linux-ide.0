From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Sat, 25 Jun 2005 21:57:17 -0400
Message-ID: <42BE0B7D.4050307@rtr.ca>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl> <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:17157 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261550AbVFZB5Y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Jun 2005 21:57:24 -0400
In-Reply-To: <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-ide@vger.kernel.org

Krzysztof Oledzki wrote:
>
> # hdparm -I /dev/sda
> 
> /dev/sda:
> (...)
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
> (...)
> 
> This one? udma6?

Yup.  udma6 == UDMA/133

Cheers
