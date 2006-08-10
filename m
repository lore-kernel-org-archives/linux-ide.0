From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Thu, 10 Aug 2006 03:27:05 -0400
Message-ID: <44DADFC9.7010700@pobox.com>
References: <1154919840689-git-send-email-htejun@gmail.com>	 <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com>	 <44D98388.8030005@pobox.com> <1155121214.5729.153.camel@localhost.localdomain> <44DADC67.5060707@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32723 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751440AbWHJH1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 03:27:32 -0400
In-Reply-To: <44DADC67.5060707@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, mlord@pobox.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> When libata-bmdma.c is seperated out from libata-core.c, I was wondering why the
> BM-DMA PRD table management codes such as ata_sg_setup() are left in libata-core.c,
> while the old WD1003/ST-506 like logic ata_tf_load(), ata_exec_command() and ata_check_status()
> are moved to the libata-bmdma.c.
> 
> Jeff explained the traditional WD1003 ST-506 registers can be viewed as subset of BM-DMA,
> but I still feel strange to call the old WD1003-like IDE controllers on my 386/486 as "BM-DMA"...

hehe :)

Well I am more than willing to rename it, though its a bit low priority.

What would people prefer?  libata-sff.c ?

	Jeff


