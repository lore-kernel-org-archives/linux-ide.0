From: Saeed Bishara <saeed@marvell.com>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Mon, 11 Feb 2008 08:06:45 -0500
Message-ID: <47B04865.2070007@marvell.com>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk> <47ABDC1C.9050507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:17296 "EHLO
	il.marvell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbYBKL1G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 06:27:06 -0500
In-Reply-To: <47ABDC1C.9050507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Byron Bradley <byron.bbradley@gmail.com>, linux-ide@vger.kernel.org, mlord@pobox.com, jeff@garzik.org, linux-arm-kernel@lists.arm.linux.org.uk

Mark Lord wrote:
> Byron Bradley wrote:
>> I'm having problems getting the sata_mv driver working as a platform
>> driver on the QNAP TS-209 and the Linkstation/Kurobox (both are Marvell
>> Orion 88f5182 based devices). First of all it would oops in
>> mv_port_start() while calling dma_pool_alloc(), the patch to fix this is
>> at the end of this email.
> ..
> 
> Ouch.  I'd say this is proof-positive that Saeed did not even test his
> latest patches.  Your fix below looks straightforward and correct.
you're right, the fix is definitely needed, seems I was checking the wrong image :(.
> 

