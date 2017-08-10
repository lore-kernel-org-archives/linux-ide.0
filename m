From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] cs5536: add support for IDE controller variant
Date: Thu, 10 Aug 2017 02:41:27 -0700
Message-ID: <20170810094127.GA3460@infradead.org>
References: <20170809181926.20015-1-andrey@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdHJJl1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2017 05:41:27 -0400
Content-Disposition: inline
In-Reply-To: <20170809181926.20015-1-andrey@xdel.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Korolyov <andrey@xdel.ru>
Cc: linux-ide@vger.kernel.org

On Wed, Aug 09, 2017 at 09:19:26PM +0300, Andrey Korolyov wrote:
> Several legacy devices such as Geode-based Cisco ASA appliances
> and DB800 development board do possess CS5536 IDE controller
> with different PCI id than existing one. Using pata_generic is
> not always feasible as at least DB800 requires MSR quirk from
> pata_cs5536 to be used with vendor firmware.

Can we please avoid adding new PCI IDs to legacy drivers/ide?

Please resend without that hunk.
