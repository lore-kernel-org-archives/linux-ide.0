From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/6] sd: don't bother spinning up disks on resume
Date: Mon, 11 Nov 2013 17:08:52 +0400
Message-ID: <5280D6E4.6010804@cogentembedded.com>
References: <cover.1384030893.git.psusi@ubuntu.com> <ece4db4b486db3594ad3b97aa00f7eb5fef93c4b.1384030893.git.psusi@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:47694 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab3KKNIs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Nov 2013 08:08:48 -0500
Received: by mail-lb0-f181.google.com with SMTP id x18so3438841lbi.12
        for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2013 05:08:47 -0800 (PST)
In-Reply-To: <ece4db4b486db3594ad3b97aa00f7eb5fef93c4b.1384030893.git.psusi@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>, todd.e.brandt@linux.intel.com
Cc: tj@kernel.org, JBottomley@parallels.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

Hello.

On 10-11-2013 1:03, Phillip Susi wrote:

> Don't bother forcing disks to spin up on resume, as they
> will do so automatically when accessed, and forcing them
> to spin up slows down the resume.  Add a second bit to the
> manage_start_stop flag to restore the previous behavior.
> ---
>   drivers/scsi/sd.c          | 6 +++---
>   include/scsi/scsi_device.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index e62d17d..3143311 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
[...]
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index d65fbec..1c46d2d 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -152,7 +152,7 @@ struct scsi_device {
>   	unsigned use_192_bytes_for_3f:1; /* ask for 192 bytes from page 0x3f */
>   	unsigned no_start_on_add:1;	/* do not issue start on add */
>   	unsigned allow_restart:1; /* issue START_UNIT in error handler */
> -	unsigned manage_start_stop:1;	/* Let HLD (sd) manage start/stop */
> +	unsigned manage_start_stop:2;	/* Let HLD (sd) manage start/stop */

    I think you should better document this 2-bit field, or better still, make 
it 2 1-bit fields.

WBR, Sergei

