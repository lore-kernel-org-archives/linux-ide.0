Return-Path: <SRS0=iM+a=WI=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E47C433FF
	for <linux-ide@archiver.kernel.org>; Mon, 12 Aug 2019 14:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FFA206A2
	for <linux-ide@archiver.kernel.org>; Mon, 12 Aug 2019 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZoO19Qxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfHLOLZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:11:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46438 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfHLOLZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Aug 2019 10:11:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so1466264pfc.13
        for <linux-ide@vger.kernel.org>; Mon, 12 Aug 2019 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ImAPf5qAoKDn0lII01+6uoZ3xRG/c5SpeNPUt2AARos=;
        b=ZoO19QxbIJseWz0TVsYkFhTzyEIuRAAI5FFh4s6LOZdchsiJXCQjXwEWJkXC4izGpG
         l2WwfxYhsB1j51Ke52mdJSy+0LuSN2KBNeqGs+QtewhLmXlspMQm5wNPirkFRC5DZ/qQ
         /FdMY5S+ejnsh1H3XeLK110auQ6vACdXSoRdvZynYradCKGcqnDsvoSQ6hJdZxxBd8Jo
         VhRWas+5VMyPkxhUsdKcOjMo88wTdDXfdMMIkRomnrqVkLS8mCtdN4+nEXOt9greQtA4
         noSVdOzU2tXSoz3unzRoLcjABZsiCYw5uLfhl50E7i1s1xvUU6eVAPnkvB9hBLIH988E
         d57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImAPf5qAoKDn0lII01+6uoZ3xRG/c5SpeNPUt2AARos=;
        b=mGQ6FK8Myzn//rfrNVybw13h3Nzl+JTePrDl4pdg8ZQdro01qqCik38CRTJ4rO2mUH
         9EBcRRnfEoHrHHBJQyaKw+D6u7CvB8iHFVJnMhhcFPZ5zPqHf3lFq4Q/3e+WF6QDUG29
         pxrwOhBPCiJ2VbiT4TE48oM7rUN8e6ogdvX48tZFHp2CuJZ1U6COsc1t6P8FvWb5xgVj
         oMUrIL01dCBigBooQ+gDos9tAuVY9bp6zmk/5oPWTvvXiM062jfi7hfokeU/gCybPEU+
         zJBW06YMKQnDEyX34nXneo/xizPGnONd6avN1W2oexDkk401Rk7ppDWq5pAnA23/R/ls
         xxFQ==
X-Gm-Message-State: APjAAAXK0h+wGk+C1PSrEiRHMCZHYJuj3Uyl52RERWqDdTTxieR1yDiZ
        C1Xo3as6fpK2gHogDaAR+tXFBQ==
X-Google-Smtp-Source: APXvYqzrcGcueN/pZSePR9eTjLevBjvcXVR5oTmU7sd98e+a8Yu3MVSk2M4unjv/DE2mQhUq3e7xhA==
X-Received: by 2002:a17:90a:ab0d:: with SMTP id m13mr22580054pjq.84.1565619084986;
        Mon, 12 Aug 2019 07:11:24 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id ce20sm2293923pjb.16.2019.08.12.07.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:11:24 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
To:     Stephen Douthit <stephend@silicom-usa.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <679188f7-bb14-1de6-b533-687809fa7bc8@kernel.dk>
Date:   Mon, 12 Aug 2019 08:11:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/12/19 6:02 AM, Stephen Douthit wrote:
> On 8/10/19 3:43 AM, Christoph Hellwig wrote:
>> On Thu, Aug 08, 2019 at 08:24:31PM +0000, Stephen Douthit wrote:
>>> Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
>>> reason, so now we get to check the device ID before poking it on reset.
>>
>> And now you just match on the new IDs, which means we'll perpetually
>> catch up on any new device.  Dan, can you reach out inside Intel to
>> figure out if there is a way to find out the PCS register location
>> without the PCI ID check?
>>
>>
>>>    static int ahci_pci_reset_controller(struct ata_host *host)
>>>    {
>>>    	struct pci_dev *pdev = to_pci_dev(host->dev);
>>> @@ -634,13 +669,14 @@ static int ahci_pci_reset_controller(struct ata_host *host)
>>>    
>>>    	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
>>>    		struct ahci_host_priv *hpriv = host->private_data;
>>> +		int pcs = ahci_pcs_offset(host);
>>>    		u16 tmp16;
>>>    
>>>    		/* configure PCS */
>>> -		pci_read_config_word(pdev, 0x92, &tmp16);
>>> +		pci_read_config_word(pdev, pcs, &tmp16);
>>>    		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
>>> -			tmp16 |= hpriv->port_map;
>>> -			pci_write_config_word(pdev, 0x92, tmp16);
>>> +			tmp16 |= hpriv->port_map & 0xff;
>>> +			pci_write_config_word(pdev, pcs, tmp16);
>>>    		}
>>>    	}
>>
>> And Stephen, while you are at it, can you split this Intel-specific
>> quirk into a separate helper?
> 
> I can do that.  I'll wait until we hear back from Dan if there's a
> better scheme than a device ID lookup.

I'll drop the previous series for now.

-- 
Jens Axboe

