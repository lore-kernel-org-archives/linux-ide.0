From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Thu, 30 Aug 2007 17:32:39 -0400
Message-ID: <20070830213239.GJ11128@csclub.uwaterloo.ca>
References: <200708212149.12912.jopan@alumni.uv.es> <20070822162312.GG9412@csclub.uwaterloo.ca> <46CC6A2F.5000406@gmail.com> <200708280044.34475.jopan@alumni.uv.es> <46D455DB.8000800@gmail.com> <Pine.LNX.4.64.0708302130210.24730@fbirervta.pbzchgretzou.qr> <46D7231B.3080807@gmail.com> <87f94c370708301416j2a7c000bscbaef593af004010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:37682 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755705AbXH3Vck (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 17:32:40 -0400
Content-Disposition: inline
In-Reply-To: <87f94c370708301416j2a7c000bscbaef593af004010@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Rene Herman <rene.herman@gmail.com>, Jan Engelhardt <jengelh@computergmbh.de>, Jos? Luis Pati?o Andr?s <jopan@alumni.uv.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, Aug 30, 2007 at 05:16:46PM -0400, Greg Freemyer wrote:
> USB / Firewire / FC / iSCSI are all SCSI transports and fit within the
> SCSI subsystem by design.
> 
> ie. Just like ethernet, DSL, T-1, etc can all carry IP traffic with no
> conceptual conflict, many media by design carry SCSI traffic.
> 
> The PATA and SATA physical layer typically carry ATA commands and
> having them tied into the SCSI stack is an aberration that I hope will
> be eliminated some day.
> 
> ATAPI is an exception.  Not sure where that would end up in a perfect world.

But isn't SATA related to SAS?  And isn't SAS using SCSI commands?  And
if ATAPI is essentially SCSI commands, and everything other then disks
use ATAPI on ATA, then that makes ATA disks the odd ball, and mangling
it into line with everything else isn't that bad (since all other ATA
devices are close to SCSI already).

--
Len Sorensen
