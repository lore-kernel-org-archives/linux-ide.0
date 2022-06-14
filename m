Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E7C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 08:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354086AbiFNIkK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352745AbiFNIjs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 04:39:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF544A1E
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655195910; x=1686731910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dCSS31S8S1GINFNrobul2NF/nWwqbuMchVq6qrxnFQU=;
  b=CXCsbWZ3ryWHgGo9dPWihW5YK4OXQSzXIsFXTDIKhf5/UI9OsqkQ9wIs
   hFq9AK8ah2994R8qIz6/57Ne1fXVEmvhHI5iCYMGXieGsEmIKtuehbtbg
   9Z6BwABstXVkrkzKmdmOH+U9Pe3laz/O1S66b0vLJ30KxtHxfTyQJSMPG
   2IAamtTt+3vZEwoRrsWDBDPKe+JMWJvgSVzQ2rZXYUFQgsqH9KMsJIzWo
   j3FZgLOPv513/fNFL5M3yPMKBZFh4VKqHitM3aETzg65N7PPop47xdRv3
   lL3sMmrKdaYJu+rBTf49oQE3Y1bBXgLCFHlNcOZWqfq+VAQlmeG6shwLd
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="207952911"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:38:18 +0800
IronPort-SDR: FwXGKArVGgjfuXmZ2pPmVWgJNVLm9ma8wLuiNCYzCXzZp9DSiM/BXhqAazrUMO/q781LeussKS
 63zzNgsn2PGFgo+po024nVS3BjHPocBLVToqINvewrS/jq5mV1cpsxU5cqJTT/v7dMb1cd1NEv
 NjiIp9DSqY5FBN2/FlpS2C9BFH0Hwsk7UOrrWeyMmm644H83/Cszl56BnBfRkcVOsbriXE8JdH
 G3H4ST71Bfzt0zN5eYHQKqOkx/7ALNJVbSYgKXUvsWKLXaAol/IXrWSDCca6gH+5yZxq+Tu7yE
 Z4ibQbry4PWVNSw/lKAULynY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 00:56:53 -0700
IronPort-SDR: FMETK6vh1iexJI781Cctpg7PLHXkH/UDxyN6g51YLYYGDYh7+cBmQJlK8Ukfs6caUsP3x3WslX
 UbFgvtkIBThPfed6Lim1EA6wA07kWGmZ6/K7j0TONBzqEo8v3LkBQQkKJejgTUv/8H6xORzyC9
 QhwSr0Omkak92nahE7dNqECvc1DS3ncSQu2m6CzVhgmDX81p6iHiNzWp96ZmShVaaW6G+1vtUX
 SHVrgqGEz6AthT+MX22EfzPyAVURXrZ/DdqLb6jyZMswW3ch+NgQxSWtKLzbit7lhbLXht1Uh7
 gzs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:38:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMhfL1XPWz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 01:38:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655195897; x=1657787898; bh=dCSS31S8S1GINFNrobul2NF/nWwqbuMchVq
        6qrxnFQU=; b=GAPz1aR5qGjrfkl7Ifydky76S/6wKAl4AmNi1CsP0YsJwCcm29i
        ieoROnl1EagvkhHexCHNlsPpCSkG3LNX6sUPoxWlGnqFz9TwO+P4+zkJan6oJvP5
        kCr2HAkoXK26kTVHIH1Ttm9TG3Bt+kD2TpAhpKf9A/nqWGRLqe1wfwlV/x6H31MG
        usb9jmns7zpiS3fwI7cdbgS7DYa52L+wi44uTXWfP8JarVVWBDamSO+0HXDQ/xaM
        uw8/esgEIsCTSY+0WmP4nYWDMfRESExTZFjyuaNrfax0jwamxt5n7eZGR7yynQW+
        uIe1LVSpsScWQnxmO397Gqn4qEDroyruaHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m07NyrYiSvfb for <linux-ide@vger.kernel.org>;
        Tue, 14 Jun 2022 01:38:17 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMhfH5K10z1Rvlx;
        Tue, 14 Jun 2022 01:38:15 -0700 (PDT)
Message-ID: <707c18cb-d499-a499-db9a-db5d73f0f3b4@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 17:38:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 15/23] ata: ahci: Convert __ahci_port_base to accepting
 hpriv as arguments
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-16-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220610081801.11854-16-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/10/22 17:17, Serge Semin wrote:
> It may get required to retrieve the port-base address even before the

The port base address may be required even before the...

> ata_host instance is initialized and activated, for instance in the
> ahci_save_initial_config() method which we about to update (consider this

s/we/we are

> modification as a preparation for that one). Seeing the __ahci_port_base()
> function isn't used much it's the best candidate to provide the required
> functionality. So let's convert it to accepting the ahci_host_priv
> structure pointer.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/ahci.c | 2 +-
>  drivers/ata/ahci.h | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9bc8fa77e92f..d14d74649e0e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -689,7 +689,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
>  			mv = 2;
>  		else
>  			mv = 4;
> -		port_mmio = __ahci_port_base(host, mv);
> +		port_mmio = __ahci_port_base(hpriv, mv);
>  
>  		writel(0, port_mmio + PORT_IRQ_MASK);
>  
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 0e66446a5883..8b9826533ae5 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -431,10 +431,9 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
>  void ahci_error_handler(struct ata_port *ap);
>  u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
>  
> -static inline void __iomem *__ahci_port_base(struct ata_host *host,
> +static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpriv,
>  					     unsigned int port_no)
>  {
> -	struct ahci_host_priv *hpriv = host->private_data;
>  	void __iomem *mmio = hpriv->mmio;
>  
>  	return mmio + 0x100 + (port_no * 0x80);
> @@ -442,7 +441,9 @@ static inline void __iomem *__ahci_port_base(struct ata_host *host,
>  
>  static inline void __iomem *ahci_port_base(struct ata_port *ap)
>  {
> -	return __ahci_port_base(ap->host, ap->port_no);
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +
> +	return __ahci_port_base(hpriv, ap->port_no);
>  }
>  
>  static inline int ahci_nr_ports(u32 cap)


-- 
Damien Le Moal
Western Digital Research
