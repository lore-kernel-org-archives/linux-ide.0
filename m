From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver
 specific flag
Date: Fri, 10 Apr 2015 20:02:11 +0300
Message-ID: <55280213.9000601@cogentembedded.com>
References: <201504092009.08703.ronny.hegewald@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33400 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbbDJRCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2015 13:02:15 -0400
Received: by layy10 with SMTP id y10so17690437lay.0
        for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2015 10:02:13 -0700 (PDT)
In-Reply-To: <201504092009.08703.ronny.hegewald@online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ronny Hegewald <ronny.hegewald@online.de>, linux-ide@vger.kernel.org

Hello.

On 04/09/2015 11:09 PM, Ronny Hegewald wrote:

> The patch "libata: allow sata_sil24 to opt-out of tag ordered submission"
> (72dd299d5039a336493993dcc63413cf31d0e662) introduces a regression with the
> sata_sil24 driver.

> The new flag ATA_FLAG_LOWTAG accidentially uses the same bit as

    Accidentally.

> SIL24_FLAG_PCIX_IRQ_WOC in the driver. This activates code for Silicon Image
> 3132, which is only suppossed to run under 3124.

    Supposed.

> ATA_FLAG_LOWTAG is only used in sata_sil24 and is planned to be removed soon,
> so lets just use another bit for the flag in sata_sil24.

    Actually, ATA_FLAG_LOWTAG has been removed in the 'for-next' branch, so 
this patch is no longer needed. Moreover, the newly assigned flag clashes with 
the new ATA_FLAG_SATA_PORT.

> Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>

[...]

MBR, Sergei

