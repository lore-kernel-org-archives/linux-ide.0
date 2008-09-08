From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 8 Sep 2008 16:16:01 +0200
Message-ID: <200809081616.03266.elendil@planet.nl>
References: <12207863853449-git-send-email-saeed@marvell.com> <200809080232.23834.elendil@planet.nl> <48C52B53.3030302@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml14.kpnxchange.com ([213.75.38.114]:37427 "EHLO
	hpsmtp-eml14.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753081AbYIHOQG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 10:16:06 -0400
In-Reply-To: <48C52B53.3030302@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

On Monday 08 September 2008, Mark Lord wrote:
> Frans Pop wrote:
> > So, IMO it is an improvement, but it is definitely not a fix for the
> > regression.
>
> With a new copy of hdparm, use "hdparm -Q1 /dev/sd?"
> Does that fix your "regression" ?

$ sudo hdparm -Q1 /dev/sda

/dev/sda:
 setting queue_depth to 1
 queue_depth   =  1

Yes, that does result in the original behavior of the led.
(Using version 8.9 of hdparm.)
