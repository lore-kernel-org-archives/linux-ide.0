From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 02 Jul 2004 11:58:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E58630.1000602@pobox.com>
References: <Pine.LNX.4.44.0407021648040.2190-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264658AbUGBP6z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 11:58:55 -0400
In-Reply-To: <Pine.LNX.4.44.0407021648040.2190-100000@einstein.homenet>
List-Id: linux-ide@vger.kernel.org
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-ide@vger.kernel.org

Tigran Aivazian wrote:
> if I enable CONFIG_IDE then IDE subsystem takes over 0170-0177
> and 01f0-01f7 io ranges and SATA gets "busy" error and doesn't handle the 
> hard disk (i.e. hard disk remains 3M/sec slow).

The quirk in drivers/pci/quirks.c should reserve one range for SATA, 
presuming that CONFIG_SCSI_SATA is set.


> As for CONFIG_BLK_DEV_IDE_SATA, there is no such thing:

> # find -name Kconfig | xargs fgrep CONFIG_BLK_DEV_IDE_SATA

You need to update your kernel, it looks like, that was recently added.


> My guess is that the solution to my problem is to compile both IDE and 
> SATA but somehow pass some "ide?=???" boot options which would tell IDE to 
> take over ide1 channel and let SATA handle the rest. Is this incorrect?

That's one way to do it.  ide?=noprobe probably.  But disabling 
CONFIG_BLK_DEV_IDE_SATA and enabling CONFIG_SCSI_SATA should get things 
going.

	Jeff


