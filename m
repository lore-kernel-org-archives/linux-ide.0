From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] sata_inic162x: finally, driver for initio 162x SATA
 controllers, take #2
Date: Fri, 19 Jan 2007 19:04:59 -0500
Message-ID: <45B15CAB.8030503@pobox.com>
References: <20061217014827.GK5400@htj.dyndns.org> <20061217015008.GL5400@htj.dyndns.org> <20061220062546.GA4823@htj.dyndns.org> <45899560.8090401@pobox.com> <459B66BA.2010405@gmail.com> <20070103083039.GG10987@htj.dyndns.org> <20070103083245.GH10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53656 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932795AbXATAFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:05:01 -0500
In-Reply-To: <20070103083245.GH10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

Tejun Heo wrote:
> Driver for Initio 162x SATA controllers.  ATA r/w, ATAPI r, hotplug
> and suspend/resume work.  ATAPI w (recording, that is) broken.  Feel
> free to fix it, but be warned, this controller is weird.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> * Modified as advised by Jeff.
> 
> * Made config option depend on EXPERIMENTAL.
> 
> Thanks.
> 
>  drivers/ata/Kconfig         |    6 
>  drivers/ata/Makefile        |    1 
>  drivers/ata/sata_inic162x.c |  809 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 816 insertions(+)

applied


