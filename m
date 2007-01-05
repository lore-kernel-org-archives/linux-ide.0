From: Jim Paris <jim@jtan.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Fri, 5 Jan 2007 00:34:18 -0500
Message-ID: <20070105053418.GA6768@jim.sh>
References: <Pine.LNX.4.58.0701050407060.26166@mailx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:41452 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030342AbXAEFxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jan 2007 00:53:20 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0701050407060.26166@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-ide@vger.kernel.org

Hi Brad,

> Hardware:
>    Norco DS-1220 SATA enclosure (sil2134 card w/ 4 PMP/direct ports,
>    enclosure is 2x sil3726 (5 disks each), and then 2 direct SATA ports.
> 
>    (also have 2x SATA internal, on ata_piix, md raid1, that's working fine...
>     those are sd[ab], ata[12].nn, scsi[01])
> 
> Kernel:
>    2.6.18.6 + libata-tj-2.6.18.1-20061020.
> 
> Issue:
> 
> Disks in DS-1220 show up, kinda, but don't work.  Errors reading /
> writing blocks.  Tried a single disk in both a PMP port and a direct
> (non-sil3726) port.

Just FYI:

I am using the same enclosure and card with no problems at all on
2.6.17.4 + libata-tj-2.6.17.4-20060710.  The card is plugged into a
PCI slot, not PCI-X.  My disks are Seagate ST3300822AS in all 12 bays.

-jim
