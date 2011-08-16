From: Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: [PATCH v3 3/3] drivers/block/mtip32xx: Adding Makefile and Kconfig
Date: Tue, 16 Aug 2011 10:54:05 -0600
Message-ID: <4E4AA0AD.7090109@micron.com>
References: <22A973199D2C2F46933448F6E7990A3002C80029@ntxboimbx31.micron.com> <20110811224725.GB10182@infradead.org>
Reply-To: <asamymuthupa@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:8192 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1HPQyy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2011 12:54:54 -0400
In-Reply-To: <20110811224725.GB10182@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Moyer <jmoyer@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jaxboe@fusionio.com>

On 8/11/2011 4:47 PM, Christoph Hellwig wrote:
> I think the driver at least needs to depend on PCI.

Actually we should depend on pciehp module. I ran into some issue (in
kernel 2.6.39) when introducing the dependency, and removed the
dependency temporarily. I will check again with the current kernel.

-- 
Regards,
Asai Thambi
