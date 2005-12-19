From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC/PATCHSET] libata: new reset mechanism
Date: Mon, 19 Dec 2005 00:20:52 -0500
Message-ID: <43A64334.7010500@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2949 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030269AbVLSFVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:21:02 -0500
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> Currently libata uses ->phy_reset to reset ports.  However,
> ->phy_reset is tightly woven into probing process (directly
> manipulating device[]->class and disabling ports on failure) and thus
> awkward to use for error handling or other purposes.
> 
> Another problem with the current scheme is that libata doesn't have
> much control over reset process, which isn't very nice for both
> initialization and error handling.
> 
> This patchset implements new reset mechanism.  The new mechanism can
> peacefully live side-by-side with ->phy_reset mechanism and low level
> drivers can be converted gradually.  This patchset converts sata_sil,
> sata_sil24, ata_piix and ahci as a start.
> 
> This patchset is composed of the following 14 patches.
> 
> #01-03	: implement new reset mechanism and standard callbacks
> #04	: preparation for low level driver conversion
> #05	: convert sata_sil
> #06-07	: convert sata_sil24 and add hardreset
> #08-09	: convert ata_piix
> #10-14	: convert ahci and add softreset

Hard and soft reset should be implemented as

	qc = ata_qc_new_init()
	qc->tf.protocol = ATA_PROT_HARD_RESET;
	... ata_qc_issue() ...

which automatically takes advantage of the ability to specify a behavior 
using the qc_prep/qc_issue driver hooks.  The ATA passthru CDB supports 
this method of programming (hard and soft reset are specified 
protocols), and this is very similar to how the SiI 3124 behaves.  Other 
FIS-based controllers will implement qc_issue/qc_prep such that they 
send two Control FIS's.  Taskfile-based controllers use the currently 
implemented method.

On a separate note, E.D.D. support can probably be dropped.  No driver 
uses it AFAIK.  It was only used during development and in the early 
libata days.

Further, we should lean towards avoiding hard reset, and issuing SRST 
most of the time, even for drivers currently doing hard reset (COMRESET).

	Jeff



