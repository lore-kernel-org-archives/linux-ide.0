From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci: misc cleanups for EM stuff
Date: Mon, 11 May 2009 14:13:13 -0400
Message-ID: <4A086AB9.3020002@garzik.org>
References: <49F642FC.1090602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35943 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbZEKSNP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 14:13:15 -0400
In-Reply-To: <49F642FC.1090602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Milburn <dmilburn@redhat.com>

Tejun Heo wrote:
> Make the following EM related cleanups.
> 
> * Use msleep(1) instead of udelay(100) and reduce retry count to 5.
> * s/MAX_SLOTS/EM_MAX_SLOTS/
> * s/MAX_RETRY/EM_MAX_RETRY/
> 
> [ Impact: cleanup, use of longer and fewer msleep() instead of udelay() ]
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/ahci.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3489085..65677b0 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -77,8 +77,8 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
>  			      size_t size);
>  static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
>  					ssize_t size);
> -#define MAX_SLOTS 8
> -#define MAX_RETRY 15
> +#define EM_MAX_SLOTS 8
> +#define EM_MAX_RETRY 5
>  
>  enum {
>  	AHCI_PCI_BAR		= 5,

If you are going to change this, please move these into 'enum' where 
they belong...

	Jeff




