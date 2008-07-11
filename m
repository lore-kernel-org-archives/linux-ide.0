From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-acpi: filter out DIPM enable
Date: Fri, 11 Jul 2008 09:38:43 -0400
Message-ID: <48776263.3040103@garzik.org>
References: <4870D367.40106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50570 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbYGKNis (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jul 2008 09:38:48 -0400
In-Reply-To: <4870D367.40106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, =?UTF-8?B?TWF0aA==?= =?UTF-8?B?aWV1IELDqXJhcmQ=?= <Mathieu.Berard@crans.org>

Tejun Heo wrote:
> Some BIOSen enable DIPM via _GTF which causes command timeouts under
> certain configuration.  This didn't occur on 2.6.25 because 2.6.25
> defaulted to SRST, so _GTF wasn't executed during boot probe, so ahci
> host reset disabled DIPM and as _GTF wasn't executed after SRST, DIPM
> wasn't enabled.  On 2.6.26, hardreset is used during probe and after
> probe _GTF is executed enabling DIPM and thus the failures.
> 
> This patch could theoretically disable DIPM on machines which used to
> have it enabled on 2.6.25 but AFAIK ahci is currently the only driver
> which uses SATA ACPI hierarchy (_SDD) and as the host reset would have
> always disabled DIPM, this shouldn't happen.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-acpi.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

applied


