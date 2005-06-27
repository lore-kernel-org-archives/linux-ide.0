From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Mon, 27 Jun 2005 16:53:41 -0400
Message-ID: <42C06755.6010604@rtr.ca>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl> <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl> <42BE0B7D.4050307@rtr.ca> <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl> <42BEB4B0.8090405@pobox.com> <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:23558 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261779AbVF0Uxp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jun 2005 16:53:45 -0400
In-Reply-To: <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Krzysztof Oledzki wrote:
> 
> So, excuse me for asking this question again: how to check true 
> (current) speed? I still don't know if this disk uses UDMA/133 or SATA150.

Inside the drive itself, it *may* be using UDMA/133 to transfer data
between the PATA circuitry and the SATA bridge chip (inside the drive).
Not all drives are built that way (in which case the drive is merely
trying to keep people like you happy by reporting these obsolete fields)
but many SATA drives are.

Outside the drive, over the SATA cable, it is SATA150 just like
every other SATA1 drive.

-ml
