From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement new initialization model w/ iomap support, take 2
Date: Sat, 19 Aug 2006 17:57:04 +0900
Message-ID: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:53747 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWHSI5M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:57:12 -0400
Received: by py-out-1112.google.com with SMTP id n25so1464687pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:57:11 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of new-init-model patchset.  This patchset
implements new init model for libata LLDs.  Changes from the last
take[L] are...

* Adapted to drivers/ata relocation, SAS update and pending grand
  renaming.

* legacy / pci helpers made modular and lives in their own file
  libata-legacy.c and libata-pci.c respectively.

* IRQ helpers made modular.

* MSIX IRQ helpers added.

* Static legacy ports table removed as Alan pointed out.

Legacy handling is moularized into libata-legacy.c and PCI helpers use
the module.  If other bus helpers wanna use it, it just has to select
CONFIG_ATA_LEGACY and call helpers as PCI does.

Instead of subclassing ata_host and make ata_legacy_host and/or
ata_pci_host, I simply added two needed fields - legacy_flags and
pci_flags.  Rationale: that's all that's needed && with further
modularization, we'll probably need some form of multiple-inheritence
which can't be done with C-style wrapping-up subclassing.  IMHO,
waiting and seeing how things develop and updating basic data
structure organization accordingly is the way to go.  So, the minimal
approach on this patchset.

Now that it's merged after such a long wait, I really didn't want to
break SAS support and kept probe_ent and ata_port_init() for SAS
helpers, so there's a bit of duality there ATM.

Brian, can you please take a look at how LLDs use new init functions
and see if SAS can use the same approach?  If you pass NULL as @sht to
ata_host_alloc(), it won't associate ports as part of Scsi_Host just
as ata_sas_port_alloc() does and ata_host_free() will do the right
thing when freeing a host allocated that way.

sata_sil24.c is a pretty straight-forward example.  If you can't
determine the number of ports when allocating host, please take a look
at how ahci.c initializes its host.

The intention was to allow SAS to use all the regular init/deinit
functions just as other LLDs.  If something doesn't seem to be right,
please let me know.

Jeff, I privately did PATA support on sata_promise.c and it looks good
and works well (tested with PDC20375).  If this patchset gets ACKed,
I'll post that patch against sata_promise.c.

The new init model has the following benefits.

* Consistency across different LLDs

  Provide helpers such that common codes live in one place and init
  sequence doesn't have to be creative.

* Flexibility and easy code sharing with suspend/resume

  Instead of using probe_ent, allocate host_set and initialize it
  directly.  This removes many restrictions of probe_ent and allows
  LLDs to share init/remove codes with suspend/resume easily as they
  use the same target data structure.

  IRQ management is also moved out of libata-core into libata-pci
  helpers which LLDs can use or override at will.

* More bookkeeping in libata-core, less in LLDDs

  Acquired resources are tracked by libata-core and helpers.  e.g. LLD
  doesn't have to remember which resources it has acquired, it can
  simply tell libata to release all resources on error path and driver
  detachments.  This simplies LLDs and fixes several dangling resource
  and double-free bugs.

* Support for iomap

  As with all other PCI resources, both PIO and mmio areas are managed
  by libata PCI helpers.  iomaps are automatically created on IO
  resource acqusition and destroyed on release.  LLDs can simply
  request which BARs it intends to use.  The rest is handled by
  libata PCI helpers.

This patchset has been tested on

* ata_piix	: ICH7R, most combinations and w/ induced resource
		  allocation errors
* ahci		: ICH7R
* sata_sil	: sil3112, sil3114
* sata_sil24	: sil3124, sil3132
* sata_via	: vt6420 (via C3)
* pdc_adma	: as broken as previous
* sata_promise	: PDC20375, tested w/ PATA port too (PATA bits not
		  included in this post)

If you have any controller which use one of the following drivers,
please test and report.

* sata_svw
* sata_sx4
* sata_uli
* sata_vsc
* sata_sis
* sata_qstor
* sata_nv (I can do this later)
* sata_mv

If this patchset is agreed upon, I'll update #pata-drivers
accordingly.

This patchset is against

[U] upstream
[1] + grand-renaming patch
[2] + pci-quirks-CONFIG_ATA-fixup patch

This patchset is avaliable in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=new-init
  git://htj.dyndns.org/libata-tj new-init

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/12437
[U] 421b20b9c44b3fcdc07d6af875dad5ae86fad014
[1] http://htj.dyndns.org/git/?p=libata-tj.git;a=commit;h=a8e3784a8a479e3cf82a17cb25419b05f916d53f
[2] http://article.gmane.org/gmane.linux.ide/12733


