From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ahci: use ATA_BUSY
Date: Sun, 23 Jun 2013 01:16:31 +0400
Message-ID: <51C6142F.4010602@cogentembedded.com>
References: <201306230114.37999.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54520 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3FVVQX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jun 2013 17:16:23 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so8910592lab.33
        for <linux-ide@vger.kernel.org>; Sat, 22 Jun 2013 14:16:22 -0700 (PDT)
In-Reply-To: <201306230114.37999.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

Hello.

On 06/23/2013 01:14 AM, Sergei Shtylyov wrote:

> ahci_p5wdh_hardreset() uses bare number for the BSY bit of the ATA status
> register, despite it's #define'd in <linux/ata.h>.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
The patch is against 'for-3.11' branch of the 'libata.git' repo.

WBR, Sergei

