From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Sun, 23 Jun 2013 23:34:19 +0400
Message-ID: <51C74DBB.8030402@cogentembedded.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32802 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3FWTeV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jun 2013 15:34:21 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so9325189lab.5
        for <linux-ide@vger.kernel.org>; Sun, 23 Jun 2013 12:34:20 -0700 (PDT)
In-Reply-To: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: aaron.lu@intel.com

Hello.

On 06/23/2013 11:25 PM, Sergei Shtylyov wrote:

> There are  some SATA controllers which have both devices 0 and 1 but this module
> just zeroes out taskfile and sets then ATA_TFLAG_DEVICE (not sure that's needed)
> which could  lead to a wrong device being selected just before issuing command.
> Thus we should  call ata_tf_init()  which sets  up the device register value
> properly, like  all other users of ata_exec_internal() do...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Forgot to add Cc: stable@vger.kernel.org...

WBR, Sergei

