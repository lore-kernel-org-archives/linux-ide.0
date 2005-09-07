From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] ATA/ATAPI exceptions doc
Date: Wed, 07 Sep 2005 04:02:51 -0400
Message-ID: <431E9EAB.40108@pobox.com>
References: <20050827053521.GA13742@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:23276 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932075AbVIGIDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 04:03:01 -0400
In-Reply-To: <20050827053521.GA13742@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, ATA people.
> 
>  This is the first section of libata EH doc.  This section tries to
> describe ATA/ATAPI errors and exceptions in driver-neutral way and is
> intended to be used as reference when implementing new libata EH.
> 
>  The second section will be about current libata EH implementation and
> the last will be how to implement new libata EH.
> 
>  Thanks.
> 
> libata EH
> ======================================
> 
>  This document first discusses what ATA/ATAPI error conditions exist
> and how they should be handled.  Then, we move on to how libata
> currently handles them and how it can be improved.  Where 'current'
> represents ALL head of libata-dev-2.6 git tree as of 2005-08-26,
> commit ab9b494f6aeab24eda2e6462e2fe73789c288e73.  References are made
> to SCSI EH document.  Please read SCSI EH document first.
> 
>  A lot of EH ideas are from Jeff Garzik and others in the following
> and other discussion threads on linux-ide.
> 
>  http://marc.theaimsgroup.com/?l=linux-ide&m=112451335416913&w=2
> 
> 
> [1] ATA/ATAPI errors and exceptions
> 
>  This section tries to identify what error/exception conditions exist
> for ATA/ATAPI devices and describe how they should be handled in
> implementation-neutral way.
> 
>  The term 'error' is used to describe conditions where either an
> explicit error condition is reported from device or a command has
> timed out.
> 
>  The term 'exception' is either used to describe exceptional
> conditions which are not errors (say, power or hotplug events), or to
> describe both errors and non-error exceptional conditions.  Where
> explicit distinction between error and exception is necessary, the
> term 'non-error exception' is used.
> 
>  The following categories of exceptions exist for ATA/ATAPI devices.
> 
>  - HSM violation error
>  - ATA command error (non-NCQ)
>  - ATA command timeout (non-NCQ)
>  - ATAPI command error
>  - ATAPI command timeout
>  - NCQ command error
>  - NCQ command timeout
>  - other errors
>  - non-error exceptions


I would list the categories in this way:

- HSM violation, if driver or hardware is out of spec
- ATA/ATAPI device error (device populates Error register, or ABRT)
- ATAPI device check condition error
- ATA device error, during NCQ operations
- ATA bus error (usually indicated via command timeout, but some
   hardware includes error register bits specifically for these
   conditions)
	* includes DMA errors
	* includes SATA PHY errors
- PCI bus error (or whatever bus your host<->device path uses)
- Late successful completion.  Indicated via command timeout, where a
   final check of the hardware indicates the command actually did
   complete successfully.
- Unknown error.  Indicated via command timeout, where one cannot
   discern why the command timed out.
- Hotplug and power management exceptions.




> [1-1-2] ATA command error (non-NCQ)
> 
>  This error is indicated by set ERR bit on ATA command completion.
> STATUS and ERROR registers indicate what kind of error has occurred.
> Interpretation of STATUS and ERROR may differ depending on command.
> 
>  This type of errors can be further categorized.
> 
>  a. CRC error during transmission
> 
>     This is indicated by ICRC bit in the ERROR register.  Reset is not
>     necessary as HSM is not violated but reconfiguring transport speed
>     would help.

note this is a "bus" not "device" error


>  b. Media errors
> 
>     This is indicated by UNC bit in the ERROR register.  ATA devices
>     reports UNC error only after certain number of retries cannot
>     recover the data, so there's nothing much else to do other than
>     notifying upper layer.  Note that READ and WRITE commands report
>     CHS or LBA of the first failed sector.  This could be used to
>     complete successfully sectors in the request preceding the address
>     although it's doubtful if it would actually help.

Long term, yes, we should use available ATA information to partially 
complete the SCSI request, up to the point where the data transfer failed.


>  c. Media changed / media change requested error
> 
>     Is there any SATA device with removable media?

compact flash and cdrom


>  d. Other errors
> 
>     This can be invalid command or parameter indicated by ABRT ERROR
>     bit or some other error condition.  Report to upper layer.
> 
> *TODO* Describe how STATUS and ERROR bits can be mapped to error
>        categories.
> 
> *QUESTION* Do we have to ignore command-specific 'not applicable' bits
>            when interpreting register values?

Not sure how to answer this.  Which register values?  What is the entity 
doing the interpreting?


> [1-1-3] ATA command timeout (non-NCQ)
> 
>  ATA command timeout occurs if a ATA command fails to complete in some
> specified time.  When timeout occurs, HSM could be in any valid or
> invalid state.  To bring the device to known state and make it forget
> about the command, resetting is necessary.  The timed out command can
> be retried.
> 
>  Timeouts can also be caused by transmission errors.  Reconfiguring
> transport might help.

Note that, by design, when a DMA error occurs some hardware will simply 
not send an interrupt.  They rely on the OS driver to notice the lack of 
response, and from there, read the hardware registers to determine if a 
DMA error occured.


> [1-2] EH recovery actions
> 
>  This section discusses two important recovery actions mentioned
> previously - resetting device/HBA and reconfiguring transport speed.
> 
> 
> [1-2-1] Reset
> 
>  During EH, resetting is necessary in the following cases.
> 
>  - HSM is in unknown or invalid state
>  - HBA is in unknown or invalid state
>  - EH needs to make HBA/device forget about in-flight commands
>  - HBA/device behaves weirdly.
> 
>  Resetting during EH might be a good idea regardless of error
> condition to improve EH robustness.

Note that a lot of vendor driver interrupt handlers do the following, 
after processing an interrupt:

	tmp = read(SError)
	write(tmp, SError)

At the very least we should do that on error.


>  HBA resetting is implementation specific and even controllers
> complying to taskfile/BMDMA PCI IDE interface are likely to have
> implementation-specific ways to reset whole HBA.  So, this probably
> should be addressed by specific drivers.

s/should/must/

Although for PATA controllers, sometimes the best you can do is SRST, 
which implies that specific drivers can use a common reset facility.


>  OTOH, ATA/ATAPI standard describes in detail ways to reset ATA/ATAPI
> devices.
> 
>  a. PATA hardware reset
> 
>     This is hardware initiated device reset signalled with asserted
>     RESET- signal.  In PATA, there is no way to initiate hardware
>     reset from software.

Some PATA hardware provides registers that allow the OS driver to 
directly tweak the RESET- signal.


>  b. Software reset
> 
>     This is achieved by turning CONTROL SRST bit on for at least 5us.
>     Both PATA and SATA support it but, in case of SATA, this may
>     require controller-specific support as the second Register FIS to
>     clear FIS should be transmitted while BSY bit is still set.  Note
>     that on PATA, this resets both master and slave devices on a
>     channel.

ditto for EXECUTE DEVICE DIAGNOSTIC


>  c. ATAPI DEVICE RESET command
> 
>     This is very similar to software reset except that reset can be
>     restricted to the selected device without affecting the other
>     device sharing the cable.
> 
>  d. SATA phy reset
> 
>     This is the preferred way of resetting a SATA device.  In effect
>     it's identical to PATA hardware reset.  Note that this can be done
>     with the standard SCR Control register.  As such, it's usually
>     easier to implement than software reset too.
> 
>  Although above reset methods are standard, different HBA
> implementations may have different requirements for resetting devices.
> For standard BMDMA implementation, BMDMA state is the only context and
> stopping active DMA transaction suffices.  For other types of HBAs,
> there are different requirements to put them in consistent state.

I would definitely do an SRST after a DMA error.


>  One more thing to consider when resetting devices is that resetting
> clears certain configuration parameters and they need to be set to
> their previous or newly adjusted values after reset.

Yep.  Same problem coming back from power-off (resume).


>  Parameters affected are.
> 
>  - CHS set up with INITIALIZE DEVICE PARAMETERS (seldomly used)
>  - Parameters set with SET FEATURES including transfer mode setting.
>  - Block count set with SET MULTIPLE MODE
>  - Other parameters (SET MAX, MEDIA LOCK...)
> 
>  ATA/ATAPI standard specifies that some parameters should be kept
> across hardware reset or software reset, but doesn't strictly specify
> all of them.  IMHO, always reconfiguring needed parameters after reset
> would be a good idea for robustness.

s/good idea/required/ :)


>  Also, ATA/ATAPI standard requires that IDENTIFY DEVICE / IDENTIFY
> PACKET DEVICE is issued after a hardware reset and the result is used
> for further operation.  *QUESTION* Would this be necessary?  If so,
> revalidation mechanism needs to be implemented.

Any time features are turned on/off, etc., the identify-device page 
should be re-read.

	Jeff


