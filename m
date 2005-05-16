From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.12-rc2 2/2] libata: add basic atapi error reporting
Date: Sun, 15 May 2005 22:43:00 -0400
Message-ID: <428808B4.8040102@pobox.com>
References: <4261C20B.7010403@shore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52377 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261234AbVEPCnF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 22:43:05 -0400
In-Reply-To: <4261C20B.7010403@shore.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric A. Cottrell" <eac@shore.net>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Eric A. Cottrell wrote:
> Hello Jeff,
> 
> Problem:
> ATAPI errors are not fully reported to the SCSI subsystem.  A check 
> condition was returned but the SCSI subsystem does not get the sense 
> from the device.  This causes problems when unimplemented and bad SCSI 
> commands are sent to an atapi device.

This is a bit strange.  It should get the sense from the device.  It is 
requested from ata_qc_timeout().  Is this not happening for you?

	Jeff



