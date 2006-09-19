From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/20] libata: kill ata_host_stop()
Date: Tue, 19 Sep 2006 13:50:54 +0900
Message-ID: <450F772E.9030309@gmail.com>
References: <11559779703875-git-send-email-htejun@gmail.com> <450F761C.5070309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:8809 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752055AbWISEvB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 00:51:01 -0400
Received: by wx-out-0506.google.com with SMTP id s14so4302620wxc
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 21:51:00 -0700 (PDT)
In-Reply-To: <450F761C.5070309@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> As all the current LLDs are PCI, ata_pci_host_stop() should be used,
>> which BTW is effectively identical to ata_host_stop().  Convert all
>> LLDs to use ata_pci_host_stop() and kill ata_host_stop().
> 
> NAK, they are not equivalent replacements:
> 
> * ata_host_stop checks mmio_base before calling iounmap.  Most of the 
> drivers you change do not use ioremap (thus it's really a no-op call for 
> them)
> 
> * ata_pci_host_stop not only unmaps unconditionally, it calls 
> pci_iounmap().  Only drivers which have previously used pci_iomap() 
> should use this helper.
> 
> This patch may make sense later in the patch series, when 
> ata_pci_host_stop presumably works for all iomap-converted drivers, but 
> not really as the first patch?

It's the first patch because I wanted to free the function name 
ata_host_stop(), which will be used for another purpose in new init 
model.  As the new use isn't a port op, there shouldn't be too much 
confusion.

Hmmm.. I'll push this backward and use different name for it.

Thanks.

-- 
tejun
