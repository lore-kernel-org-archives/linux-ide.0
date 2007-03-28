From: Tejun Heo <htejun@gmail.com>
Subject: libata-acpi: summary, problems, questions and proposal
Date: Wed, 28 Mar 2007 16:30:02 +0900
Message-ID: <460A197A.9000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "\"Randy.Dunlap\" y" <rdunlap@xenotime.net>, trenn@suse.de, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, forrest.zhao@gmail.com, mjg59@srcf.ucam.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, ATA and ACPI crowd.

This mail tries to summarize the current state of libata ACPI support
and establish consensus how it should be improved.  If you're familiar
with ACPI or the current libata-acpi implementation, please try to
answer questions in section 3.

Table of Contents

  1. Summary of the current libata ACPI support
  2. Problems of the current implementation
  3. Questions regarding ATA ACPI spec and the current implementation
  4. Proposal for improvements


1. Summary of the current libata ACPI support

Currently there are two branches of acpi support.  One in git tree
libata-dev (also merged into mainline) the other in -mm tree.  The one
in -mm tree contains additional _GTM/_STM support and pata_acpi.c
implementation by Alan Cox.  The additional part currently only in the
-mm tree is necessary and needs to be merged but there is a
disagreement regarding how pata_acpi should be done.

ACPI support implementation in libata-dev supports both IDE and SATA
ACPI object layouts and subset of ATA ACPI methods - _SDD and _GTF.
It incorrectly uses ap->cbl (the port's cable type) to choose between
the two ACPI layouts.  Association between the host and its ACPI
object is performed every time ACPI methods are invoked but the
association between an ATA device and its ACPI object is cached in
ata_device object.

If ap->cbl indicates SATA cable type, _SDD is invoked every time the
associated ATA device is configured (after reset and during
revalidation).  Also, _GTF and the resulting TFs are executed right
after each _SDD.

If ap->cbl does not indicate SATA cable type, ACPI support in
libata-dev currently doesn't do anything because in some cases _GTF
depends on _STM being called before it and executing _GTF before _STM
causes errors in ACPI layer.  As _GTM/_STM support in -mm is only used
with pata_acpi yet, the situation is similar there too.  Nothing is
done if cable type isn't SATA.


2. Problems of the current implementation

2-1. Associating ATA host/device with their ACPI objects is broken.
     For one, it uses ap->cbl to determine which layout to use but
     this isn't dependent on cable type.  This is dependent on the
     programming interface of the controller.  If it implements or
     emulates SFF IDE interface, the IDE ACPI layout should be used.
     If the controller implements its own native SATA aware
     programming interface such as ahci or sil24, it should use SATA
     native layout.

2-2. Missing proper _GTM/_STM support.  As stated above, although -mm
     contains _GTM/_STM support, it does not hook it to regular
     exception handling path and thus _GTF cannot be used in a lot of
     cases.

2-3. Misplaced _GTF hook.  _GTF currently is called prior to every
     device configuration.  This is unnecessary and incorrect.  The
     ACPI spec specifies that _GTM/_STM and _GTF should be executed
     during suspend/resume cycles not on every reset or
     reconfiguration.  This, for example, causes the following
     problem.

     _STM should be called before _GTF and, in turn, _GTF should be
     called before _STM, so, during initial detection, we should be
     doing _GTM -> _STM -> _GTF sequence.


3. Questions regarding ATA ACPI spec and the current implementation

Please feel free to point out errors and it would be great if you can
include or point to example .dat/.dsl files when answering.

3-1. In all ACPI specs form 1.0 to 3.0a, the example IDE hierarchy
     looks like the following.

     \_SB\PCI0\IDE1\{_ADR,_GTM,_STM,_PR0}
                   \DRV1\{_ADR,_GTF}
                   \DRV2\{_ADR,_GTF}
              \IDE2\{_ADR,_GTM,_STM,_PR0}
                   \DRV1\{_ADR,_GTF}
                   \DRV2\{_ADR,_GTF}

     Where the description of IDEx\_ADR is "Indicates address of the
     channel on the PCI bus".  But actual IDE ACPI hierarchy looks
     like the following.

     \_SB\PCI0\PCIDEVX\_ADR
                      \IDE1\{_ADR,_GTM,_STM,_PR0}
                           \DRV1\{_ADR,_GTF}
                           \DRV2\{_ADR,_GTF}
                      \IDE2\{_ADR,_GTM,_STM,_PR0}
                           \DRV1\{_ADR,_GTF}
                           \DRV2\{_ADR,_GTF}

     Where PCIDEVX\_ADR indicates the address of PCI device on the PCI
     bus while IDEx\_ADR indicates the channel number on the PCI
     device not the PCI bus.  Is this a mistake in the spec or am I
     misreading it?

3-2. sata_get_dev_handle() looks for the ACPI object associated with
     the PCI host of the given ATA host by matching the PCI device's
     _ADR in the containing PCI bus, but pata_get_dev_handle() gets
     the ACPI device handle for the PCI device by simply invoking
     DEVICE_ACPI_HANDLE() on the generic device for the host device
     and verifies the ACPI object for the containing bus has the
     matching bus number in its _ADR.

     a. Why can't we just use DEVICE_ACPI_HANDLE() on host->dev in
        SATA case?  What's the difference between IDE and SATA ACPI
        objects?  AFAICS, they are the same PCI device object.

     b. In IDE case, why verify the parent object has matching BUS ID?
        When can it have mismatching one?  That means
        DEVICE_ACPI_HANDLE() may return the wrong acpi_handle for the
        given device.  Shouldn't we be fixing DEVICE_ACPI_HANDLE()
        instead?  Or is IDE ACPI object somehow special?

3-3. When associating an ata_device with its ACPI counterpart, IDE and
     SATA do things differently.  If IDE, it first looks for the ACPI
     object representing the channel under the ACPI object for the
     host by matching _ADR against the port number.  If the channel
     object is found, ACPI object with matching drive number in _ADR
     is looked up under the ACPI object.  This object is the ACPI
     object for the ATA device.

     For SATA, depth first walk is performed below the ACPI object
     representing the host.  Each object under the host object is
     examined for matching _ADR.

     Why can't we just look for matching _ADR below the ACPI object
     for the host PCI device?  The SATA hierarchy has been introduced
     only in ACPI3.0 and I don't see any reason why the recursive walk
     should be done in either 3.0 or 3.0a.  Any special reason?


4. Proposal for improvements

4-1. Depending on how questions in section 3 are answered, fix and
     clean up ATA host/device <-> ACPI object association.  Whether
     IDE or SATA native style hierarchy is used should be determined
     by driver flag not cable type.  e.g. ahci and sata_sil24 should
     use SATA native style hierarchy while ata_piix should use IDE
     hierarchy whether the port is SATA or PATA.

     On controllers which support both modes are supported (many
     BIOSen allow switching between ata_piix and ahci modes), it isn't
     very clear because in many such cases ACPI tree doesn't change
     depending on configuration.  ie. you get the same IDE hierarchy
     whether you're in ata_piix mode or ahci mode.

     We can try to fall back mechanism but that isn't gonna cover all
     cases either - e.g. in ICH8, the same ports use one PCI function
     in AHCI mode while splits into two functions in ata_piix mode.
     It can also be dangerous as IDE _STM/_GTM might touch disabled
     IDE registers when the controller is in AHCI mode.  So, IMHO, we
     shouldn't bother.  Most notebooks BIOSen which implement ATA
     password protection seem to limit the controller into one
     specific mode anyway.

4-2. Only associate once during initialization.  There is no reason to
     try to associate hosts and devices with ACPI objects at each try.
     Do it once during host initialization and use it if available or
     forget about ACPI if not available.

4-3. Integrate _GTM/_STM support and invoke methods only when the spec
     specifies to.  For IDE object, do _GTM during suspend and _STM
     followed by _GTF during resume.  There is no reason to call them
     anytime else.  For SATA native object, do _SDD followed by _GTF
     after every hardreset.

4-4. Implement helpers for cable detection using _GTM/_STM and use it
     in sata_nv if CK804.  This is to substitute independent pata_acpi
     driver.  Low level driver should know when _GTM/_STM should be
     used for cable detection and/or device programming and doing it
     this way reduces user confusion (sata_nv also supports ck804 but
     you probably need to load pata_acpi if ACPI is available) and
     allows better integration with the rest of the low level driver
     (e.g. ADMA mode + _GTM/_STM cable detection).

For 4-3 and 4-4, most code is already there in -mm tree.  Shamelessly
stealing and reorganizing Alan's code should do it.  :-)

Thanks.

--
tejun
