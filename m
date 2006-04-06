From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] sata_sil24: fixes, errata workaround and reset updates
Date: Thu, 06 Apr 2006 17:20:37 +0900
Message-ID: <4434CF55.8020103@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.230]:4305 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932153AbWDFIUn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 04:20:43 -0400
Received: by wproxy.gmail.com with SMTP id i22so85156wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 01:20:43 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff, Carlos.
> 
> This patchset updates sata_sil24 and is composed eight patches.
> 
> #01	libata prep
> #02-03	bug fix and errata workaround
> #04	sil24 prep
> #05	enable 64bit
> #05-06	update softreset
> #07	reimplement hardreset
> 
> This patchset is against...
>   upstream [1]
>   + libata reset updates patchset [2]
> 

Further testing shows more delay's are needed during hardreset and I've 
found more bugs in sata_sil24.  Will add those and repost this whole 
set.  Please ignore this patchset.

Thanks.

-- 
tejun
