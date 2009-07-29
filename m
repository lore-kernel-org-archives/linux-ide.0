From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #NEXT] libata: add command name parsing for error output
Date: Tue, 28 Jul 2009 21:19:57 -0400
Message-ID: <4A6FA3BD.8030307@garzik.org>
References: <4A5D425B.4080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40814 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbZG2BT7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:19:59 -0400
In-Reply-To: <4A5D425B.4080300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> This patch improve libata's output for error/notification messages to allow easier
> comprehension and debugging:
> 
> When ATAPI commands issued through the SCSI layer fail, use SCSI functions
> to print the CDB in human-readable form instead of just dumping out the CDB
> in hex.
> 
> Print out the name of the failed command (as defined by the ATA specification)
> in error handling output along with the raw register contents.
> 
> When reporting status of ACPI taskfile commands executed on resume, also output
> the names of the commands being executed (or not) in readable form.
> 
> Since the extra data for printing command names increases kernel size slightly,
> a config option has been added to allow disabling command name output
> (as well as some of the error register parsing) for those highly sensitive to
> kernel text size.
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

applied...  nice!

any chance you wanna work on filling out ata_msg_*/ATA_MSG_*?

Such a feature should permit people to change libata debugging output at 
runtime, on a per-port basis, via sysfs.

That's always been the ideal, and was the idea when ata_msg_* was 
originally added.  Would _immensely_ help with debugging.

	Jeff




