From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci.c: fix CONFIG_PM=n compilation
Date: Fri, 20 Jul 2007 07:47:20 -0400
Message-ID: <46A0A0C8.1030201@garzik.org>
References: <20070717194848.GA5824@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49774 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762878AbXGTLrW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:47:22 -0400
In-Reply-To: <20070717194848.GA5824@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-ide@vger.kernel.org

Alexey Dobriyan wrote:
> Commit df69c9c5438b4e396a64d42608b2a6c48a3e7475 moved only prototype of
> out of CONFIG_PM. Move function out as well. Box seems to boot fine.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/ata/ahci.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

applied


