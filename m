Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8B189B8B;
	Thu, 12 Dec 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031620; cv=none; b=X0c6EJxNNlSs5uug0ywqauL2IUZT9SFf2BUujBa/e3PYgIaZel8IY6tCnyrcg5chg3oIszBxtmq8Om9jX2DK/21ERP9GOYq8Uc/e+PvSy1mikL/Sg2cnlDvZ/aFn+Jm60sVdLKAwioYJAimTwfbbuwOefz01pOFXW1q/IG09fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031620; c=relaxed/simple;
	bh=JysBSQWB0YbGoj6Z/gGHXzvKNpha0eai5sL9Pgt4GzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NYLsA1HBop2OCSaVhyZ6MqToWOuYfBWY/8QFsIOWCkrlW8AIqF1MiTcLSBCYihTkJ8+qFCi6Y97z2ZMRI9RAms7pKIOrle5b7Npz1J86L5AE/WZhkrOftQ1/63rP+6Sjv0TRieyBmJhdNMeY07KqF1gQ+j1r4kQH5FO5N+D/S5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.158.53) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 22:26:45 +0300
Message-ID: <3976ee84-5403-4ece-b341-b265e31e78d9@omp.ru>
Date: Thu, 12 Dec 2024 22:26:43 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] libata-sff: Simplify request of PCI resources
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Mikael Pettersson
	<mikpelinux@gmail.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241204171033.86804-2-pstanner@redhat.com>
 <20241204171033.86804-5-pstanner@redhat.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20241204171033.86804-5-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 12/12/2024 18:51:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 189804 [Dec 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 47 0.3.47
 57010b355d009055a5b6c34e0385c69b21a4e07f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.158.53 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.158.53 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.158.53
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/12/2024 18:53:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/12/2024 3:08:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/4/24 8:10 PM, Philipp Stanner wrote:

> pcim_iomap_regions() has been deprecated by the PCI subsystem.
> 
> Unfortunately, libata-sff uses quite complicated bit mask magic to
> obtain its PCI resources.
> 
> Restructure and simplify the PCI resource request code.
> 
> Replace pcim_iomap_regions() with pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[...]

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 67f277e1c3bf..1d2273c0f447 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2127,6 +2127,73 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
>  	return true;
>  }
>  
> +static void ata_pci_sff_set_ap_data(struct ata_port *ap, struct ata_host *host,

   Maybe ata_pci_sff_set_port_data()?

> +		struct pci_dev *pdev, unsigned short base)

   Using just 2 tabs here seems to go against the coding style used in libata-sff.c
but no biggie... :-)

> +{
> +	void __iomem *ctl_addr;
> +
> +	ctl_addr = host->iomap[base + 1];
> +	ctl_addr = (void __iomem *)((unsigned long)ctl_addr | ATA_PCI_CTL_OFS);
> +
> +	ap->ioaddr.cmd_addr = host->iomap[base];
> +	ap->ioaddr.altstatus_addr = ctl_addr;
> +	ap->ioaddr.ctl_addr = ctl_addr;
> +
> +	ata_sff_std_ports(&ap->ioaddr);
> +
> +	ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
> +		(unsigned long long)pci_resource_start(pdev, base),
> +		(unsigned long long)pci_resource_start(pdev, base + 1));
> +}
> +
> +/*

   Please use /** here -- the comment seems to otherwise match the kernel-doc
format...

> + * ata_pci_sff_obtain_bars - obtain the PCI BARs associated with an ATA port
> + * @pdev: the PCI device
> + * @host: the ATA host
> + * @ap: the ATA port
> + * @port: @ap's port index in @host
> + *
> + * Returns: Number of successfully ioremaped BARs, a negative code on failure
> + */
> +static int ata_pci_sff_obtain_bars(struct pci_dev *pdev, struct ata_host *host,
> +		struct ata_port *ap, unsigned short port)
> +{
> +	int ret = 0, bars_mapped = 0;
> +	unsigned short i, base;
> +	void __iomem *io_tmp;

   Maybe call it iomem instead?

> +	const char *name = dev_driver_string(&pdev->dev);
> +
> +	/*
> +	 * Port can be 0 or 1.
> +	 * Port 0 corresponds to PCI BARs 0 and 1, port 1 to BARs 2 and 3.
> +	 */
> +	base = port * 2;
> +
> +       /*

   Don't indent with spaces please.

> +	* Discard disabled ports. Some controllers show their unused channels
> +	* this way. Disabled ports are made dummy.
> +	*/

   These 3 lines lack a space before *.

[...]
> +	for (i = 0; i < 2; i++) {
> +		io_tmp = pcim_iomap_region(pdev, base + i, name);
> +		ret = PTR_ERR_OR_ZERO(io_tmp);
> +		if (ret != 0)

   != 0 unnecessary.

[...]
> @@ -2148,59 +2215,31 @@ static bool ata_resources_present(struct pci_dev *pdev, int port)
[...]> -	if (!mask) {
> -		dev_err(gdev, "no available native port\n");
> +	if (operational_ports == 0)

   Perhaps:

	if (!operational_ports)

[...]

MBR, Sergey

