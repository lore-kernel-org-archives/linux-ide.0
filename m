From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/14] sata_mv Enable NCQ operation
Date: Fri, 25 Jan 2008 23:26:59 -0500
Message-ID: <479AB693.5060802@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FD22.9020700@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57361 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbYAZE1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:27:01 -0500
In-Reply-To: <4798FD22.9020700@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Enable NCQ operation.
> 
> Final changes to actually turn on NCQ in the driver for GEN II/IIE 
> hardware.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

ACK

though personally I would merge the ->dev_config() patch into this one


