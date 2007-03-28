From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: libata-acpi: summary, problems, questions and proposal
Date: Wed, 28 Mar 2007 18:57:12 +0100
Message-ID: <20070328175712.GA10293@srcf.ucam.org>
References: <460A197A.9000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <460A197A.9000708@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Randy.Dunlap y" <rdunlap@xenotime.net>, trenn@suse.de, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, forrest.zhao@gmail.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 28, 2007 at 04:30:02PM +0900, Tejun Heo wrote:

Hi Tejun,

Firstly, could I ask you to take a look at the patch in 
http://permalink.gmane.org/gmane.linux.acpi.devel/22066/ ? It deals with 
some of these issues.

> ACPI support implementation in libata-dev supports both IDE and SATA
> ACPI object layouts and subset of ATA ACPI methods - _SDD and _GTF.
> It incorrectly uses ap->cbl (the port's cable type) to choose between
> the two ACPI layouts.  Association between the host and its ACPI
> object is performed every time ACPI methods are invoked but the
> association between an ATA device and its ACPI object is cached in
> ata_device object.

These issues are both fixed in my patch, I believe.

> 2-2. Missing proper _GTM/_STM support.  As stated above, although -mm
>     contains _GTM/_STM support, it does not hook it to regular
>     exception handling path and thus _GTF cannot be used in a lot of
>     cases.

I've added _GTM and _STM support over suspend/resume. Right now they're 
in the host power management code - I'm not sure whether they should be 
here or the SCSI glue layer?

> 2-3. Misplaced _GTF hook.  _GTF currently is called prior to every
>     device configuration.  This is unnecessary and incorrect.  The
>     ACPI spec specifies that _GTM/_STM and _GTF should be executed
>     during suspend/resume cycles not on every reset or
>     reconfiguration.  This, for example, causes the following
>     problem.

That should be quite easily fixable with the above patch.

> 4-1. Depending on how questions in section 3 are answered, fix and
>     clean up ATA host/device <-> ACPI object association.  Whether
>     IDE or SATA native style hierarchy is used should be determined
>     by driver flag not cable type.  e.g. ahci and sata_sil24 should
>     use SATA native style hierarchy while ata_piix should use IDE
>     hierarchy whether the port is SATA or PATA.

I think this is just a matter of making sure that the sata and pata 
handle matching code matches reality now :)

> 4-2. Only associate once during initialization.  There is no reason to
>     try to associate hosts and devices with ACPI objects at each try.
>     Do it once during host initialization and use it if available or
>     forget about ACPI if not available.

Fixed.

> 4-3. Integrate _GTM/_STM support and invoke methods only when the spec
>     specifies to.  For IDE object, do _GTM during suspend and _STM
>     followed by _GTF during resume.  There is no reason to call them
>     anytime else.  For SATA native object, do _SDD followed by _GTF
>     after every hardreset.

Patrially fixed.

> 4-4. Implement helpers for cable detection using _GTM/_STM and use it
>     in sata_nv if CK804.  This is to substitute independent pata_acpi
>     driver.  Low level driver should know when _GTM/_STM should be
>     used for cable detection and/or device programming and doing it
>     this way reduces user confusion (sata_nv also supports ck804 but
>     you probably need to load pata_acpi if ACPI is available) and
>     allows better integration with the rest of the low level driver
>     (e.g. ADMA mode + _GTM/_STM cable detection).

Not done.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
