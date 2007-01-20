From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: kill qc->nsect and cursect
Date: Fri, 19 Jan 2007 19:04:46 -0500
Message-ID: <45B15C9E.80607@pobox.com>
References: <20061217014827.GK5400@htj.dyndns.org> <20061217015008.GL5400@htj.dyndns.org> <20061220062546.GA4823@htj.dyndns.org> <45899560.8090401@pobox.com> <459B66BA.2010405@gmail.com> <20070103083039.GG10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53648 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932623AbXATAE5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:04:57 -0500
In-Reply-To: <20070103083039.GG10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

Tejun Heo wrote:
> libata used two separate sets of variables to record request size and
> current offset for ATA and ATAPI.  This is confusing and fragile.
> This patch replaces qc->nsect/cursect with qc->nbytes/curbytes and
> kills them.  Also, ata_pio_sector() is updated to use bytes for
> qc->cursg_ofs instead of sectors.  The field used to be used in bytes
> for ATAPI and in sectors for ATA.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


