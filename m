From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Thu, 12 Mar 2009 15:27:33 +0100
Message-ID: <200903121527.35325.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <200903121240.55194.elendil@planet.nl> <49B918D1.7020407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:60842 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755094AbZCLO1i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 10:27:38 -0400
In-Reply-To: <49B918D1.7020407@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thursday 12 March 2009, Mark Lord wrote:
> > The LED behavior is correct with NCQ enabled: slow blink.
> > But if I disable NCQ blink mode is not turned off, the led continues
> > the slow blinking. So it looks as if just calling
> > mv_soc_led_blink_disable in mv_edma_cfg is not sufficient.
>
> Exactly, *how*, did you "disable NCQ blink mode".

# echo 1 >/sys/block/sda/device/queue_depth

With my own version of the patch this worked.
