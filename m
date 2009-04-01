From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Wed, 1 Apr 2009 17:23:29 -0400
Message-ID: <87f94c370904011423m1c48dbd1vb934789cb02fc979@mail.gmail.com>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:3414 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbZDAVXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 17:23:31 -0400
Received: by yx-out-2324.google.com with SMTP id 31so231942yxl.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2009 14:23:29 -0700 (PDT)
In-Reply-To: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: salimmu@beardog.cca.cpqcorp.net
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com

A signature block with the company name misspelled.

I'd look real close at the patch.

On Wed, Apr 1, 2009 at 4:51 PM,  <salimmu@beardog.cca.cpqcorp.net> wrote:
> Attach is a patch that adds translation of scsi WRITE_BUFFER to ATA_DOWNLOAD_MICROCODE command. This patch enables firmware flashing of sata drives that are registered as scsi devices under linux; hence scsi to ata translation is needed. This patch provides the translation.
>
> Imran Salim
> Hewlett Pacakrd Company
> Houston, TX
> (281) 514-1531
>
>



-- 
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
