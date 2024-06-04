Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738213E8BF;
	Tue,  4 Jun 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532246; cv=none; b=FMuaU3aG4N1GL5WlTSFW000Lt4T+t6DqU5ddZFamk5YkPJbuIfQfa3S72hlHWrMzhzCkaqlxPAGPWQ9Xnx8NiMqgKYg4irbgyRsK+x78Pef8Y9LYq3DkoEwrhnUAEO33jcfLixNQ5ia2v1qyfa07IymRuYAs6ET8J1pzqaCJKlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532246; c=relaxed/simple;
	bh=Rae1lQHqGHsOD8fTcik48b495suxjyvSUpsD0bTw8RM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kBoIK3lUXMMW2GmOZFP+BaI4es+BKvS8mSKkGq75G609ML7YomhY6XAOmkNEPcajVdfjEkQUEEt0wFWDMF1+fKOBFJpBlkH7rSbE2zf89M+BDzLKeJNI6kYPfAPQy7bCpqBJTj+KQQwWeE/vG0z0DfiI6nZxt+iUeVkhNjI4Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.182) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 4 Jun
 2024 23:17:11 +0300
Subject: Re: [PATCH] ata: pata_buddha: pata_gayle: consolidate .sff_data_xfer
 around libata::ata_sff_data_xfer()
To: Paolo Pisati <p.pisati@gmail.com>, Damien Le Moal <dlemoal@kernel.org>
CC: <linux-m68k@lists.linux-m68k.org>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240604162217.484789-1-p.pisati@gmail.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <eebb2da9-1253-8404-1f79-50a95679df03@omp.ru>
Date: Tue, 4 Jun 2024 23:17:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240604162217.484789-1-p.pisati@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/04/2024 19:51:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 185716 [Jun 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.182 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.182 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;178.176.78.182:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.182
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/04/2024 19:55:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/4/2024 4:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

  Please do 2 separate patches (for each driver), or at last name the
patch s/th like "ata: pata_{buddha,gayle}: consolidate .sff_data_xfer around libata-sff.c::ata_sff_data_xfer()"...

On 6/4/24 7:22 PM, Paolo Pisati wrote:

> pata_buddha_data_xfer(), pata_gayle_data_xfer() and ata_sff_data_xfer() are the
> same function, consolidate around libata::ata_sff_data_xfer().
> 
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/ata/pata_buddha.c | 40 ++-------------------------------------
>  drivers/ata/pata_gayle.c  | 40 ++-------------------------------------
>  2 files changed, 4 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index c36ee991d5e5..234278eb26e1 100644
> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c
> @@ -60,42 +60,6 @@ static const struct scsi_host_template pata_buddha_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
>  
> -/* FIXME: is this needed? */
> -static unsigned int pata_buddha_data_xfer(struct ata_queued_cmd *qc,
> -					 unsigned char *buf,
> -					 unsigned int buflen, int rw)
> -{
> -	struct ata_device *dev = qc->dev;
> -	struct ata_port *ap = dev->link->ap;
> -	void __iomem *data_addr = ap->ioaddr.data_addr;
> -	unsigned int words = buflen >> 1;
> -
> -	/* Transfer multiple of 2 bytes */
> -	if (rw == READ)
> -		raw_insw((u16 *)data_addr, (u16 *)buf, words);
> -	else
> -		raw_outsw((u16 *)data_addr, (u16 *)buf, words);

   Hm, are you sure these calls are equivalent to io{read,write}16_rep()?

> -
> -	/* Transfer trailing byte, if any. */
> -	if (unlikely(buflen & 0x01)) {
> -		unsigned char pad[2] = { };
> -
> -		/* Point buf to the tail of buffer */
> -		buf += buflen - 1;
> -
> -		if (rw == READ) {
> -			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> -			*buf = pad[0];
> -		} else {
> -			pad[0] = *buf;
> -			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> -		}
> -		words++;
> -	}
> -
> -	return words << 1;
> -}
> -
>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
>   * already been configured..
> @@ -131,7 +95,7 @@ static void pata_xsurf_irq_clear(struct ata_port *ap)
>  
>  static struct ata_port_operations pata_buddha_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_buddha_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,

   There should be no need -- this method is preperly init'ed in ata_sff_port_ops...

>  	.sff_irq_check	= pata_buddha_irq_check,
>  	.cable_detect	= ata_cable_unknown,
>  	.set_mode	= pata_buddha_set_mode,
> @@ -139,7 +103,7 @@ static struct ata_port_operations pata_buddha_ops = {
>  
>  static struct ata_port_operations pata_xsurf_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_buddha_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,

   Here as well...

>  	.sff_irq_check	= pata_buddha_irq_check,
>  	.sff_irq_clear	= pata_xsurf_irq_clear,
>  	.cable_detect	= ata_cable_unknown,
> diff --git a/drivers/ata/pata_gayle.c b/drivers/ata/pata_gayle.c
> index 3bdbe2b65a2b..febffc36a18f 100644
> --- a/drivers/ata/pata_gayle.c
> +++ b/drivers/ata/pata_gayle.c
> @@ -38,42 +38,6 @@ static const struct scsi_host_template pata_gayle_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
>  
> -/* FIXME: is this needed? */
> -static unsigned int pata_gayle_data_xfer(struct ata_queued_cmd *qc,
> -					 unsigned char *buf,
> -					 unsigned int buflen, int rw)
> -{
> -	struct ata_device *dev = qc->dev;
> -	struct ata_port *ap = dev->link->ap;
> -	void __iomem *data_addr = ap->ioaddr.data_addr;
> -	unsigned int words = buflen >> 1;
> -
> -	/* Transfer multiple of 2 bytes */
> -	if (rw == READ)
> -		raw_insw((u16 *)data_addr, (u16 *)buf, words);
> -	else
> -		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
> -
> -	/* Transfer trailing byte, if any. */
> -	if (unlikely(buflen & 0x01)) {
> -		unsigned char pad[2] = { };
> -
> -		/* Point buf to the tail of buffer */
> -		buf += buflen - 1;
> -
> -		if (rw == READ) {
> -			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
> -			*buf = pad[0];
> -		} else {
> -			pad[0] = *buf;
> -			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
> -		}
> -		words++;
> -	}
> -
> -	return words << 1;
> -}
> -

   Same question as above here...

>  /*
>   * Provide our own set_mode() as we don't want to change anything that has
>   * already been configured..
> @@ -110,7 +74,7 @@ static void pata_gayle_irq_clear(struct ata_port *ap)
>  
>  static struct ata_port_operations pata_gayle_a1200_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_gayle_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,
>  	.sff_irq_check	= pata_gayle_irq_check,
>  	.sff_irq_clear	= pata_gayle_irq_clear,
>  	.cable_detect	= ata_cable_unknown,
> @@ -119,7 +83,7 @@ static struct ata_port_operations pata_gayle_a1200_ops = {
>  
>  static struct ata_port_operations pata_gayle_a4000_ops = {
>  	.inherits	= &ata_sff_port_ops,
> -	.sff_data_xfer	= pata_gayle_data_xfer,
> +	.sff_data_xfer	= ata_sff_data_xfer,
>  	.cable_detect	= ata_cable_unknown,
>  	.set_mode	= pata_gayle_set_mode,
>  };
> 

    Same comments as to pata_buddha.c here...

MBR, Sergey
