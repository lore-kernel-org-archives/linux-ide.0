From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 13 May 2004 09:07:13 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084460833.5303.45.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:16082 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263592AbUEMPHi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 11:07:38 -0400
In-Reply-To: <1084403654.3196.31.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

> Please choose for me from:
> 
> 1) Keep only the atapi_start/ ata_tf_to_host_nolock/
> ata_exec_command_pio.
> 
> 2) Keep only the worker_thread/ atapi_packet_task/ ata_bmdma_start_pio/
> ata_exec_command_pio.
> 
> 3) Try something else entirely.

I'll first try keeping only the ata_exec_command_pio of
ata_bmdma_start_pio.

I'm thinking we want the bus mastering DMA set up to reliably catch the
rising edge of a potentially rapid device INTRQ before we write the last
"word" of Command Out.

Pat LaVarre


