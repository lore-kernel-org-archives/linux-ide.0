From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3 1/1] [libata] SCSI: really use SATL version in VPD
Date: Thu, 11 Apr 2013 19:45:16 -0400
Message-ID: <51674B0C.1020206@pobox.com>
References: <satl-driver-version-v3> <1365178306-17363-1-git-send-email-baruch@ev-en.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48648 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Apr 2013 19:45:23 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so341843qcq.19
        for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2013 16:45:21 -0700 (PDT)
In-Reply-To: <1365178306-17363-1-git-send-email-baruch@ev-en.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Baruch Even <baruch@ev-en.org>
Cc: linux-ide@vger.kernel.org

On 04/05/2013 12:11 PM, Baruch Even wrote:
> As per c78968bb by Jeff Garzik ([libata] SCSI: simulator version, not device
> version, belongs in VPD) We need to provide the SATL driver version and not the
> disk firmware version but the code overwrites the driver version with the disk
> version.
>
> Signed-off-by: Baruch Even <baruch@ev-en.org>
> ---
>   drivers/ata/libata-scsi.c |    1 -
>   1 file changed, 1 deletion(-)

applied



