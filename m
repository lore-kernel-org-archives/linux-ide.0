From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream] libata: implement slave_link
Date: Thu, 31 Jul 2008 17:02:39 +0900
Message-ID: <1217491364-19725-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39899 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbYGaIES (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 04:04:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw

Hello, guys.

This is the first take of implement-slave_link patchset.  This
patchset tries to solve the stinking problem of per-device SCR
registers access for SFF master/slave emulated controllers (e.g. SIDPR
SCR access on ata_piix and the upcoming config space SCR access for
vt6421).

libata has three elements to abstract ATA bus - port, link and device
(there's also host but it can be ignored for the purpose of this
discussion).  A port is an independent unit which is connected to the
host bus on one side and an ATA bus on the other.  It hosts single ATA
bus and is what drivers program.  A link abstracts the physical
connection of the ATA bus - PHYs and cables.  Device represents the
ATA devices - disks, cdroms.

This forms proper hierarchy and works pretty well for all common
cases.  PATA: port - link - two devices.  SATA: port - link - device.
SATA w/ PMP: port - (link - device) * N.

However, per-device SCR access on M/S doesn't have a good way to
represent using this hierarchy.  Master and slave are on separate PHYs
and cables and thus all the physical link characteristics including
error status and speed are separate but they're logically bound into
one channel by the hardware emulation layer - things like command
scheduling and issue, softreset, discovery and configuration should be
handled as if both master and slave are on the same link.

Modifying whole abstraction to accomodate this weird configuration is
pretty pervasive regardless of the approach direction.  If the slave
device is put into a completely separate link, command issue, tracking
and most of EH needs to be restructured because many actions can't be
taken independently on a link.  If a link is changed so that it can
represent two physical links inside it, all functions which deal with
link needs to be updated and likely in pretty ugly way.

Given that this type of configurations are pretty rare, I don't think
it justifies such pervasivness, so I cheated a bit and implemented
something in the middle.  Both master and slave devices live under the
default host link.  The logical topology remains unchanged and all the
code paths which don't deal with physical link properties can work as
usual.

To host physical link properties, a separate pseudo link is created,
which is named slave_link.  Normal iteration of links doesn't go over
it, semantics of all operations remain the same making it virtually
invisible to LLDs.  In fact, except for initialization routine, none
of physical link methods is exported to LLDs.

Only code paths directly dealing with physical link properties are
modified to distinguish master and slave links - link speed
configuration, EH autopsy and report, and reset.  For everything other
than reset, the change isn't too pervasive.  It's often just using
ata_dev_phys_link() and ata_phys_link_on/offline() instead of
dev->link and ata_link_on/offline() or doing per-link operation one
more time on ap->slave_link.

Reset received more changes so that reset protocol now looks like the
following.

prereset(M) -> prereset(S) -> hardreset(M) -> hardreset(S) ->
softreset(M) -> postreset(M) -> postreset(S)

Note that softreset is performed only on the master link.  This should
be done this way as softreset resets both master and slave by
definition on this type of configurations.

ata_piix is converted to use slave_link instead of the ugly merged SCR
access.  Other than having to use sata_std_hardreset instead of
sata_sff_hardreset (as there's no defined way to wait for device
readiness when only M or S has been reset), all ata_piix have to do is
providing SCR r/w ops and calling ata_slave_link_init() during
initialization.

With the merged SCR access, ata_piix probing looked like the
following.

  ata1: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa480 irq 19
  ata2: SATA max UDMA/133 cmd 0xa880 ctl 0xa800 bmdma 0xa488 irq 19
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.01: HPA detected: current 976771055, native 976773168
  ata1.01: ATA-7: ST3500641NS                          EIT, 3.AEJ, max UDMA/133
  ata1.01: 976771055 sectors, multi 16: LBA48 NCQ (depth 0/32)
  ata1.01: configured for UDMA/133
  ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata2.00: HPA detected: current 312579695, native 312581808
  ata2.00: ATA-7: SAMSUNG HD160JJ, ZM100-41, max UDMA7
  ata2.00: 312579695 sectors, multi 16: LBA48 NCQ (depth 0/32)
  ata2.00: configured for UDMA/133

Note that the merged SCR access makes it look like ataN.00 and ataN.01
live on the same link to libata, which in turn manages it as a single
link, which is ugly and doesn't always show the expected behavior.
e.g. transfer error on one link will slow down link speed for both
master and slave; also, device presence detection isn't exact.  After
converting to slave_link, it looks like.

  ata5.00: SATA link down (SStatus 0 SControl 300)
  ata5.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata5.01: HPA detected: current 976771055, native 976773168
  ata5.01: ATA-7: ST3500641NS                          EIT, 3.AEJ, max UDMA/133
  ata5.01: 976771055 sectors, multi 16: LBA48 NCQ (depth 0/32)
  ata5.01: configured for UDMA/133
  ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata6.01: SATA link down (SStatus 0 SControl 300)
  ata6.00: HPA detected: current 312579695, native 312581808
  ata6.00: ATA-7: SAMSUNG HD160JJ, ZM100-41, max UDMA7
  ata6.00: 312579695 sectors, multi 16: LBA48 NCQ (depth 0/32)
  ata6.00: configured for UDMA/133

Note that libata recognizes that two devices are on separate links and
handle them as such.  Everything including EH and link speed force
parameter works as expected.

So, much better support for SFF M/S emulating SATA controllers w/ SCR
access with little effort on LLDs.

This patchset contains the following five patches.

  0001-libata-make-SCR-access-ops-per-link.patch
  0002-libata-reimplement-link-iterator.patch
  0003-libata-misc-updates-to-prepare-for-slave-link.patch
  0004-libata-implement-slave_link.patch
  0005-ata_piix-drop-merged-SCR-access-and-use-slave_link.patch

0001-0003 are preparations.  0004 implements slave_link.  0005
converts ata_piix to use it.

This patchset is on top of

upstream (2640d7c0b8d5d9d9ee303b8cd09f5124176f6239)
+ [1] fix-EH-action-overwriting-in-ata_eh_reset
+ [2] always-do-follow-up-SRST-if-hardreset-returned--EAGAIN
+ [3] use-ata_link_printk-when-printing-SError
+ [4] restore-SControl-on-detach

and available in the following git tree.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=slave_link
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git slave_link

Joseph Chan, vt6421 should be able to do the same as ata_piix.  It's
really simple.  Just call ata_slave_link_init() on the SATA ata_port
which have both M/S and allows SCR access, set SCR rw ops and
distinguish M/S by looking at link->pmp and set hardreset to
sata_std_hardreset().  The reset can be left as they are.  It'll just
work.  :-)

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/33283
[2] http://article.gmane.org/gmane.linux.ide/33281
[3] http://article.gmane.org/gmane.linux.ide/33282
[4] http://article.gmane.org/gmane.linux.ide/33284
