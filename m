From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 2/5] libata-dev: Minor fix for ata_hsm_move() to work with ata_host_intr()
Date: Fri, 10 Mar 2006 18:22:04 +0900
Message-ID: <20060310092204.GB20207@htj.dyndns.org>
References: <440FEA4B.10500@tw.ibm.com> <440FEC1C.30601@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:29712 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751960AbWCJJWM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 04:22:12 -0500
Received: by pproxy.gmail.com with SMTP id d42so350838pyd
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:22:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440FEC1C.30601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Please kill trailing whitespace.

On Thu, Mar 09, 2006 at 04:49:32PM +0800, Albert Lee wrote:
[--- snip ---]
> @@ -4427,6 +4426,10 @@ inline unsigned int ata_host_intr (struc
>  	/* Check whether we are expecting interrupt in this state */
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> +		/* Some pre-ATAPI-4 devices assert INTRQ 

HERE!!!

> +		 * at this state when ready to receive CDB.
> +		 */
> +
>  		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
>  		 * The flag was turned on only for atapi devices.
>  		 * No need to check is_atapi_taskfile(&qc->tf) again.
> 
> 
