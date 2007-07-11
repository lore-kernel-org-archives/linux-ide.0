From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 10/16] libata-link: separate out link initialization functions
Date: Tue, 10 Jul 2007 21:52:13 -0400
Message-ID: <469437CD.5020300@garzik.org>
References: <11832843601724-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37776 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbXGKBwP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:52:15 -0400
In-Reply-To: <11832843601724-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out link initialization into ata_link_init() and
> ata_link_init_sata_spd_limit().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Function name too long :)  Drop "_limit" perhaps.

Anyway, ACK 3-10


