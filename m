From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 8/20] libata: reimplement ata_pci_init_one() using new
 init helpers
Date: Tue, 19 Sep 2006 15:04:21 +0900
Message-ID: <450F8865.70804@gmail.com>
References: <11559779723326-git-send-email-htejun@gmail.com> <450F80E5.7080009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:61377 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964904AbWISGE1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 02:04:27 -0400
Received: by py-out-1112.google.com with SMTP id n25so5664043pyg
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 23:04:27 -0700 (PDT)
In-Reply-To: <450F80E5.7080009@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Agreed on all your comments for 6 & 7.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
> Nevermind previous question about legacy resources.
> 
> It does seem like the change is split across these two patches though... 
>  so the previous patch is incorrect without this one.

Yeap, that was more of logical devision and the code isn't yet activated.

>> +int ata_pci_init_one(struct pci_dev *pdev, struct ata_port_info 
>> **pinfo_ar,
>> +             unsigned int n_ports)
>> +
>> +{
>> +    unsigned int mask = ATA_PORT_PRIMARY | ATA_PORT_SECONDARY;
>> +    unsigned int legacy_mask = 0;
>> +    struct ata_host *host;
>> +    int rc;
>> +
>> +    DPRINTK("ENTER\n");
>> +
>> +    /* legacy mode? */
>> +    if (!(pinfo_ar[0]->flags & ATA_FLAG_NO_LEGACY))
>> +        legacy_mask = ata_pci_legacy_mask(pdev);
>> +
> 
> NAK -- you can't do anything with the PCI device before calling 
> pci_enable_device()

This is what we're currently doing in ata_pci_init_one().  I thought the 
assumption wass that any device which can act as a legacy device must 
have been initialized by BIOS and thus is safe to access.  If not, 
moving this backward isn't difficult.  FWIW, ata_pci_legacy_mask() only 
performs PCI-configuration access.

Thanks.

-- 
tejun
