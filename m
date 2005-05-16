From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.12-rc2 2/2] libata: add basic atapi error reporting
Date: Mon, 16 May 2005 09:24:48 -0400
Message-ID: <42889F20.1000207@rtr.ca>
References: <4261C20B.7010403@shore.net> <428808B4.8040102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:24850 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261627AbVEPNYy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 09:24:54 -0400
In-Reply-To: <428808B4.8040102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric A. Cottrell" <eac@shore.net>, Linux IDE <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Eric A. Cottrell wrote:
>> condition was returned but the SCSI subsystem does not get the sense 
>> from the device.  This causes problems when unimplemented and bad SCSI 
>> commands are sent to an atapi device.
> 
> This is a bit strange.  It should get the sense from the device.  It is 
> requested from ata_qc_timeout().  Is this not happening for you?

This could happen as a result of the _eh_ race condition issues
that we're working on right now, I suppose.

I wonder if the patch from Hannes Reinecke fixes this?
