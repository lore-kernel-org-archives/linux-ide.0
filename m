From: Tejun Heo <teheo@suse.de>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Sun, 23 Nov 2008 16:11:56 +0900
Message-ID: <4929023C.2060302@suse.de>
References: <4928E010.4090801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35426 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbYKWHMG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 02:12:06 -0500
In-Reply-To: <4928E010.4090801@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@v>
Cc: Matthew Wilcox <matthew@wil.cx>

Hello,

cc'ing Matthew whom I forgot to cc in the first message.  Matthew, the
original message is...

 http://lkml.org/lkml/2008/11/22/260

Tejun Heo wrote:
> Dongjun Shin who works for Samsung SSD dep asked me about libata TRIM
> support and pointed me to the new DISCARD support David Woodhouse got
> merged for 2.6.28.  I took a look at the code and blk-layer
> interface-wise we seemed to be ready both for filesystems and userland
> (so that fsck or something which runs background can mark unused
> blocks) but there doesn't seem to be any low level driver which
> actually implements ->prepare_discard_fn or fs which sets the DISCARD
> flag.

Dongjun, the only doc I can find about ATA TRIM is the following one.

 http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf

And AFAICS this hasn't made into ACS yet.  Is this what you guys are
gonna implement and Windows7 is gonna use?

Thanks.

-- 
tejun
