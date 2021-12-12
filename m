Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE309C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 12 Dec 2021 09:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhLLJdy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Dec 2021 04:33:54 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:60140 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhLLJdy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2021 04:33:54 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 12F2920CFEDD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <272e7b2b-ba76-6225-e96b-4532db909e98@omp.ru>
Date:   Sun, 12 Dec 2021 12:33:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 13/68] libata: revamp ata_get_cmd_descript()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211210072905.15666-1-hare@suse.de>
 <20211210072905.15666-14-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211210072905.15666-14-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10.12.2021 10:28, Hannes Reinecke wrote:

> Rename ata_get_cmd_descrip() to ata_get_cmd_name() and simplify
> it to return 'unknown' instead of NULL.

    "unknown"?

> Signed-off-by: Hannes Reinecke <hare@suse.de>

[...]
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 69f51616d8bd..29a64059d3a1 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2080,16 +2080,15 @@ void ata_eh_autopsy(struct ata_port *ap)
>   }
>   
>   /**
> - *	ata_get_cmd_descript - get description for ATA command
> + *	ata_get_cmd_name - get description for ATA command

    s/description/name/?

>    *	@command: ATA command code to get description for

    Here as well?

>    *
> - *	Return a textual description of the given command, or NULL if the
> - *	command is not known.
> + *	Return a textual description of the given command or "unknown"

    And here?

>    *
>    *	LOCKING:
>    *	None
>    */
> -const char *ata_get_cmd_descript(u8 command)
> +const char *ata_get_cmd_name(u8 command)
>   {
>   #ifdef CONFIG_ATA_VERBOSE_ERROR
>   	static const struct
[...]

MBR, Sergey
