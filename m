From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ #3
Date: Tue, 31 May 2005 12:49:19 -0400
Message-ID: <429C958F.7090700@pobox.com>
References: <20050531124659.GB1530@suse.de> <429C86AD.4050605@pobox.com> <429C90DE.3000106@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22913 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261963AbVEaQt0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 May 2005 12:49:26 -0400
In-Reply-To: <429C90DE.3000106@tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Jeff Garzik wrote:
> []
> 
>> 
>> struct ahci_host_priv {
>> 	unsigned long		flags;
>>+	unsigned int		have_msi; /* is PCI MSI enabled? */
> 
> 
> BTW, can `have_msi' be just another bit in the `flags' field?

Yes, that would be a good cleanup to make.

Wanna submit a patch adding HOST_CAP_MSI bit?

	Jeff



