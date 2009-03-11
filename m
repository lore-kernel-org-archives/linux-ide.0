From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][0/2] sata_mv: harddisk activity led no longer responsive
 on QNAP TS-109
Date: Wed, 11 Mar 2009 08:58:05 -0400
Message-ID: <49B7B55D.80804@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <49B7AF88.5050900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38625 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810AbZCKM6L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 08:58:11 -0400
In-Reply-To: <49B7AF88.5050900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Mark Lord wrote:
> Frans,
> 
> How many HDD activity LEDs does your SoC system have?
> 
> Just one, for all channels?
> Or several -- one for *each* channel?
..

Oh, nevermind, as that doesn't really matter,
because there's only one global "blink mode" enable bit
used for all ports.

-ml
