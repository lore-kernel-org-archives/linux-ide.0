From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Don't require newlines for link_power_management_policy
Date: Thu, 19 Nov 2009 16:30:50 -0500
Message-ID: <4B05B90A.7090809@pobox.com>
References: <1258474143-3020-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36037 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756588AbZKSVap (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 16:30:45 -0500
In-Reply-To: <1258474143-3020-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-ide@vger.kernel.org

On 11/17/2009 11:09 AM, Matthew Garrett wrote:
> sysfs attributes shouldn't require newlines. Make it possible to set the
> link power management policy without a trailing newline.
>
> Signed-off-by: Matthew Garrett<mjg@redhat.com>
> ---
>   drivers/ata/libata-scsi.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b4ee28d..512a3ee 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -154,8 +154,7 @@ static ssize_t ata_scsi_lpm_put(struct device *dev,
>   	 */
>   	for (i = 1; i<  ARRAY_SIZE(link_pm_policy); i++) {
>   		const int len = strlen(link_pm_policy[i].name);
> -		if (strncmp(link_pm_policy[i].name, buf, len) == 0&&
> -		   buf[len] == '\n') {
> +		if (strncmp(link_pm_policy[i].name, buf, len) == 0) {
>   			policy = link_pm_policy[i].value;

applied


