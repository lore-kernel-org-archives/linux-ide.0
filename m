From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Wed, 15 Jul 2015 20:23:33 +0300
Message-ID: <55A69715.20901@cogentembedded.com>
References: <1436961277-4069-1-git-send-email-arne_f@ipfire.org> <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36257 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGORXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2015 13:23:37 -0400
Received: by lbbpo10 with SMTP id po10so29052336lbb.3
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2015 10:23:36 -0700 (PDT)
In-Reply-To: <1436961277-4069-2-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org

Hello.

On 07/15/2015 02:54 PM, Arne Fitzenreiter wrote:

> Some devices lose data on TRIM whether queued or not.  This patch adds
> a horkage to disable TRIM.

> Signed-off-by: Arne Fitzenreiter <arne_f@ipfire.org>

    Sorry for not complaining about the below items earlier, perhaps Tejun 
could fix while appying?

[...]
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 36ce37b..5c8bac6 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -431,6 +431,8 @@ enum {
>   	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
>   	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
>   	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
> +	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */

    BTW, why not ATA_HORKAGE_NO_TRIM like the others?

> +

    Empty line not needed here.

MBR, Sergei

