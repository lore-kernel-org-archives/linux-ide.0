From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: cp from SATA to SCSI freeze
Date: Mon, 25 Oct 2004 02:05:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041025000513.GA20238@iah.epita.fr>
References: <1098612795.11032.20.camel@tycho.astronomy.dk> <clg24h$ep$1@sea.gmane.org> <1098622024.2563.6.camel@tycho.astronomy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.0.25]:57887 "HELO
	ideliver.epitech.net") by vger.kernel.org with SMTP id S261630AbUJYAFV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Oct 2004 20:05:21 -0400
Content-Disposition: inline
In-Reply-To: <1098622024.2563.6.camel@tycho.astronomy.dk>
List-Id: linux-ide@vger.kernel.org
To: Bjarne Thomsen <bjarne.thomsen@get2net.dk>
Cc: linux-ide@vger.kernel.org

Bjarne Thomsen wrote:
| On Sun, 2004-10-24 at 13:02, Marc Bevand wrote:
| > When it freezes, do you see some kernel messages displayed on
| > the console ?
|
| No message at all.
|
| > Also, how many SATA disks and how many SCSI disks are involved ?
| > Are you using software RAID ?
|
| 2 SCSI disks connected to the 29160; 1 SATA disk connected
| to the SATA1 port. I can copy between the 2 SCSI disks
| without problems. No software raid, and I chose Ultra
| (not raid) for SATA in the latest BIOS (beta) bersion.

The sii3114 SATA chip on your motherboard is known to be buggy with
some drives (Seagate, Maxtor), which are blacklisted by sata_sil.c.

Can you try 2.6.9 ? IIRC more drives have been added to the blacklist
in 2.6.9.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
