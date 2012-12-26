From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: replace sata_settings with devslp_timing
Date: Wed, 26 Dec 2012 14:41:16 +0400
Message-ID: <50DAD44C.9020102@mvista.com>
References: <1355757539-4529-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:46042 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2LZKlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2012 05:41:20 -0500
Received: by mail-la0-f43.google.com with SMTP id z14so10358748lag.2
        for <linux-ide@vger.kernel.org>; Wed, 26 Dec 2012 02:41:19 -0800 (PST)
In-Reply-To: <1355757539-4529-1-git-send-email-shane.huang@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, stable@kernel.org

Hello.

On 17-12-2012 19:18, Shane Huang wrote:

> NCQ capability was used to check availability of SATA Settings page
> from Identify Device Data Log, which contains DevSlp timing variables.
> It does not work on some HDDs and leads to error messages.

> IDENTIFY word 78 bit 5(Hardware Feature Control) can't work either
> because it is only the sufficient condition of Identify Device data
> log, not the necessary condition.

> This patch replaced ata_device->sata_settings with ->devslp_timing
> to only save DevSlp timing variables(8 bytes), instead of the whole
> SATA Settings page(512 bytes).

> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: stable@kernel.org

    The new address is stable@vger.kernel.org. The old address doesn't work 
anymore.

MBR, Sergei

