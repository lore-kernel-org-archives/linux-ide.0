From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Thu, 08 Aug 2013 21:50:11 +0400
Message-ID: <5203DA53.6000800@cogentembedded.com>
References: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com> <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:52520 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965973Ab3HHRuK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 13:50:10 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so2289635lab.22
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 10:50:06 -0700 (PDT)
In-Reply-To: <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 08/08/2013 11:16 AM, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> Add support for the following ATA opcodes, which are present
> in SATA 3.1 and T13 ATA ACS-3:

>          SEND FPDMA QUEUED
>          RECEIVE FPDMA QUEUED

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>

[...]

> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index ee0bd95..dd26211 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
[...]
> @@ -509,6 +525,8 @@ struct ata_taskfile {
>   	u8			device;
>
>   	u8			command;	/* IO operation */
> +
> +	u32			auxiliary;

    You are still basing your work on the wrong branch -- you should use Tejun 
Heo's libata.git, 'for-3.12' branch. And you haven't removed this field from 
'struct ata_taskfile'...

WBR, Sergei

