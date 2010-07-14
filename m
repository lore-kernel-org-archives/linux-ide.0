From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2]460EX on-chip SATA driver<resubmisison>
Date: Wed, 14 Jul 2010 03:51:44 -0400
Message-ID: <4C3D6C90.4030709@pobox.com>
References: <201007061106.o66B631f013777@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57559 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0GNHvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 03:51:49 -0400
In-Reply-To: <201007061106.o66B631f013777@amcc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rsarmah@apm.com, sr@denx.de, linuxppc-dev@ozlabs.org

On 07/06/2010 07:06 AM, Rupjyoti Sarmah wrote:
> This patch enables the on-chip DWC SATA controller of the AppliedMicro processor 460EX.
>
> Signed-off-by: Rupjyoti Sarmah<rsarmah@appliedmicro.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@appliedmicro.com>
> Signed-off-by: Prodyut Hazarika<phazarika@appliedmicro.com>
>
> ---
> This patch incorporates the changes advised in the mailing list. The device
> tree changes were submitted as a seperate patch. Kconfig file is fixed in this version.
>
>   drivers/ata/Kconfig          |    9 +
>   drivers/ata/Makefile         |    1 +
>   drivers/ata/sata_dwc_460ex.c | 1756 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1766 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/sata_dwc_460ex.c

applied


