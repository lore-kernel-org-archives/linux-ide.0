Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA66EC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiDKM1Z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiDKM1Y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 08:27:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F813CCD
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649679910; x=1681215910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PrDQ1E16Pyv12c8+jc/Pe47PY10PhBUx1qaK2gNFohg=;
  b=jVNW1GimZLa6cll6/F8C7FI9QqKvQpe4EBMJVT55PdasO4nCkWzuZz6L
   S2SK4vDxEC1VHHJefh2ST2bTtqWOWy/RBOS/cY7NiLG4+S73BIDAEoujp
   6PY+s84c3yJoWe9w4sY0iXguJYzM+sVWVJxdBy/gLjy7ZJaXQuvzVMwjL
   Vloiumy32vbheuBPKI2ieQa4wcxgERNgv69CJ7Yu/WnzlyfkLsFSyBluP
   qgsH2n9LJowOI6A5bhW1xGduBUdiDcWxaoVj1CwFmP0owW4ZppXQX//2O
   W2+LMREUTITu9SpktchLZAwZC8or4YQtBkt1wKG1jVLaZYdiRbxNObwRz
   g==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="301806127"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 20:25:09 +0800
IronPort-SDR: qj4fFNqyQcGcvX5bTrvlqcEc0kIakMrwnJycgTo41kHCl6HnpsCjQ3ZppWvdQfOw8ymso+Oo/m
 8IbMlHEvaqm+TqgZnYDEgZC0Ufu2hCgtzhIF8l35C31WbxuLqcM0C4ctR/zRQ+N29m3weUU/eJ
 5W5ik1C4yhcHCLUx5p8D4x3hRS0hCxLyC12xVZvxQDlnn+L36Wj7kGD6q5FJ1PdiSeDyMsOdED
 oWi62MtXSrDQy1hxqI/mu6CBLlccVkAuG4JT94ohpx06+BQhKLj9LTZKojaE0vgdtvBfo0E7ot
 iKthKy90ZD02t1UWZGuFamUT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 04:56:26 -0700
IronPort-SDR: 4lv7dqvpswTYmiau7fQYIoL3o/O80jsEpJhQ9rV21tUZajk2HiAG4UpY90OJ+Rwq+uOXh7O2lb
 sLFcrcVlIszIdHfs5erJvwT5hJuXk8CDecfnFfzb/NRXVmen2MYJbJFqK/BugKbQfWeS0RG7XU
 k6T0P21FY/L0U7bnzCoHAd3ZRVOH/OleWIUHX2QUHSxJzreQXzJrceigEU7xVk0IYca/Fbp26l
 EiNWcQEsq4ytbE2Z+WezmalhOTlAqDXqQVq793Fv+OVthe6esv2KrsULUV0dFzDeYG3t4gogC4
 d1k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 05:25:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KcSjc2dldz1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 05:25:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649679907; x=1652271908; bh=PrDQ1E16Pyv12c8+jc/Pe47PY10PhBUx1qa
        K2gNFohg=; b=AsOILDiePXK8tNjJN/VxCcqRIcSCnsCBY/W+Foflr5sAVoZCayD
        C5fUF64ivVxC6P/nGWPYkvINiVsj4cXxoLRGh0mlij7WVErVJKBsUu3uJllhFtwX
        DVA1QCNuESLKLWq16xfgyEJXGePZKRyun8lbiVgSP7+f210XP/R76m+L9GosP8lo
        +b9weqvbW8qrjpcGx7y56S9JoLz17yfRe9lkXhG53J0TLVk+J4LYfgozj2Y3Xo0L
        h9wwG3+FQVawyqn8OGNr07tPVfeVac/TOuNNB5W9BUCPo4+CIjfgook6xCebFVPc
        NDCSLWlxcEyU1OCwz6MXJYeF7juwR2BeUBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zh47RiDvZODp for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 05:25:07 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KcSjY19FGz1Rvlx;
        Mon, 11 Apr 2022 05:25:04 -0700 (PDT)
Message-ID: <bde34952-e244-a1c3-fc33-251d618d2bb4@opensource.wdc.com>
Date:   Mon, 11 Apr 2022 21:25:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 12/21] ata: libahci: Discard redundant force_port_map
 parameter
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-13-Sergey.Semin@baikalelectronics.ru>
 <b06a8382-d5c1-e3a5-8577-692fa82cb3c1@opensource.wdc.com>
 <20220411121151.vm6wmtalbl2lgtgo@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220411121151.vm6wmtalbl2lgtgo@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/11/22 21:11, Serge Semin wrote:
> On Thu, Mar 24, 2022 at 11:05:58AM +0900, Damien Le Moal wrote:
>> On 3/24/22 09:16, Serge Semin wrote:
>>> Currently there are four port-map-related fields declared in the
>>> ahci_host_priv structure and used to setup the HBA ports mapping. First
>>> the ports-mapping is read from the PI register and immediately stored in
>>> the saved_port_map field. If forced_port_map is initialized with non-zero
>>> value then its value will have greater priority over the value read from
>>> PI, thus it will override the saved_port_map field. That value will be then
>>> masked by a non-zero mask_port_map field and after some sanity checks it
>>> will be stored in the ahci_host_priv.port_map field as a final port
>>> mapping.
>>>
>>> As you can see the logic is a bit too complicated for such a simple task.
>>> We can freely get rid from at least one of the fields with no change to
>>> the implemented semantic. The force_port_map field can be replaced with
>>> taking non-zero saved_port_map value into account. So if saved_port_map is
>>> pre-initialized by the glue-driver/platform-specific code then it will
>>
> 
>> glue-driver == LLDD (low level device driver), for the entire series please.
> 
> Why? It's a normal term and well known amongst developers. I've used it
> in a plenty of my patches before and none of them has been questioned in that
> part so far.

This term is not used in libata, nor do I remember seeing it used in SCSI
or block subsystem either. We always talk about mid-layer (ahci platform)
and LLDD (adapter driver).

> 
> -Sergey
> 
>>
>>> have greater priority over the value read from PI register and will be
>>> used as actual HBA ports mapping later on. Thus the ports map forcing task
>>> will be just transferred from the force_port_map to saved_port_map field.
>>>
>>> This modification will perfectly fit into the feature of having OF-based
>>> initialization of the HW-init HBA CSR fields we are about to introduce in
>>> the next commit.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> ---
>>>  drivers/ata/ahci.c             |  2 +-
>>>  drivers/ata/ahci.h             |  1 -
>>>  drivers/ata/libahci.c          | 10 ++++++----
>>>  drivers/ata/libahci_platform.c |  2 +-
>>>  4 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index ab5811ef5a53..8ce0d166cc8d 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -654,7 +654,7 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>>>  {
>>>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>>>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>>> -		hpriv->force_port_map = 1;
>>> +		hpriv->saved_port_map = 1;
>>>  	}
>>>  
>>>  	/*
>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>>> index 04690b4168a3..519d148ecaea 100644
>>> --- a/drivers/ata/ahci.h
>>> +++ b/drivers/ata/ahci.h
>>> @@ -329,7 +329,6 @@ struct ahci_port_priv {
>>>  struct ahci_host_priv {
>>>  	/* Input fields */
>>>  	unsigned int		flags;		/* AHCI_HFLAG_* */
>>> -	u32			force_port_map;	/* force port map */
>>>  	u32			mask_port_map;	/* mask out particular bits */
>>>  
>>>  	void __iomem *		mmio;		/* bus-independent mem map */
>>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>>> index 0ed484e04fd6..011175e82174 100644
>>> --- a/drivers/ata/libahci.c
>>> +++ b/drivers/ata/libahci.c
>>> @@ -453,7 +453,6 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  	 * reset.  Values without are used for driver operation.
>>>  	 */
>>>  	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
>>> -	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
>>>  
>>>  	/* CAP2 register is only defined for AHCI 1.2 and later */
>>>  	vers = readl(mmio + HOST_VERSION);
>>> @@ -517,10 +516,13 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>>>  		cap &= ~HOST_CAP_SXS;
>>>  	}
>>>  
>>> -	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
>>> +	/* Override the HBA ports mapping if the platform needs it */
>>> +	port_map = readl(mmio + HOST_PORTS_IMPL);
>>> +	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
>>>  		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>>> -			 port_map, hpriv->force_port_map);
>>> -		port_map = hpriv->force_port_map;
>>> +			 port_map, hpriv->saved_port_map);
>>> +		port_map = hpriv->saved_port_map;
>>> +	} else {
>>>  		hpriv->saved_port_map = port_map;
>>>  	}
>>>  
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index febad33aa43c..5cbc2c42164d 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -539,7 +539,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  	}
>>>  
>>>  	of_property_read_u32(dev->of_node,
>>> -			     "ports-implemented", &hpriv->force_port_map);
>>> +			     "ports-implemented", &hpriv->saved_port_map);
>>>  
>>>  	if (child_nodes) {
>>>  		for_each_child_of_node(dev->of_node, child) {
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
