From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and ata_port_operations
Date: Wed, 30 Jan 2008 18:28:54 +0900
Message-ID: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:36505 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYA3J3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277500wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:10 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to


Hello, all.

This is the first take of cleanup-sht-ops patchset.  As the name
suggests it reorganizes and cleans up scsi_host_template and
ata_port_operation tables used by libata core and low level drivers.

libata has always tried to allow a lot of flexibility to its low level
drivers and most parts of libata are overridable in some way.  LLDs
always submit full sht and ops tables to upper layers and they're free
to override any field they see fit.  This is all great but as time
goes by more and more fields have been added, more drivers got written
and individual drivers got extended to support more controllers.

This means that each driver should carry large amount of boilerplate
code and replicate them for each variant it supports.  This is not
only inconveinent but also highly error-prone when combined with our
multi-branched development model.

Low level drivers and core layers are being modified in different
branches all the time.  Core layer changes sometimes calls for update
in boilerplate code which is now a massive work due to the number of
low level drivers.  Later when core layer changes and low level driver
changes get merged, they can easily conflict and go unnoticed as
there's no automatic propagation of core changes to low level drivers
and the differences are often buried by all the bolierplating.

This patchset tries to solve the problem so that life is easier for
both core and lld developers.  The goals are...

* Reduce the amount of boilerplating.  It's way too much.  Unless a
  LLD wants to change the default behavior, LLD should be able to use
  provided helper and be done with it.

* Allow LLD to reuse ops tables easily.  Many drivers support similar
  but not quite identical chipsets, sometimes different generations of
  a single product or different products comforming to a standard.  In
  these cases, drivers usually only need to use a few different
  methods for each sub-type.  Currently, a LLD should replicate whole
  ops table for each variant.  By allowing LLD to override parts of
  its ops table, it can be made much easier and safer.

* Make core changes automagically propagate to low level drivers.
  libata now has a lot of low level drivers and it's getting
  increasingly difficult to update core and libata already has
  accumulated quite some amount of inconsistencies along the way.  By
  putting control of default behaviors in the core layer, things
  become easier for both core layer and LLDs.

* And all of above while not sacrificing flexibility.

This patchset adds initializer macros for shts and inheritance for ops
tables combined with base tables to inherit from.  The sht part is
straight forward, they're good old initializer macros which we
probably should have added long time ago.  They're named ATA_*_SHT()
and four variants exist.

BASE  : Common to all libata drivers.  The user must set sg_tablesize
	and dma_boundary.
PIO   : SFF ATA controllers w/ only PIO support.
BMDMA : SFF ATA controllers w/ BMDMA support.  sg_tablesize and
	dma_boundary are set to BMDMA limits.
NCQ   : SATA controllers supporting NCQ.  The user must set
	sg_tablesize, dma_boundary and can_queue.

LLDs can override or add specific fields by putting initializers below
the helpers.

The ops part is a tad bit trickier to make it easy for LLDs to reuse
their ops tables.  A new field ->inherits is added which points to the
ops table to inherit operations from.  The pointed table in turn can
inherit from another table as long as the inheritance doesn't form a
loop, so by inheriting an existing ops table, a LLD can avoid
specifying every needed op.  It just needs to specify what it has
implemented differently or additionally.

Also, as inheriting is done by simply initializing ->inherits field, a
LLD can inherit its own ops table to define a slightly different
version without defining initializer macros or copying the ops table
manually.  Please take a look at how ahci, ata_piix, pata_amd or
pata_sis take advantage of this.

The inheritance is hidden from LLDs and doesn't have any hot-path run
time overhead.  Inheritance is solved when the host is started.  It's
called finalization of the ops table.  The inheritance chain is
followed and each missing callback is filled from the nearest ancestor
which has the method implemented.  Once the host is started, there's
no difference from using direct full ops table and even the
finalization is done only once per ops table.

libata provides five base ops tables LLDs of different classes can
inherit from.  They are named [s]ata_*_port_ops.

base  : Common to all libata drivers.
sata  : SATA controllers w/ native interface (non-SFF).
pmp   : SATA controllers w/ PMP support.
sff   : SFF ATA controllers w/o BMDMA support.
bmdma : SFF ATA controllers w/ BMDMA support.

This patchset is consisted of 9 patches.  The first four fix bugs and
hunts down inconsistencies in preparation of the conversion.  The
fifth patch, sht-ops-conversion, implements and uses sht and ops
helpers.  The rest cleans up untidy port_info, sht, ops usages which
stemmed from or remain due to the cumbersome mechanism.

As the volume of conversion done in sht-ops-conversion makes it pretty
diffcult to verify.  It has been verified by dumping all the sht and
ops fields and comparing their values before and after.  For all
drivers which are compilable under x86(_64), the patch doesn't change
any field.  I'll write a reply to this head message containing the
patches and scripts used to verify it.

The following drivers need specific platform to build, so they need
verification.  If you work on one of the following drivers, please
verify that the driver builds and works fine.  It would be best if you
can verify that the sht and ops don't change by the fifth path using
the method I'll write in another message.

* pata_at32
* pata_bf54x
* pata_icside
* pata_ixp4xx_cf
* pata_mpc52xx
* pata_scc
* sata_fsl

All combined, this patchset sheds around 3700 lines of code from
libata and will make libata developers' lives (especially mine)
easier.

Basic functionality is tested on ahci, ata_piix, sata_sil, sata_sil24,
pata_jmicron, pata_hpt3x2n, sata_promise and pdc_adma.  The
sht-ops-conversion shouldn't cause any trouble but later clean up
patches definitely need some testing.  Fortunately, mistakes are
likely easy to spot during probing.

This patchset is on top of

  upstream (a984f58dd97f22f5113700322fed311a0ee29947)
+ prefer-hardreset patchset [1]
+ grace-failure-on-no-reset patch [2]
+ pci-allow-multiple-pcim_enable_device [3]

and comes with an impressive diffstat output.

 drivers/ata/ahci.c              |  158 ++++------------------
 drivers/ata/ata_generic.c       |   49 -------
 drivers/ata/ata_piix.c          |  185 ++------------------------
 drivers/ata/libata-core.c       |  131 +++++++++++++++++-
 drivers/ata/libata-eh.c         |   32 +++-
 drivers/ata/libata-pmp.c        |   47 +-----
 drivers/ata/libata-sff.c        |   53 ++-----
 drivers/ata/pata_acpi.c         |   71 +---------
 drivers/ata/pata_ali.c          |  161 +++--------------------
 drivers/ata/pata_amd.c          |  266 +++++++-------------------------------
 drivers/ata/pata_artop.c        |  121 ++---------------
 drivers/ata/pata_at32.c         |   44 ------
 drivers/ata/pata_atiixp.c       |   55 +------
 drivers/ata/pata_bf54x.c        |   37 -----
 drivers/ata/pata_cmd640.c       |   73 +++-------
 drivers/ata/pata_cmd64x.c       |  135 +++----------------
 drivers/ata/pata_cs5520.c       |   58 ++------
 drivers/ata/pata_cs5530.c       |   70 +++-------
 drivers/ata/pata_cs5535.c       |   50 -------
 drivers/ata/pata_cs5536.c       |   50 -------
 drivers/ata/pata_cypress.c      |   50 -------
 drivers/ata/pata_efar.c         |   64 ---------
 drivers/ata/pata_hpt366.c       |   81 ++++-------
 drivers/ata/pata_hpt37x.c       |  244 +++++++----------------------------
 drivers/ata/pata_hpt3x2n.c      |   81 ++---------
 drivers/ata/pata_hpt3x3.c       |   50 -------
 drivers/ata/pata_icside.c       |   59 +-------
 drivers/ata/pata_isapnp.c       |   37 -----
 drivers/ata/pata_it8213.c       |   65 +--------
 drivers/ata/pata_it821x.c       |   91 +++----------
 drivers/ata/pata_ixp4xx_cf.c    |   42 ------
 drivers/ata/pata_jmicron.c      |   65 ---------
 drivers/ata/pata_legacy.c       |  276 ++--------------------------------------
 drivers/ata/pata_marvell.c      |   67 ---------
 drivers/ata/pata_mpc52xx.c      |   42 ------
 drivers/ata/pata_mpiix.c        |   55 -------
 drivers/ata/pata_netcell.c      |   56 +-------
 drivers/ata/pata_ninja32.c      |   46 ------
 drivers/ata/pata_ns87410.c      |   60 --------
 drivers/ata/pata_ns87415.c      |   94 ++-----------
 drivers/ata/pata_oldpiix.c      |   66 +--------
 drivers/ata/pata_opti.c         |   64 ---------
 drivers/ata/pata_optidma.c      |  101 +-------------
 drivers/ata/pata_pcmcia.c       |   64 +--------
 drivers/ata/pata_pdc2027x.c     |   89 ------------
 drivers/ata/pata_pdc202xx_old.c |   92 ++-----------
 drivers/ata/pata_platform.c     |   44 ------
 drivers/ata/pata_qdi.c          |   63 ---------
 drivers/ata/pata_radisys.c      |   51 -------
 drivers/ata/pata_rz1000.c       |   49 -------
 drivers/ata/pata_sc1200.c       |   53 +------
 drivers/ata/pata_scc.c          |   36 -----
 drivers/ata/pata_serverworks.c  |  104 +++------------
 drivers/ata/pata_sil680.c       |   63 ++-------
 drivers/ata/pata_sis.c          |  244 +++++------------------------------
 drivers/ata/pata_sl82c105.c     |   63 +--------
 drivers/ata/pata_triflex.c      |   56 --------
 drivers/ata/pata_via.c          |  135 ++++---------------
 drivers/ata/pata_winbond.c      |   41 -----
 drivers/ata/pdc_adma.c          |   49 ++-----
 drivers/ata/sata_fsl.c          |   35 -----
 drivers/ata/sata_inic162x.c     |   44 +-----
 drivers/ata/sata_mv.c           |  119 ++---------------
 drivers/ata/sata_nv.c           |  196 ++++++----------------------
 drivers/ata/sata_promise.c      |   96 ++-----------
 drivers/ata/sata_qstor.c        |   46 ++----
 drivers/ata/sata_sil.c          |   36 -----
 drivers/ata/sata_sil24.c        |   58 +++-----
 drivers/ata/sata_sis.c          |   38 -----
 drivers/ata/sata_svw.c          |   33 ----
 drivers/ata/sata_sx4.c          |   17 --
 drivers/ata/sata_uli.c          |   43 ------
 drivers/ata/sata_via.c          |  112 +---------------
 drivers/ata/sata_vsc.c          |   34 ----
 drivers/pci/pci.c               |    3 
 drivers/scsi/ipr.c              |    3 
 include/linux/libata.h          |  222 +++++++++++++++++++++-----------
 77 files changed, 1204 insertions(+), 4929 deletions(-)

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/27447
[2] http://article.gmane.org/gmane.linux.ide/27781
[3] http://article.gmane.org/gmane.linux.ide/27782
