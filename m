From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #hibern_regress] libata: add missing dummy dmi_first_match()
Date: Tue, 11 Nov 2008 03:07:14 -0500
Message-ID: <49193D32.8010600@garzik.org>
References: <4911B47A.2010409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56138 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbYKKIHS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:07:18 -0500
In-Reply-To: <4911B47A.2010409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Tejun Heo wrote:
> Dummy dmi_first_match() definition for !CONFIG_DMI is missing.  Add it.
> 
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

applied


