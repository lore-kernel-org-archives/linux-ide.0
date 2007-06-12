From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 3/3] Enable Aggressive Link Power management for AHCI controllers.
Date: Tue, 12 Jun 2007 14:50:10 +0100
Message-ID: <20070612135010.GA12601@srcf.ucam.org>
References: <20070611184146.448266229@intel.com> <20070611114839.907bcae2.kristen.c.accardi@intel.com> <20070612011148.GA9808@khazad-dum.debian.net> <466DF3E9.30303@linux.intel.com> <d8jr6oikkcz.fsf@nygaard.ping.uio.no> <466DFE09.3020408@garzik.org> <20070612035928.GB9808@khazad-dum.debian.net> <466E1A32.90306@linux.intel.com> <20070612090940.GA9719@srcf.ucam.org> <20070612121819.GA20408@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:36613 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbXFLNuf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jun 2007 09:50:35 -0400
Content-Disposition: inline
In-Reply-To: <20070612121819.GA20408@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, Dagfinn Ilmari =?iso-8859-1?Q?Manns=E5ker?= <ilmari@ilmari.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, james.bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

On Tue, Jun 12, 2007 at 09:18:19AM -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 12 Jun 2007, Matthew Garrett wrote:
> > 
> > On laptops, I suspect that we'll probably get an ACPI interrupt even if 
> > the AHCI hotplug pathway can't manage.
> 
> As long as we don't crash the drive or AHCI controller because we hotplugged
> it in a way it didn't like (like trying to hotplug a ICH5R would cause).

Laptop bays are designed to deal with hotplugging PATA - I don't think 
this is too much of an issue :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
