From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [libsas PATCH v13] scsi, sd: limit the scope of the async probe
 domain
Date: Thu, 17 May 2012 09:13:16 +0100
Message-ID: <1337242396.2926.16.camel@dabdike.int.hansenpartnership.com>
References: <20120323000201.17750.18754.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59707 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590Ab2EQINW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2012 04:13:22 -0400
In-Reply-To: <20120323000201.17750.18754.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Thu, 2012-03-22 at 17:05 -0700, Dan Williams wrote:
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -163,6 +163,10 @@ static inline int scsi_autopm_get_host(struct Scsi_Host *h) { return 0; }
>  static inline void scsi_autopm_put_host(struct Scsi_Host *h) {}
>  #endif /* CONFIG_PM_RUNTIME */
>  
> +#if IS_ENABLED(CONFIG_PM) || IS_ENABLED(CONFIG_BLK_DEV_SD)
> +extern struct list_head scsi_sd_probe_domain;
> +#endif

This #if is unnecessary.  There's no need to conditionally compile
external variable or function declarations.  The only reason we do it
for functions is if we need an else branch with an empty body.

James


