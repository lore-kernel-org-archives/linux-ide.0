From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: How to put an ata_piix (SATA) harddisk to sleep/standby
Date: Thu, 11 Aug 2005 16:34:52 -0400
Message-ID: <42FBB66C.3020008@pobox.com>
References: <loom.20050811T214109-933@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:42920 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932442AbVHKUez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:34:55 -0400
In-Reply-To: <loom.20050811T214109-933@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dick <dm@chello.nl>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Dick wrote:
> How do I put an SATA ata_piix harddisk to sleep?
> 
> I've tried blktool, hdparm and sdparm but none seem to work, does it need a
> special ioctl or should I patch something?

Apply the ATA passthru patch, or grab the latest 'upstream' branch of 
libata-dev.git and use the SCSI START STOP UNIT change I checked in last 
night.

	Jeff



