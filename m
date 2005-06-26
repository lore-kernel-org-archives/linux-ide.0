From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Sun, 26 Jun 2005 13:08:54 -0400
Message-ID: <42BEE126.6070208@pobox.com>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl> <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl> <42BE0B7D.4050307@rtr.ca> <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl> <42BEB4B0.8090405@pobox.com> <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:57547 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261465AbVFZRJA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:09:00 -0400
In-Reply-To: <Pine.LNX.4.62.0506261612420.9277@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Krzysztof Oledzki wrote:
> So, excuse me for asking this question again: how to check true 
> (current) speed? I still don't know if this disk uses UDMA/133 or SATA150.

This is an irrelevant question, because the answer is "both."

The SATA bus speed is always 1.5Gbps, 3Gbps, etc. but the device must 
also set udma speed (udma0-6).

	Jeff


