Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D61223338;
	Thu, 12 Dec 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028546; cv=none; b=QnSEx6kWD5ihHwIdZ5BEh5YnOqwAXk0hUKs68fVNTBvrie60Y21oLt4kyv/33VL8e2Z9RSL2C6RktqZEqJ8SYyvjWbZsbrcAkw1kQl4tKQNX6ksaEKesB9uANIEPjw14uP0ZHqD2JfNP/UvsKZ25F6oS697JAPklax39jMn68cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028546; c=relaxed/simple;
	bh=D1rEZ/UXPFQswkREdMZvu289mgrFj152BUDKLiScvJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YspqC2/Gl7mePYOexlR75PUcnaOLreIXFqAlEtachPp/wwjh4cDsF/A7rRpSl3PW3UUpjWADPgNtBXeZYwsD7xQ6CBtRC7uENyWPiyYQd1ZRU0xiVUtU9+eqZ55sJvr7EfNL9TtHbnWOUCa2jVAz1osThukIB6+XsBet5JBQQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.158.53) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 21:20:23 +0300
Message-ID: <edf7216a-15f8-474b-95ec-84451192cd28@omp.ru>
Date: Thu, 12 Dec 2024 21:20:19 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] ata: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
	<mikpelinux@gmail.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241204171033.86804-2-pstanner@redhat.com>
 <20241204171033.86804-4-pstanner@redhat.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20241204171033.86804-4-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 12/12/2024 18:03:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 189803 [Dec 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 47 0.3.47
 57010b355d009055a5b6c34e0385c69b21a4e07f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.158.53
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/12/2024 18:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/12/2024 3:08:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/4/24 8:10 PM, Philipp Stanner wrote:

> The ata subsystem uses the deprecated PCI devres functions
> pcim_iomap_table() and pcim_request_regions().
> 
> These functions internally already use their successors, notably
> pcim_request_region(), so they are quite trivial to replace.
> 
> Replace all calls to pcim_request_regions() with ones to
> pcim_request_region().
> 
> Remove all calls to pcim_iomap_table().
> 
> The last remaining user, libata-sff.c, is very complicated to port and
> left for future work.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[...]

> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index abe64b5f83cf..1f74666a0f37 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -360,15 +360,17 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/* Try to acquire MMIO resources and fallback to PIO if
>  	 * that fails
>  	 */
> -	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
> -	if (rc)
> +	rc = 0;

   Doesn't seem necessary...

> +	mmio_base = pcim_iomap_region(pdev, SIL680_MMIO_BAR, DRV_NAME);
> +	if (IS_ERR(mmio_base)) {
> +		rc = PTR_ERR(mmio_base);
>  		goto use_ioports;
> +	}
>  
>  	/* Allocate host and set it up */
>  	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 2);
>  	if (!host)
>  		return -ENOMEM;
> -	host->iomap = pcim_iomap_table(pdev);
>  
>  	/* Setup DMA masks */
>  	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
[...]
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index a482741eb181..f4644ba5f095 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1390,6 +1390,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
>  	struct ata_host *host;
>  	struct pdc_host_priv *hpriv;
>  	int i, rc;
> +	void __iomem *io_tmp;

   I'd suggest a better name, like iomem here...

[...]
> diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> index 57cbf2cef618..73b78834fa3f 100644
> --- a/drivers/ata/sata_via.c
> +++ b/drivers/ata/sata_via.c
[...]
> @@ -494,13 +497,17 @@ static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
>  		return -ENOMEM;
>  	}
>  
> -	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
> -	if (rc) {
> -		dev_err(&pdev->dev, "failed to request/iomap PCI BARs (errno=%d)\n",
> -			rc);
> -		return rc;
> +	/* Request and ioremap _all_ PCI BARs. */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		iomem = pcim_iomap_region(pdev, i, DRV_NAME);
> +		if (IS_ERR(iomem)) {
> +			rc = PTR_ERR(iomem);
> +			dev_err(&pdev->dev, "failed to request/iomap PCI BARs (errno=%d)\n",
> +				rc);

   You have a limit of 100 columns now. :-)

[...]

MBR, Sergey

