From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 00/12] sata_mv NCQ support
Date: Fri, 25 Jan 2008 23:14:57 -0500
Message-ID: <479AB3C1.2070401@pobox.com>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41182 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbYAZEPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:15:01 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Here is a set of 12 patches that gradually add working NCQ support to 
> sata_mv.
> 
> The driver still has issues afterwards, but nothing new that wasn't 
> broken already.
> I am working on additional patches to correct the interrupt and error 
> handling
> problems that still exist in the driver, as well as PMP and ATAPI 
> support (later).
> 
> Patches are against Jeff's #upstream git from this morning.

Patch process note:

Please don't duplicate the one-line summary found in the email subject 
line, in the email body.  That causes all standard automated tools to 
copy that line twice into the permanent kernel changelog -- provided I 
don't go back and hand-edit each of the 15 patches.


