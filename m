From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/3] drivers/block/mtip32xx: Adding Makefile and
 Kconfig
Date: Thu, 11 Aug 2011 18:47:25 -0400
Message-ID: <20110811224725.GB10182@infradead.org>
References: <22A973199D2C2F46933448F6E7990A3002C80029@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:58936
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab1HKWr3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2011 18:47:29 -0400
Content-Disposition: inline
In-Reply-To: <22A973199D2C2F46933448F6E7990A3002C80029@ntxboimbx31.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Moyer <jmoyer@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <jaxboe@fusionio.com>

I think the driver at least needs to depend on PCI.

