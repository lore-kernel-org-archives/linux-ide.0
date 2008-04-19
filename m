From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: [PATCH] libata: fix boot panic with SATAPI devices on non-SFF
Date: Sat, 19 Apr 2008 19:52:24 -0400
Message-ID: <480A85B8.7030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9935 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYDSXwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Apr 2008 19:52:25 -0400
Received: from zippy.dorks.ca ([24.200.107.105]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JZL00AH3JMZ7Y10@VL-MO-MR005.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Sat, 19 Apr 2008 19:52:11 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 > If it's a panic with a SATA drive, then no it wouldn't ... the problem I
 > fixed was in SATAPI only (That's CD/DVD/Tape devices).  If you actually
 > post the boot log and panic, linux-ide and Tejun might be able to help.
 > Your brief snippet indicates the controller isn't finding sda, I think.
 >
 > James

Hi,

My system (nforce4 SATA) is also unbootable with commit 305d2a1a applied.  I 
verified that it works fine with current git with just that commit reverted.

After analyzing a bit more, I found that the key is in the slightly changed 
logic in ata_do_reset().  Previously, devices were changed from class 
ATA_DEV_UNKNOWN to ATA_DEV_NONE only if one device was found to be !UNKNOWN, but 
now the change is systematic.  Since my SATA disk is by itself on the port, this 
makes it become ATA_DEV_NONE where previously it was left as ATA_DEV_UNKNOWN 
when ata_do_reset() returned.

Changing this makes the system bootable again.

Cheers,
Marc
