From: Jeff Garzik <jgarzik@pobox.com>
Subject: PATA+SATA controllers and libata (was Re: IDE connector on Promise
 20376 SATA controller)
Date: Fri, 24 Sep 2004 19:24:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4154ACA8.80401@pobox.com>
References: <1096060840.6059.4.camel@homer.blizzard.org>	 <415497E1.9050207@pobox.com> <58cb370e04092415506cacdf86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269059AbUIXXYh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Sep 2004 19:24:37 -0400
In-Reply-To: <58cb370e04092415506cacdf86@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Uwe Koziolek <uwe.koziolek@gmx.net>, Erik Andersen <andersen@codepoet.org>


The problems to solve, in order to support PATA and SATA on the same 
controller:

1) struct ata_probe_ent describes a single host controller.  It has a 
single struct ata_port_operations pointer.  To support PATA and SATA on 
the same controller, multiple ata_port_operations pointers must be 
supported.

2) struct ata_host_set uses a single struct ata_port_operations for the 
entire host controller.

Fix those two things, and support for PATA+SATA controllers is possible.

	Jeff


