From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: replace pci_module_init() with pci_register_driver()
Date: Thu, 10 Aug 2006 20:34:08 +0900
Message-ID: <44DB19B0.8060108@gmail.com>
References: <20060810093359.GD6371@htj.dyndns.org> <44DB0CE3.8030908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:10580 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161175AbWHJLeR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 07:34:17 -0400
Received: by wr-out-0506.google.com with SMTP id 68so63019wra
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 04:34:17 -0700 (PDT)
In-Reply-To: <44DB0CE3.8030908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, proski@gnu.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> From: Pavel Roskin <proski@gnu.org>
>>
>> Replace pci_module_init() with pci_register_driver().
>>
>> Signed-off-by: Pavel Roskin <proski@gnu.org>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>> This patch is against
>>
>>  upstream (3f066887595de490c411762ce58a31412b09e939)
>>  + improve-init-and-legacy-handling patchset, take #3
>>    (http://article.gmane.org/gmane.linux.ide/12556)
>>
>> And avaliable in the following git tree.
>>
>>   
>> http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream-pci_register_driver 
>>
>>   git://htj.dyndns.org/libata-tj tj-upstream-pci_register_driver
> 
> FWIW, it is actually better to -not- stack patchsets in this way.
> 
> git merging enables parallel branches.  Since pci-register-driver 
> changes are completely unrelated to the improve-init-and-legacy-handling 
> patchset, it would make sense to have that in an independent branch.
> 
> Anyway, this is not an acceptance or rejection comment (I plan to merge 
> it).  Just a comment.  :)

Thanks, will do things that way.

-- 
tejun
