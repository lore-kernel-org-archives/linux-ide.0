From: Mark Lord <liml@rtr.ca>
Subject: Re: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Thu, 02 Apr 2009 13:25:08 -0400
Message-ID: <49D4F4F4.6040406@rtr.ca>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55892 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934192AbZDBRZK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 13:25:10 -0400
In-Reply-To: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: salimmu@beardog.cca.cpqcorp.net
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com

salimmu@beardog.cca.cpqcorp.net wrote:
> Attach is a patch that adds translation of scsi WRITE_BUFFER to ATA_DOWNLOAD_MICROCODE command.\
..

Do we really need or want this extra code in-kernel?

This type of thing is already doable from user-space with SG_IO + ATA_16.
Eg.  hdparm --fwdownload

???
