From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 12:00:19 -0500
Message-ID: <492C2F23.8050105@garzik.org>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53774 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbYKYRAY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 12:00:24 -0500
In-Reply-To: <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

David Daney wrote:
> The forthcoming OCTEON SOC Compact Flash driver needs a few more
> timing values than were available in the ata_timing table.  I add new
> columns for write_hold, read_hold, and read_holdz times.  The values
> were obtained from the Compact Flash specification Rev 4.1.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
>  include/linux/libata.h    |   14 ++++++--
>  2 files changed, 52 insertions(+), 38 deletions(-)

I would be happy to go ahead and apply this...  Alan, any last minute 
objections?

