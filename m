From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 16/20] libata: make ata_host_alloc() take care of hpriv
 alloc/free
Date: Tue, 19 Sep 2006 01:45:29 -0400
Message-ID: <450F83F9.3030902@pobox.com>
References: <11559779731744-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57503 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750847AbWISFpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:45:39 -0400
In-Reply-To: <11559779731744-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Transfer responsibility to allocate/init hpriv from LLD/port_info to
> host allocation.  All host allocation/prepare routines now
> take @hpriv_hz and initialize host->private_data accordingly.
> hpriv area is aligned to __alignof__(long long) and zeroed.
> 
> As hpriv handling is moved to host allocation, pinfo->private_data
> is removed.  The only user of pinfo->private_data was
> ata_pci_init_one() which is updated to take @hpriv argument directly.
> This change makes port_info carry one less host-wide info - which
> is good because mismatched scope causes confusion and bug
> (e.g. ata_piix private_data init bug).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

A nice model to follow is netdev_priv() and the alloc_netdev() 
allocation code...

