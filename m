From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: add "em_buffer" attribute for AHCI hosts
Date: Mon, 29 Mar 2010 16:15:56 -0400
Message-ID: <4BB10A7C.7000400@pobox.com>
References: <1268131075.2000.6.camel@harry-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:31872 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab0C2UP6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 16:15:58 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3345793qwh.37
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 13:15:58 -0700 (PDT)
In-Reply-To: <1268131075.2000.6.camel@harry-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

On 03/09/2010 05:37 AM, Harry Zhang wrote:
> Add "em_buffer" attribute for SATA AHCI hosts to enable user access AHCI EM
> (enclosure management) buffer in user space if the host support EM.
>
> AHCI driver should support SGPIO EM message. However the SATA/AHCI spec does no
> define the SGPIO message format filled in EM buffer. Different HW vendors may
> have different definitions. The mainly purpose of "em_buffer" attribute is to
> solve this issue by allowing HW vendors to provide user space SGPIO drivers and
> tools.
>
> Signed-off-by: Harry Zhang<harry.zhang@amd.com>
> ---
>   drivers/ata/ahci.c        |   73 +++++++++++++++++++++++++++++++++++++++++---
>   drivers/ata/libata-scsi.c |   14 ++++++++
>   include/linux/libata.h    |    3 ++
>   3 files changed, 85 insertions(+), 5 deletions(-)

As noted in the email about ahci rebase, please update this patch 
against the latest libata-dev.git#upstream, which includes copious ahci 
changes.

Thanks,

	Jeff




