From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/3] ata: Fixes related to edge trigger latch for the
 ahci_xgene_driver.
Date: Wed, 10 Feb 2016 11:25:47 -0500
Message-ID: <20160210162547.GJ3741@mtj.duckdns.org>
References: <1454738124-9351-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454738124-9351-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Sat, Feb 06, 2016 at 11:25:21AM +0530, suman Tripathi wrote:
> From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
> 
> This patch set implements a workaround for an errate in the APM
> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
> cycle. It also implements the capability to override generic interrupt
> handler.

Applied 1-3 to libata/for-4.6 with minor updates.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
