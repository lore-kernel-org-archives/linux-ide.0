From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
 DMA_NONE
Date: Mon, 11 Dec 2006 09:33:51 -0500
Message-ID: <457D6C4F.6090303@pobox.com>
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org> <200612111518.46887.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46212 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935957AbWLKOeD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 09:34:03 -0500
In-Reply-To: <200612111518.46887.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 11 December 2006 15:02, Tejun Heo wrote:
>>  {
>>         struct scatterlist sg;
>> +       unsigned int n_elem = 0;
>>  
>> -       sg_init_one(&sg, buf, buflen);
>> +       if (dma_dir != DMA_NONE) {
>> +               WARN_ON(!buf);
>> +               sg_init_one(&sg, buf, buflen);
>> +               n_elem++;
>> +       }
>>  
> Ok, looks good as well. I still think we should have the WARN_ON()
> in sg_set_buf(), but I can send a separate patch for that to linux-mm.

Please CC me and linux-ide on all libata patches (certainly akpm as 
well).  Andrew picks up most of the libata changes automatically via git 
from my libata-dev.git#ALL.

	Jeff



