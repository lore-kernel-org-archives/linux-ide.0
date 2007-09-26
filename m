From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 22:33:46 -0400
Message-ID: <46F9C50A.2080009@garzik.org>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org> <46F9617F.1010508@gmail.com> <46F9B3FE.1060905@garzik.org> <46F9C336.3010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56266 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbXIZCdv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:33:51 -0400
In-Reply-To: <46F9C336.3010005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Berck E. Nash wrote:
> Jeff Garzik wrote:
>> Does the attached patch change behavior at all?  You should be able to
>> apply it on top of libata-dev.git#upstream or -mm.
> 
> Still broken, dmesg with ATA_DEBUG defined, attached.

Great, this will be useful output.  It will probably be a couple days 
before my next patch.  In the meantime, you can extract the bad commit 
to a patch

	git-diff-tree -p 268fe6f9f15551be9abedd44a237392675d529d5 > \
		/tmp/patch

and then revert it locally in your kernel tree

	patch -sp1 -R < /tmp/patch

to temporarily work around this.

I will definitely make sure this is either fixed or reverted before it 
goes upstream to Linus.

Thanks,

	Jeff


