From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ahci: Add support for Cavium's fifth generation SATA
 controller
Date: Mon, 16 Oct 2017 23:58:51 -0700
Message-ID: <20171017065851.GA19939@infradead.org>
References: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757026AbdJQG6x (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Oct 2017 02:58:53 -0400
Content-Disposition: inline
In-Reply-To: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Radha Mohan Chintakuntla <mohun106@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

On Tue, Oct 10, 2017 at 10:37:51PM -0700, Radha Mohan Chintakuntla wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> This patch adds support for Cavium's fifth generation SATA controller.
> It is an on-chip controller and complies with AHCI 1.3.1. As the
> controller uses 64-bit addresses it cannot use the standard AHCI BAR5
> and so uses BAR4.

Looks like it isn't actually AHCI 1.3.1 compliant after all then :)
