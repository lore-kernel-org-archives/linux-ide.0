From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Thu, 10 Aug 2006 21:22:04 +0900
Message-ID: <44DB24EC.3040302@gmail.com>
References: <1154919840689-git-send-email-htejun@gmail.com>	 <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>	 <44D98388.8030005@pobox.com>	 <1155121214.5729.153.camel@localhost.localdomain>	 <44DADC67.5060707@tw.ibm.com>  <44DADFC9.7010700@pobox.com> <1155213365.22922.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:101 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030291AbWHJMWL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 08:22:11 -0400
Received: by nz-out-0102.google.com with SMTP id n1so141713nzf
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 05:22:10 -0700 (PDT)
In-Reply-To: <1155213365.22922.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertl@mail.com, mlord@pobox.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-10 am 03:27 -0400, ysgrifennodd Jeff Garzik:
>> hehe :)
>>
>> Well I am more than willing to rename it, though its a bit low priority.
>>
>> What would people prefer?  libata-sff.c ?
> 
> Looking at the non-PCI cases I think it needs a three way split
> 
> - Libata core as it is now basically (no bus specific code at all)
> - Libata register compatibility stuff (ST506) in a file (no
> dependancies) [libata-legacy] ??

As we're using 'legacy' to refer to PCI compatible mode and it's a bit 
long, how about libata-tf?

> - Libata BMDMA, SFF PCI in a file (dep CONFIG_PCI)  [libata-sff]

-- 
tejun
