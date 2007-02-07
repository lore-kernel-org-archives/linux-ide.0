From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] (2.6.20) pata_mpiix: fix PIO setup issues
Date: Tue, 06 Feb 2007 19:53:59 -0500
Message-ID: <45C92327.7050505@garzik.org>
References: <200702052024.57511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57053 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030480AbXBGAyB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:54:01 -0500
In-Reply-To: <200702052024.57511.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Fix clearing/setting the wrong TIME/IE/PPE bits for a slave drive caused by a
> wrong shift count.
> Fix the PIO mode 1 being overclocked by wrongly selecting the fast timing bank.
> Also, fix/rephrase some comments while at it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
>  drivers/ata/pata_mpiix.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)

applied


