From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 17:56:30 +0900
Message-ID: <448E7DBE.7010000@gmail.com>
References: <11501274293403-git-send-email-htejun@gmail.com> <1150179928.7132.19.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:53997 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750776AbWFMI4h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 04:56:37 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1844610nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 01:56:36 -0700 (PDT)
In-Reply-To: <1150179928.7132.19.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:
>> @@ -5584,22 +5683,51 @@ int pci_test_config_bits(struct pci_dev 
>>  
>>  int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
>>  {
>> -	pci_save_state(pdev);
>> -	pci_disable_device(pdev);
>> +	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
>> +	struct ata_host_set *host_set;
>> +	int rc = 0;
>> +
>> +	for (host_set = first_hset; host_set; host_set = host_set->next) {
>> +		rc = ata_host_set_suspend(host_set, state);
>> +		if (rc)
>> +			break;
>> +	}
> 
> My original understanding is that a host_set represents a physical SATA
> controller in a PCI slot. In which case will a SATA controller include
> multiple host_set?

Please read ata_pci_init_one() and ata_pci_init_legacy_port() in 
libata-bmdma.c.  It's for IDE controllers in legacy mode (not native 
PCI) mode.

-- 
tejun
