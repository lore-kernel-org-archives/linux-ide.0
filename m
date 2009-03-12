From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Thu, 12 Mar 2009 10:31:31 -0400
Message-ID: <49B91CC3.8010405@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <200903121240.55194.elendil@planet.nl> <49B918D1.7020407@rtr.ca> <200903121527.35325.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38393 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbZCLObf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Mar 2009 10:31:35 -0400
In-Reply-To: <200903121527.35325.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> On Thursday 12 March 2009, Mark Lord wrote:
..
>> Exactly, *how*, did you "disable NCQ blink mode".
> 
> # echo 1 >/sys/block/sda/device/queue_depth
..

Okay, good.  Just making sure of things, thanks.
