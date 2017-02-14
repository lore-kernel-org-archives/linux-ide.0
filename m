From: Christoph Hellwig <hch@infradead.org>
Subject: Re: DMA issue caused by vmapped stacks
Date: Tue, 14 Feb 2017 04:27:20 -0800
Message-ID: <20170214122720.GA29765@infradead.org>
References: <CAPeEpDroE2bYQ_viz7qExspordpR6gLYHjVxaJ53px3utz+PrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdBNM1V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2017 07:27:21 -0500
Content-Disposition: inline
In-Reply-To: <CAPeEpDroE2bYQ_viz7qExspordpR6gLYHjVxaJ53px3utz+PrA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guillermo Amaral <g@maral.me>
Cc: linux-ide@vger.kernel.org

Hi Guillermo,

are you using libata or the old IDE driver?  Any messages in the kernel
log that might be useful?
