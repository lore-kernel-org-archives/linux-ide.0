From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-scsi.c: ata_scsi_simulate question
Date: Wed, 23 Feb 2005 17:41:32 -0500
Message-ID: <20050223224132.GA11163@havoc.gtf.org>
References: <66F9227F7417874C8DB3CEB057727417044FA2@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:58271 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261626AbVBWWln (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 17:41:43 -0500
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB057727417044FA2@MILEX0.Miltope.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Winstel, Drew" <DWinstel@Miltope.com>
Cc: "Linux-Ide (E-mail)" <linux-ide@vger.kernel.org>

On Wed, Feb 23, 2005 at 04:35:11PM -0600, Winstel, Drew wrote:
> I noticed that in libata-scsi.c, the ata_scsi_simulate() 
> function calls for the SCSI commands SEEK_6 and SEEK_10 
> are being simulated instead of being translated to the 
> ATA SEEK command (0x70).  Why is this being done?

That's what the SCSI T10 SAT standard specifies.

	Jeff



