From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ata_piix: improve combined mode handling
Date: Wed, 1 Mar 2006 01:25:38 +0900
Message-ID: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:54770 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751869AbWB1QZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:52 -0500
Received: by wproxy.gmail.com with SMTP id i4so167334wra
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:51 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset is against the current upstream[1] + kill illegal
kfree() patch[2].

This patchset improves combined handling of ata_piix.  Proper port map
is implemented such that ata_piix knows exactly how PIIX SATA ports
are mapped to ATA devices.  This patchset also should fix device
detection problem which seems to be caused by honoring present bits
while the datasheet declares them reserved on 6300ESB.  (Jean & 0602,
can you guys please test this patchset?)

I couldn't find datasheets for ESB2 and ICH8, so I assumed ESB2 is
similar to ICH6, ICH8 to ICH6 and ICH8M to ICH6M.  Is this correct?

Jeff, I'm trying to implement SCR access on ICH6/7's on top of these
changes and have a question about libata-bmdma.c::ata_pci_init_one().
ata_piix needs its own version of this function as it should try to
map ABAR for SCR (and fall back if it fails), so I'm trying to factor
functions out of ata_pci_init_one() and call them from ata_piix.

ata_pci_init_one() currently uses two separate probe_ent for each port
if the controller is in legacy mode, which makes the ports use
separate host_set and thus separate spin locks.  Do they need to use
separate spinlocks?  Or are there other reasons legacy initialization
is done this way?

Oh.. Another question.  When you were talking about getting PCS bits
wrong before [3], were you talking about port map (like port 1 and 3
map to primary master/slave) or is there something else PCS + MAP
doesn't cover?

Thanks.

--
tejun

[1] cccc65a3b60edaf721cdee5a14f68ba009341822
[2] http://article.gmane.org/gmane.linux.ide/8324


