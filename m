From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-acpi: Fix NULL ptr derference in ata_acpi_dev_handle
Date: Thu, 15 Nov 2012 23:22:25 -0500
Message-ID: <50A5BF81.5080303@pobox.com>
References: <5073D44C.7070101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40062 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2KPEWa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 23:22:30 -0500
In-Reply-To: <5073D44C.7070101@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Dan van der Ster <dan@vanderster.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On 10/09/2012 03:37 AM, Aaron Lu wrote:
> commit 6b66d95895c149cbc04d4fac5a2f5477c543a8ae didn't handle SATA PMP
> case in ata_acpi_bind_device and will cause a NULL ptr dereference when
> user attached a SATA drive to the PMP port. Fix this by checking PMP
> support.
>
> This bug is reported by Dan van der Ster in the following bugzilla page:
> https://bugzilla.kernel.org/show_bug.cgi?id=48211
>
> Reported-by: Dan van der Ster <dan@vanderster.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/ata/libata-acpi.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

applied, with added Tested-by labels



