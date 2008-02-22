From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata-piix.c (and libata.ko) in RHEL5.1 (build 78 currently) -
 this kernel is 2.6.18 baqsed
Date: Fri, 22 Feb 2008 17:03:12 +0000
Message-ID: <20080222170312.4c849c0d@core>
References: <6853F62BE9A693419863D51D4554A9E3012BE92B@EXNA.corp.stratus.com>
	<20080222151010.GC30920@devserv.devel.redhat.com>
	<47BEFB0B.9070808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59757 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753078AbYBVROk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 12:14:40 -0500
In-Reply-To: <47BEFB0B.9070808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@redhat.com>, "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>, jgarzik@pobox.com, "Petrakis, Peter" <Peter.Petrakis@stratus.com>, "Duval, Dan" <Dan.Duval@stratus.com>, "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

> 3) It is critical to ensure that the ATA "ctl" register is never
> written to when no drive is attached.  This means bracketing the SRST
> sequence to first do a PCS detection before permitting the SRST.
> If "ctl" is accessed with no drive attached, the machine locks up hard.

At least for PATA you probably need to disable IORDY handshaking before
the reset and probe.

Alan
