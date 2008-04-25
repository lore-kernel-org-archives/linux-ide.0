From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata: functions with definition should not be extern
Date: Fri, 25 Apr 2008 00:47:11 -0400
Message-ID: <4811624F.8040405@garzik.org>
References: <1209087454.20088.11.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46509 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYDYErN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:47:13 -0400
In-Reply-To: <1209087454.20088.11.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> Noticed by sparse
> drivers/ata/libata-core.c:3380:12: warning: function 'ata_wait_after_reset' with external linkage has definition
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b0b00af..fe5c88b 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3377,7 +3377,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
>   *	RETURNS:
>   *	0 if @linke is ready before @deadline; otherwise, -errno.
>   */
> -extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
> +int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
>  				int (*check_ready)(struct ata_link *link))
>  {

applied


