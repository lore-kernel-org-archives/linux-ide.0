From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.9-libata1-dev1] libata-scsi: hdparm support
Date: Sat, 30 Oct 2004 11:27:02 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4183B2C6.7090500@pobox.com>
References: <1098487253.28916.12.camel@server.lorenz.priv>	 <41838C6E.6050702@pobox.com> <1099148337.15964.4.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261213AbUJ3P1V
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Oct 2004 11:27:21 -0400
In-Reply-To: <1099148337.15964.4.camel@server.lorenz.priv>
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Tobias Lorenz wrote:
> Hi,
> 
> 
>>This patch doesn't apply, since it is prefixed with "> " ...
> 
> You are right... here is a corrected version.
> 
> This patch adds support for transfering drive informations via the
> hd_driveid structure to the hdparm utility. At the moment, only
> cylinders, sectors, heads, model and firmware version are transfered.

Applied to libata-dev...  I'll need to ponder the correctness a bit 
more, before pushing upstream.

	Jeff


