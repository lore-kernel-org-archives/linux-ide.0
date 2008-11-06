From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH #hibern_regress] libata: add missing dummy dmi_first_match()
Date: Thu, 6 Nov 2008 17:33:50 +0100
Message-ID: <200811061733.51338.rjw@sisk.pl>
References: <4911B47A.2010409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59827 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbYKFQ33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 11:29:29 -0500
In-Reply-To: <4911B47A.2010409@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wednesday, 5 of November 2008, Tejun Heo wrote:
> Dummy dmi_first_match() definition for !CONFIG_DMI is missing.  Add it.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks!

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/dmi.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index 6e20820..dbce0ce 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -51,6 +51,8 @@ extern int dmi_walk(void (*decode)(const struct dmi_header *));
>  #else
>  
>  static inline int dmi_check_system(const struct dmi_system_id *list) { return 0; }
> +static inline const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
> +	{ return NULL; }
>  static inline const char * dmi_get_system_info(int field) { return NULL; }
>  static inline const struct dmi_device * dmi_find_device(int type, const char *name,
>  	const struct dmi_device *from) { return NULL; }
> 
> 


