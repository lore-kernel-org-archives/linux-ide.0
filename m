From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: WARN_ON(buflen > PAGE_SIZE) libata-core.c
Date: Thu, 16 Sep 2004 22:39:34 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <414A4E66.5000009@pobox.com>
References: <20040901150801.A12145@florence.linkmargin.com> <414A34A6.1020506@pobox.com> <20040916213450.A14950@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268496AbUIQCjr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Sep 2004 22:39:47 -0400
In-Reply-To: <20040916213450.A14950@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>
>>>In libata-core.c:ata_sg_init_one() there is:
>>>
>>>	WARN_ON(buflen > PAGE_SIZE);
>>
>>[...]
>>A non-scatter-gather transfer is assumed to be one page in length, using 
>>only a single 'struct scatterlist' element.  You could probably "cheat" 
>>and indicate the scatterlist element is longer than PAGE_SIZE, but make 
>>sure to review all code paths...
> 
> 
> Bear with me, if I'm being dense, but why is that a valid
> assumption ? Is it because in most instances, such requests
> are made by filesystem code, as opposed to arbitrary user
> initiated I/O ?

A struct scatterlist is a list of page/offset/length triplets, so it 
breaks the model if a triplet extends past a page boundary.

	Jeff


