From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #NEXT] libata: add command name parsing for error output
Date: Fri, 17 Jul 2009 13:04:51 +0900
Message-ID: <4A5FF863.9070105@kernel.org>
References: <4A5D425B.4080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51798 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbZGQEFx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Jul 2009 00:05:53 -0400
In-Reply-To: <4A5D425B.4080300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

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

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
