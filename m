From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_via: restore vt*_prepare_host error handling
Date: Tue, 04 Nov 2008 01:10:32 -0500
Message-ID: <490FE758.9060102@garzik.org>
References: <20081102211848.GA20785@joi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45519 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbYKDGKi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:10:38 -0500
In-Reply-To: <20081102211848.GA20785@joi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Joseph Chan <JosephChan@via.com.tw>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

Marcin Slusarz wrote:
> commit b9d5b89b487517cbd4cb4702da829e07ef9e4432 (sata_via: fix support
> for 5287) accidently (?) removed vt*_prepare_host error handling - restore it
> 
> catched by gcc:
> drivers/ata/sata_via.c: In function 'svia_init_one':
> drivers/ata/sata_via.c:567: warning: 'host' may be used uninitialized in this function
> 
> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> ---
>  drivers/ata/sata_via.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> index 62367fe..c18935f 100644
> --- a/drivers/ata/sata_via.c
> +++ b/drivers/ata/sata_via.c
> @@ -602,8 +602,10 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		rc = vt8251_prepare_host(pdev, &host);
>  		break;
>  	default:
> -		return -EINVAL;
> +		rc = -EINVAL;
>  	}
> +	if (rc)
> +		return rc;

applied


