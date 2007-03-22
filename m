From: Christoph Hellwig <hch@infradead.org>
Subject: Re: request_queue_t depends on CONFIG_BLOCK
Date: Thu, 22 Mar 2007 21:53:51 +0000
Message-ID: <20070322215351.GA7216@infradead.org>
References: <20070322215234.GA13219@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46296 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161121AbXCVVxw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 17:53:52 -0400
Content-Disposition: inline
In-Reply-To: <20070322215234.GA13219@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Mar 22, 2007 at 10:52:34PM +0100, Olaf Hering wrote:
> How can this compile error be fixed properly?
> request_queue_t is inside CONFIG_BLOCK,
> ide_drive_s (and likely others) use it unconditionally.
> 
> 
>   CC      arch/powerpc/kernel/setup_64.o
> In file included from linux-2.6.21-rc4/arch/powerpc/kernel/setup_64.c:23:

start looking for the problem here.  Why does you arch code include ide.h?

