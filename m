From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Wed, 01 Apr 2009 21:11:51 +0000
Message-ID: <1238620311.3318.99.camel@mulgrave.int.hansenpartnership.com>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59063 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643AbZDAVWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 17:22:40 -0400
In-Reply-To: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: salimmu@beardog.cca.cpqcorp.net
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com

On Wed, 2009-04-01 at 15:51 -0500, salimmu@beardog.cca.cpqcorp.net
wrote:
> +       mode = cdb[1] & 0x07; /* First 3 bits 0x07=00000111 */

SPC-3 defines this field as 5 bits; SPC-2 defined it as 4; it was only
the ancient SPC standard that defined it as three.

I think you need to up this to 5 bits otherwise you might get
interference from line verification attempts using the echo buffer
(which is defined as mode 10 ... and would translate to 2 if you just
believe the first 3 bits).

James


