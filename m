Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDD1B3F32;
	Wed, 14 Aug 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656800; cv=none; b=namFOK5FUfCOyQRZmE6ZdLtN975glNGjTgb485SV2dwPqg4GuGHIw+VRXeAodJvZbBV9VdR1mqfUHPEbEs/XlCyCThRsGI24FGM9jQFdjLSH9EgnQudOFrQIJMtT6TsUcDXttqvw9Gn0ylP2FL6M2BfFxe/GwGeYCbnqCtZ7ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656800; c=relaxed/simple;
	bh=X8gvZGdLWcQYoLz27ibCdBwSl8yNDBRyq5CjNUpiRP4=;
	h=From:Subject:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CSFOzfFp8vz+ZWhpwjJ2LrpRqC/f8Q8/duj/hbZH6DoSQs+pG2548PEkTcLJ8M2vepUdfL1nPV+dZ1AKVkYCphxnv5hEyPt6qGFE1OVNwLtWPa23d5sVfq/Cx3GbMkmd1r9gCscLhJWHziVk5R7QZ1JtBwX7A+qyoVt5QYdPwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.237) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 14 Aug
 2024 20:32:53 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] ata: Replace deprecated PCI devres functions
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
	<mikpelinux@gmail.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240812084839.37580-2-pstanner@redhat.com>
Organization: Open Mobile Platform
Message-ID: <c2d21da0-7fe1-f995-5562-7ff04e9f1b8b@omp.ru>
Date: Wed, 14 Aug 2024 20:32:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240812084839.37580-2-pstanner@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/14/2024 17:21:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187069 [Aug 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 25 0.3.25
 b7c690e6d00d8b8ffd6ab65fbc992e4b6fdb4186
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.237
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/14/2024 17:24:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/14/2024 3:12:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/12/24 11:48 AM, Philipp Stanner wrote:

> The ata subsystem uses the PCI devres functions pcim_iomap_table() and
> pcim_request_regions(), which have been deprecated in commit e354bb84a4c1
> ("PCI: Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> These functions internally already use their successors, notably
> pcim_request_region(), so they are quite trivial to replace.
> 
> However, one thing special about ata is that it stores the iomap table
> provided by pcim_iomap_table() in struct ata_host. This can be replaced
> with a __iomem pointer table, statically allocated with size
> PCI_STD_NUM_BARS so it can house the maximum number of PCI BARs. The
> only further modification then necessary is to explicitly fill that
> table, whereas before it was filled implicitly by
> pcim_request_regions().
> 
> Modify the iomap table in struct ata_host.
> 
> Replace all calls to pcim_request_region() with ones to
> pcim_request_region().

   Huh? :-)
   Besides, I'm not seeing pcim_request_region() anywhere in this patch...

> Remove all calls to pcim_iomap_table().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[...]
>  drivers/ata/ata_piix.c      |  7 +++---
>  drivers/ata/libata-sff.c    | 50 ++++++++++++++++++++++++++++++-------
>  drivers/ata/pata_atp867x.c  | 13 ++++++----
>  drivers/ata/pata_hpt3x3.c   |  8 +++---
>  drivers/ata/pata_ninja32.c  | 10 ++++----
>  drivers/ata/pata_pdc2027x.c | 11 ++++----
>  drivers/ata/pata_sil680.c   | 11 ++++----
>  drivers/ata/pdc_adma.c      |  9 +++----
>  drivers/ata/sata_inic162x.c | 10 +++-----
>  drivers/ata/sata_mv.c       |  8 +++---
>  drivers/ata/sata_nv.c       |  8 +++---
>  drivers/ata/sata_promise.c  |  7 +++---
>  drivers/ata/sata_qstor.c    |  7 +++---
>  drivers/ata/sata_sil.c      |  7 +++---
>  drivers/ata/sata_sil24.c    | 20 ++++++++-------
>  drivers/ata/sata_sis.c      |  8 +++---
>  drivers/ata/sata_svw.c      |  9 ++++---
>  drivers/ata/sata_sx4.c      | 17 ++++++++++---
>  drivers/ata/sata_via.c      | 31 ++++++++++++++---------
>  drivers/ata/sata_vsc.c      |  7 +++---
>  include/linux/libata.h      |  7 +++++-
>  21 files changed, 163 insertions(+), 102 deletions(-)

   I did review all the changes, not just PATA drivers.

[...]
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 250f7dae05fd..d58db8226436 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
[...]
> @@ -2172,8 +2173,41 @@ int ata_pci_sff_init_host(struct ata_host *host)
>  			continue;
>  		}
>  
> -		rc = pcim_iomap_regions(pdev, 0x3 << base,
> -					dev_driver_string(gdev));
> +		/*
> +		 * In a first loop run, we want to get BARs 0 and 1.
> +		 * In a second run, we want BARs 2 and 3.
> +		 */
> +		if (i == 0) {
> +			io_tmp = pcim_iomap_region(pdev, 0, drv_name);
> +			if (IS_ERR(io_tmp)) {
> +				rc = PTR_ERR(io_tmp);
> +				goto err;
> +			}
> +			host->iomap[0] = io_tmp;
> +
> +			io_tmp = pcim_iomap_region(pdev, 1, drv_name);
> +			if (IS_ERR(io_tmp)) {
> +				rc = PTR_ERR(io_tmp);
> +				goto err;
> +			}
> +			host->iomap[1] = io_tmp;
> +		} else {
> +			io_tmp = pcim_iomap_region(pdev, 2, drv_name);
> +			if (IS_ERR(io_tmp)) {
> +				rc = PTR_ERR(io_tmp);
> +				goto err;
> +			}
> +			host->iomap[2] = io_tmp;
> +
> +			io_tmp = pcim_iomap_region(pdev, 3, drv_name);
> +			if (IS_ERR(io_tmp)) {
> +				rc = PTR_ERR(io_tmp);
> +				goto err;
> +			}
> +			host->iomap[3] = io_tmp;
> +		}
> +

   Ugh... Why you couldn't keep using base (or just i * 2) and avoid
such code duplication?

[...]
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index abe64b5f83cf..8a17df73412e 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -360,15 +360,16 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/* Try to acquire MMIO resources and fallback to PIO if
>  	 * that fails
>  	 */
> -	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
> -	if (rc)
> +	mmio_base = pcim_iomap_region(pdev, SIL680_MMIO_BAR, DRV_NAME);
> +	if (IS_ERR(mmio_base)) {
> +		rc = PTR_ERR(mmio_base);
  		goto use_ioports;

   The code under that label ignores rc, no?

[...]
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index a482741eb181..d115f6f66974 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
>  	struct ata_host *host;
>  	struct pdc_host_priv *hpriv;
>  	int i, rc;
> +	void __iomem *io_tmp;

   I'd suggest to call it base or s/th...

[...]
> diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> index 57cbf2cef618..73b78834fa3f 100644
> --- a/drivers/ata/sata_via.c
> +++ b/drivers/ata/sata_via.c
> @@ -457,6 +457,7 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
>  {
>  	const struct ata_port_info *ppi[] = { &vt6420_port_info, NULL };
>  	struct ata_host *host;
> +	void __iomem *iomem;

   Call it base, maybe?

[...]
> @@ -486,6 +488,7 @@ static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
>  	const struct ata_port_info *ppi[] =
>  		{ &vt6421_sport_info, &vt6421_sport_info, &vt6421_pport_info };
>  	struct ata_host *host;
> +	void __iomem *iomem;

   Here as well...

[...]

MBR, Sergey
