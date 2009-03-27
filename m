From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Removing PCI dependency of ahci and making it amba bus
 	compatible
Date: Fri, 27 Mar 2009 10:10:10 +0900
Message-ID: <49CC2772.7080205@gmail.com>
References: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com> <49CC2704.7050102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:23922 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933733AbZC0BKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 21:10:18 -0400
Received: by ti-out-0910.google.com with SMTP id i7so537689tid.23
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 18:10:15 -0700 (PDT)
In-Reply-To: <49CC2704.7050102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Tejun Heo wrote:
> Sagar Borikar wrote:
>> Currently  ahci driver assumes that the SATA controller is hooked up
>> to the PCI. There are couple of devices like Synopsis Designware SATA
>> controller with ahci sits on AHB interface and not on PCI. This patch
>> is currently tied up to our platform and I have removed PCI dependent
>> calls from the the driver. I still have to make it bus independent.
>> Please review the patch and let me know if its fine.
>>
>> All comments are welcome. Also please note that this is not
>> replacement of the existing ahci.c file I am going to create a new
>> file for ahci_ahb.c But for review, I have compared against ahci.c
>> Thanks
> 
> Sagar, the amba changes look fine although I have no way of verifying
> whether it works or not, but you just converted ahci from pci
> dependent to amba dependent.  The patch can't really be merged unless
> we're willing to break all PCI ahci systems in favor of the amba one.
> :-)

Oops, you already mentioned this.  Sorry about not reading before
replying.

-- 
tejun
