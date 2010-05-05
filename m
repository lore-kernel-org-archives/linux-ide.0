From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ata: blacklist FUJITSU MHW2160BH PL
Date: Wed, 05 May 2010 17:33:38 -0600
Message-ID: <4BE20052.8000902@gmail.com>
References: <20100504163257.5DFE5F899A@sepang.rtg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:50774 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0EEXdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 19:33:42 -0400
Received: by iwn35 with SMTP id 35so7133164iwn.21
        for <linux-ide@vger.kernel.org>; Wed, 05 May 2010 16:33:41 -0700 (PDT)
In-Reply-To: <20100504163257.5DFE5F899A@sepang.rtg.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Gardner <timg@tpi.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 05/04/2010 10:32 AM, Tim Gardner wrote:
>  From e21186c4fc02cdd1932365d39d1ba7b2e48417f3 Mon Sep 17 00:00:00 2001
> From: Chuck Short<zulcss@ubuntu.com>
> Date: Fri, 18 Jan 2008 13:21:16 -0500
> Subject: [PATCH] ata: blacklist FUJITSU MHW2160BH PL
>
> OriginalAuthor: Chuck Short<zulcss@ubuntu.com>
> BugLink: http://bugs.launchpad.net/bugs/175834
>
> Signed-off-by: Chuck Short<zulcss@ubuntu.com>
> Signed-off-by: Tim Gardner<tim.gardner@canonical.com>
>
> Signed-off-by: Ben Collins<ben.collins@canonical.com>
> ---
>   drivers/ata/libata-core.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 49cffb6..3100827 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4369,6 +4369,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
>   	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
>   	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
> +	{ "FUJITSU MHW2160BH PL", "0084001E",   ATA_HORKAGE_NONCQ, },
>
>   	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
>   	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },

NACK. The spurious completion detection in AHCI, which the bug report 
said was being triggered, was incorrect and was removed long ago.
