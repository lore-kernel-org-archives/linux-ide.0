Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE997C7EE2E
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 09:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjEWJBf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjEWJBf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 05:01:35 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA9FF
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 02:01:31 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.19) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 23 May
 2023 12:01:23 +0300
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
CC:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7eac8158-1c8c-2457-ff91-ee05095c24c6@omp.ru>
Date:   Tue, 23 May 2023 12:01:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230523080443.398912-1-dlemoal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.81.19]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 05/23/2023 08:47:02
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177532 [May 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 513 513 41a024eb192917672f8141390381bc9a34ec945f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.19 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.81.19:7.7.3,7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.19
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/23/2023 08:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/23/2023 7:21:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/23/23 11:04 AM, Damien Le Moal wrote:

> For devices not attached to a port multiplier and managed directly by
> libata, the device number passed to ata_find_dev() must always be lower
> than the maximum number of devices returned by ata_link_max_devices().
> That is 1 for SATA devices or 2 for an IDE link with master+slave
> devices. This device number is the scsi device ID which matches these
> constraint as the ID are generated per port and so never exceed the
> link maximum.
> 
> However, for libsas managed devices, scsi device IDs are assigned per
> scsi host, leading to device IDs for SATA devices that can be well in
> excess of libata per-link maximum number of devices. This results in
> ata_find_dev() always returning NULL for libsas managed devices except
> for the first device of the host with ID (device number) 0. This issue
> is visible by executing hdparm command, which fails:
> 
> hdparm -i /dev/sdX
> /dev/sdX:
>   HDIO_GET_IDENTITY failed: No message of desired type
> 
> Fix this by rewriting ata_find_dev() to ignore the device number for
> non-pmp attached devices with a link with at most 1 device, that is SATA
> devices on SATA ports. For these, device number 0 is always used to
> return the correct ata_device struct of the port link. This change
> excludes IDE master/slave setups (maximum number of devices per link
> is 2) and port-multiplier attached devices. Also, to be consistant with
> the fact that scsi device IDs and channel numbers used as device numbers
> are both unsigned int, change the devno argument of ata_find_dev() to
> unsinged int.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> 
> Changes from v2:
>  * Change ata_find_dev() devno argument type to unsigned int
> 
> Changes from v1:
>  * Simplify code change (remove uneeded check and remove switch-case)
>  * Reword and improve comments in ata_find_dev()
>  * Reword commit message
> 
>  drivers/ata/libata-scsi.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..6878ddf49880 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2694,18 +2694,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>  	return 0;
>  }
>  
> -static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
> +static struct ata_device *ata_find_dev(struct ata_port *ap, unsigned int devno)
>  {
> -	if (!sata_pmp_attached(ap)) {
> -		if (likely(devno >= 0 &&
> -			   devno < ata_link_max_devices(&ap->link)))
> +	/*
> +	 * For the non PMP case, link_max_devices is 1 (e.g. SATA case),
> +	 * or 2 (IDE master + slave). However, the former case includes
> +	 * libsas hosted devices which are numbered per host, leading
> +	 * to devno potentially being larger than 0 but with each ata device
> +	 * having its own ata port and ata link. To accommodate these, ignore

   Hm, you use PMP, SATA, and IDE upper-cased but not ATA? :-)

> +	 * devno and always use device number 0.
> +	 */
> +	if (likely(!sata_pmp_attached(ap))) {
> +		int link_max_devices = ata_link_max_devices(&ap->link);
> +
> +		if (link_max_devices == 1)
> +			return &ap->link.device[0];
> +
> +		if (devno < link_max_devices)
>  			return &ap->link.device[devno];
> -	} else {
> -		if (likely(devno >= 0 &&
> -			   devno < ap->nr_pmp_links))
> -			return &ap->pmp_link[devno].device[0];
> +
> +		return NULL;
>  	}
>  
> +	/*
> +	 * For PMP-attached devices, the device number corresponds to C
> +	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link

   1st time you type PMP, 2nd time pmp? :-)

[...]

MBR, Sergey
