From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Sat, 03 Aug 2013 18:52:32 +0400
Message-ID: <51FD1930.3000909@cogentembedded.com>
References: <1375500896-22955-1-git-send-email-marc.ceeeee@gmail.com> <1375500896-22955-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:33087 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab3HCOwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Aug 2013 10:52:25 -0400
Received: by mail-la0-f50.google.com with SMTP id fn20so1099890lab.37
        for <linux-ide@vger.kernel.org>; Sat, 03 Aug 2013 07:52:24 -0700 (PDT)
In-Reply-To: <1375500896-22955-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello.

On 03-08-2013 7:34, Marc C wrote:

> From: Marc C <marc.ceeeee@gmail.com>

    Real name is required in signoff.

> Add support for the following ATA opcodes, which are present
> in SATA 3.1 and T13 ATA ACS-3:

>          SEND FPDMA QUEUED
>          RECEIVE FPDMA QUEUED

> Signed-off-by: Marc C <marc.ceeeee@gmail.com>
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

    The 'struct ata_taskfile' has been moved to libata.h for 3.12, so you are 
basing your work off of the wrong branch. And what does this new field have to 
do with the classical ATA taskfile registers? Can't we place it into 'struct 
ata_queued_cmd'?

WBR, Sergei

