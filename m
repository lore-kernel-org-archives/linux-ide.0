From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata - error register patch.
Date: Mon, 04 Oct 2004 17:25:49 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4161BFDD.1070509@pobox.com>
References: <20040929175011.L15041@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62941 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268515AbUJDV0C
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 17:26:02 -0400
In-Reply-To: <20040929175011.L15041@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> It's entirely possible I'm missing something either
> very obvious, or very subtle, but I think the reading
> of the error register in libata et al is incorrect.
> 
> Current code only reads the error register when
> in LBA48 mode, and then stores it in tf->hob_feature.
> Attached patch always reads it and stores it
> in tf->feature.


I'm still thinking about this one.

I need to check and see the behavior of this register, as we have a 
separate ata_chk_err() as well.

	Jeff


