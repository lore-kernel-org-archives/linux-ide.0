From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 01/15] libata: Setup nbytes in ata_sg_init_one
Date: Thu, 09 Feb 2006 02:14:21 -0500
Message-ID: <43EAEBCD.2050303@pobox.com>
References: <200602061542.k16FgM45024404@d03av04.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:54425 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422857AbWBIHOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 02:14:24 -0500
In-Reply-To: <200602061542.k16FgM45024404@d03av04.boulder.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

brking@us.ibm.com wrote:
> Setup nbytes in ata_sg_init_one to the total transfer length
> of the command.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>

ACK, but I will wait for your resend to apply any of these patches. 
[see comments coming soon, for later patches]

