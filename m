From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev:upstream] libata: add ATA exceptions chapter to doc
Date: Sun, 2 Oct 2005 11:54:29 +0900
Message-ID: <20051002025429.GA15140@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:30774 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750933AbVJBCyj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Oct 2005 22:54:39 -0400
Received: by zproxy.gmail.com with SMTP id 13so137063nzn
        for <linux-ide@vger.kernel.org>; Sat, 01 Oct 2005 19:54:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

 Hello, Jeff.

 This patch adds ATA errors & exceptions chapter to
Documentation/DocBook/libata.tmpl.  As suggested, the chapter is
placed before low level driver specific chapters.  Contents are
unchanged from the last posting.

 Thanks.

P.S.: (being persistent...) eh doc review please :-)

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -787,6 +787,722 @@ and other resources, etc.
 !Idrivers/scsi/libata-scsi.c
   </chapter>
 
+  <chapter id="ataExceptions">
+     <title>ATA errors &amp; exceptions</title>
+
+  <para>
+  This chapter tries to identify what error/exception conditions exist
+  for ATA/ATAPI devices and describe how they should be handled in
+  implementation-neutral way.
+  </para>
+
+  <para>
+  The term 'error' is used to describe conditions where either an
+  explicit error condition is reported from device or a command has
+  timed out.
+  </para>
+
+  <para>
+  The term 'exception' is either used to describe exceptional
+  conditions which are not errors (say, power or hotplug events), or
+  to describe both errors and non-error exceptional conditions.  Where
+  explicit distinction between error and exception is necessary, the
+  term 'non-error exception' is used.
+  </para>
+
+  <sect1 id="excat">
+     <title>Exception categories</title>
+     <para>
+     Exceptions are described primarily with respect to legacy
+     taskfile + bus master IDE interface.  If a controller provides
+     other better mechanism for error reporting, mapping those into
+     categories described below shouldn't be difficult.
+     </para>
+
+     <para>
+     In the following sections, two recovery actions - reset and
+     reconfiguring transport - are mentioned.  These are described
+     further in <xref linkend="exrec"/>.
+     </para>
+
+     <sect2 id="excatHSMviolation">
+        <title>HSM violation</title>
+        <para>
+        This error is indicated when STATUS value doesn't match HSM
+        requirement during issuing or excution any ATA/ATAPI command.
+        </para>
+
+	<itemizedlist>
+	<title>Examples</title>
+
+        <listitem>
+	<para>
+	ATA_STATUS doesn't contain !BSY &amp;&amp; DRDY &amp;&amp; !DRQ while trying
+	to issue a command.
+        </para>
+	</listitem>
+
+        <listitem>
+	<para>
+	!BSY &amp;&amp; !DRQ during PIO data transfer.
+        </para>
+	</listitem>
+
+        <listitem>
+	<para>
+	DRQ on command completion.
+        </para>
+	</listitem>
+
+        <listitem>
+	<para>
+	!BSY &amp;&amp; ERR after CDB tranfer starts but before the
+        last byte of CDB is transferred.  ATA/ATAPI standard states
+        that &quot;The device shall not terminate the PACKET command
+        with an error before the last byte of the command packet has
+        been written&quot; in the error outputs description of PACKET
+        command and the state diagram doesn't include such
+        transitions.
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	In these cases, HSM is violated and not much information
+	regarding the error can be acquired from STATUS or ERROR
+	register.  IOW, this error can be anything - driver bug,
+	faulty device, controller and/or cable.
+	</para>
+
+	<para>
+	As HSM is violated, reset is necessary to restore known state.
+	Reconfiguring transport for lower speed might be helpful too
+	as transmission errors sometimes cause this kind of errors.
+	</para>
+     </sect2>
+     
+     <sect2 id="excatDevErr">
+        <title>ATA/ATAPI device error (non-NCQ / non-CHECK CONDITION)</title>
+
+	<para>
+	These are errors detected and reported by ATA/ATAPI devices
+	indicating device problems.  For this type of errors, STATUS
+	and ERROR register values are valid and describe error
+	condition.  Note that some of ATA bus errors are detected by
+	ATA/ATAPI devices and reported using the same mechanism as
+	device errors.  Those cases are described later in this
+	section.
+	</para>
+
+	<para>
+	For ATA commands, this type of errors are indicated by !BSY
+	&amp;&amp; ERR during command execution and on completion.
+	</para>
+
+	<para>For ATAPI commands,</para>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	!BSY &amp;&amp; ERR &amp;&amp; ABRT right after issuing PACKET
+	indicates that PACKET command is not supported and falls in
+	this category.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	!BSY &amp;&amp; ERR(==CHK) &amp;&amp; !ABRT after the last
+	byte of CDB is transferred indicates CHECK CONDITION and
+	doesn't fall in this category.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	!BSY &amp;&amp; ERR(==CHK) &amp;&amp; ABRT after the last byte
+        of CDB is transferred *probably* indicates CHECK CONDITION and
+        doesn't fall in this category.
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	Of errors detected as above, the followings are not ATA/ATAPI
+	device errors but ATA bus errors and should be handled
+	according to <xref linkend="excatATAbusErr"/>.
+	</para>
+
+	<variablelist>
+
+	   <varlistentry>
+	   <term>CRC error during data transfer</term>
+	   <listitem>
+	   <para>
+	   This is indicated by ICRC bit in the ERROR register and
+	   means that corruption occurred during data transfer.  Upto
+	   ATA/ATAPI-7, the standard specifies that this bit is only
+	   applicable to UDMA transfers but ATA/ATAPI-8 draft revision
+	   1f says that the bit may be applicable to multiword DMA and
+	   PIO.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry>
+	   <term>ABRT error during data transfer or on completion</term>
+	   <listitem>
+	   <para>
+	   Upto ATA/ATAPI-7, the standard specifies that ABRT could be
+	   set on ICRC errors and on cases where a device is not able
+	   to complete a command.  Combined with the fact that MWDMA
+	   and PIO transfer errors aren't allowed to use ICRC bit upto
+	   ATA/ATAPI-7, it seems to imply that ABRT bit alone could
+	   indicate tranfer errors.
+	   </para>
+	   <para>
+	   However, ATA/ATAPI-8 draft revision 1f removes the part
+	   that ICRC errors can turn on ABRT.  So, this is kind of
+	   gray area.  Some heuristics are needed here.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	</variablelist>
+
+	<para>
+	ATA/ATAPI device errors can be further categorized as follows.
+	</para>
+
+	<variablelist>
+
+	   <varlistentry>
+	   <term>Media errors</term>
+	   <listitem>
+	   <para>
+	   This is indicated by UNC bit in the ERROR register.  ATA
+	   devices reports UNC error only after certain number of
+	   retries cannot recover the data, so there's nothing much
+	   else to do other than notifying upper layer.
+	   </para>
+	   <para>
+	   READ and WRITE commands report CHS or LBA of the first
+	   failed sector but ATA/ATAPI standard specifies that the
+	   amount of transferred data on error completion is
+	   indeterminate, so we cannot assume that sectors preceding
+	   the failed sector have been transferred and thus cannot
+	   complete those sectors successfully as SCSI does.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry>
+	   <term>Media changed / media change requested error</term>
+	   <listitem>
+	   <para>
+	   &lt;&lt;TODO: fill here&gt;&gt;
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>Address error</term>
+	   <listitem>
+	   <para>
+	   This is indicated by IDNF bit in the ERROR register.
+	   Report to upper layer.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>Other errors</term>
+	   <listitem>
+	   <para>
+	   This can be invalid command or parameter indicated by ABRT
+	   ERROR bit or some other error condition.  Note that ABRT
+	   bit can indicate a lot of things including ICRC and Address
+	   errors.  Heuristics needed.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	</variablelist>
+
+	<para>
+	Depending on commands, not all STATUS/ERROR bits are
+	applicable.  These non-applicable bits are marked with
+	&quot;na&quot; in the output descriptions but upto ATA/ATAPI-7
+	no definition of &quot;na&quot; can be found.  However,
+	ATA/ATAPI-8 draft revision 1f describes &quot;N/A&quot; as
+	follows.
+	</para>
+
+	<blockquote>
+	<variablelist>
+	   <varlistentry><term>3.2.3.3a N/A</term>
+	   <listitem>
+	   <para>
+	   A keyword the indicates a field has no defined value in
+	   this standard and should not be checked by the host or
+	   device. N/A fields should be cleared to zero.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+	</variablelist>
+	</blockquote>
+
+	<para>
+	So, it seems reasonable to assume that &quot;na&quot; bits are
+	cleared to zero by devices and thus need no explicit masking.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatATAPIcc">
+        <title>ATAPI device CHECK CONDITION</title>
+
+	<para>
+	ATAPI device CHECK CONDITION error is indicated by set CHK bit
+	(ERR bit) in the STATUS register after the last byte of CDB is
+	transferred for a PACKET command.  For this kind of errors,
+	sense data should be acquired to gather information regarding
+	the errors.  REQUEST SENSE packet command should be used to
+	acquire sense data.
+	</para>
+
+	<para>
+	Once sense data is acquired, this type of errors can be
+	handled similary to other SCSI errors.  Note that sense data
+	may indicate ATA bus error (e.g. Sense Key 04h HARDWARE ERROR
+	&amp;&amp; ASC/ASCQ 47h/00h SCSI PARITY ERROR).  In such
+	cases, the error should be considered as an ATA bus error and
+	handled according to <xref linkend="excatATAbusErr"/>.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatNCQerr">
+        <title>ATA device error (NCQ)</title>
+
+	<para>
+	NCQ command error is indicated by cleared BSY and set ERR bit
+	during NCQ command phase (one or more NCQ commands
+	outstanding).  Although STATUS and ERROR registers will
+	contain valid values describing the error, READ LOG EXT is
+	required to clear the error condition, determine which command
+	has failed and acquire more information.
+	</para>
+
+	<para>
+	READ LOG EXT Log Page 10h reports which tag has failed and
+	taskfile register values describing the error.  With this
+	information the failed command can be handled as a normal ATA
+	command error as in <xref linkend="excatDevErr"/> and all
+	other in-flight commands must be retried.  Note that this
+	retry should not be counted - it's likely that commands
+	retried this way would have completed normally if it were not
+	for the failed command.
+	</para>
+
+	<para>
+	Note that ATA bus errors can be reported as ATA device NCQ
+	errors.  This should be handled as described in <xref
+	linkend="excatATAbusErr"/>.
+	</para>
+
+	<para>
+	If READ LOG EXT Log Page 10h fails or reports NQ, we're
+	thoroughly screwed.  This condition should be treated
+	according to <xref linkend="excatHSMviolation"/>.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatATAbusErr">
+        <title>ATA bus error</title>
+
+	<para>
+	ATA bus error means that data corruption occurred during
+	transmission over ATA bus (SATA or PATA).  This type of errors
+	can be indicated by
+	</para>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	ICRC or ABRT error as described in <xref linkend="excatDevErr"/>.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Controller-specific error completion with error information
+	indicating transmission error.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	On some controllers, command timeout.  In this case, there may
+	be a mechanism to determine that the timeout is due to
+	transmission error.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Unknown/random errors, timeouts and all sorts of weirdities.
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	As described above, transmission errors can cause wide variety
+	of symptoms ranging from device ICRC error to random device
+	lockup, and, for many cases, there is no way to tell if an
+	error condition is due to transmission error or not;
+	therefore, it's necessary to employ some kind of heuristic
+	when dealing with errors and timeouts.  For example,
+	encountering repetitive ABRT errors for known supported
+	command is likely to indicate ATA bus error.
+	</para>
+
+	<para>
+	Once it's determined that ATA bus errors have possibly
+	occurred, lowering ATA bus transmission speed is one of
+	actions which may alleviate the problem.  See <xref
+	linkend="exrecReconf"/> for more information.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatPCIbusErr">
+        <title>PCI bus error</title>
+
+	<para>
+	Data corruption or other failures during transmission over PCI
+	(or other system bus).  For standard BMDMA, this is indicated
+	by Error bit in the BMDMA Status register.  This type of
+	errors must be logged as it indicates something is very wrong
+	with the system.  Resetting host controller is recommended.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatLateCompletion">
+        <title>Late completion</title>
+
+	<para>
+	This occurs when timeout occurs and the timeout handler finds
+	out that the timed out command has completed successfully or
+	with error.  This is usually caused by lost interrupts.  This
+	type of errors must be logged.  Resetting host controller is
+	recommended.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatUnknown">
+        <title>Unknown error (timeout)</title>
+
+	<para>
+	This is when timeout occurs and the command is still
+	processing or the host and device are in unknown state.  When
+	this occurs, HSM could be in any valid or invalid state.  To
+	bring the device to known state and make it forget about the
+	timed out command, resetting is necessary.  The timed out
+	command may be retried.
+	</para>
+
+	<para>
+	Timeouts can also be caused by transmission errors.  Refer to
+	<xref linkend="excatATAbusErr"/> for more details.
+	</para>
+
+     </sect2>
+
+     <sect2 id="excatHoplugPM">
+        <title>Hotplug and power management exceptions</title>
+
+	<para>
+	&lt;&lt;TODO: fill here&gt;&gt;
+	</para>
+
+     </sect2>
+
+  </sect1>
+
+  <sect1 id="exrec">
+     <title>EH recovery actions</title>
+
+     <para>
+     This section discusses several important recovery actions.
+     </para>
+
+     <sect2 id="exrecClr">
+        <title>Clearing error condition</title>
+
+	<para>
+	Many controllers require its error registers to be cleared by
+	error handler.  Different controllers may have different
+	requirements.
+	</para>
+
+	<para>
+	For SATA, it's strongly recommended to clear at least SError
+	register during error handling.
+	</para>
+     </sect2>
+
+     <sect2 id="exrecRst">
+        <title>Reset</title>
+
+	<para>
+	During EH, resetting is necessary in the following cases.
+	</para>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	HSM is in unknown or invalid state
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	HBA is in unknown or invalid state
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	EH needs to make HBA/device forget about in-flight commands
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	HBA/device behaves weirdly
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	Resetting during EH might be a good idea regardless of error
+	condition to improve EH robustness.  Whether to reset both or
+	either one of HBA and device depends on situation but the
+	following scheme is recommended.
+	</para>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	When it's known that HBA is in ready state but ATA/ATAPI
+	device in in unknown state, reset only device.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	If HBA is in unknown state, reset both HBA and device.
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	HBA resetting is implementation specific.  For a controller
+	complying to taskfile/BMDMA PCI IDE, stopping active DMA
+	transaction may be sufficient iff BMDMA state is the only HBA
+	context.  But even mostly taskfile/BMDMA PCI IDE complying
+	controllers may have implementation specific requirements and
+	mechanism to reset themselves.  This must be addressed by
+	specific drivers.
+	</para>
+
+	<para>
+	OTOH, ATA/ATAPI standard describes in detail ways to reset
+	ATA/ATAPI devices.
+	</para>
+
+	<variablelist>
+
+	   <varlistentry><term>PATA hardware reset</term>
+	   <listitem>
+	   <para>
+	   This is hardware initiated device reset signalled with
+	   asserted PATA RESET- signal.  There is no standard way to
+	   initiate hardware reset from software although some
+	   hardware provides registers that allow driver to directly
+	   tweak the RESET- signal.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>Software reset</term>
+	   <listitem>
+	   <para>
+	   This is achieved by turning CONTROL SRST bit on for at
+	   least 5us.  Both PATA and SATA support it but, in case of
+	   SATA, this may require controller-specific support as the
+	   second Register FIS to clear SRST should be transmitted
+	   while BSY bit is still set.  Note that on PATA, this resets
+	   both master and slave devices on a channel.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>EXECUTE DEVICE DIAGNOSTIC command</term>
+	   <listitem>
+	   <para>
+	   Although ATA/ATAPI standard doesn't describe exactly, EDD
+	   implies some level of resetting, possibly similar level
+	   with software reset.  Host-side EDD protocol can be handled
+	   with normal command processing and most SATA controllers
+	   should be able to handle EDD's just like other commands.
+	   As in software reset, EDD affects both devices on a PATA
+	   bus.
+	   </para>
+	   <para>
+	   Although EDD does reset devices, this doesn't suit error
+	   handling as EDD cannot be issued while BSY is set and it's
+	   unclear how it will act when device is in unknown/weird
+	   state.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>ATAPI DEVICE RESET command</term>
+	   <listitem>
+	   <para>
+	   This is very similar to software reset except that reset
+	   can be restricted to the selected device without affecting
+	   the other device sharing the cable.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>SATA phy reset</term>
+	   <listitem>
+	   <para>
+	   This is the preferred way of resetting a SATA device.  In
+	   effect, it's identical to PATA hardware reset.  Note that
+	   this can be done with the standard SCR Control register.
+	   As such, it's usually easier to implement than software
+	   reset.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	</variablelist>
+
+	<para>
+	One more thing to consider when resetting devices is that
+	resetting clears certain configuration parameters and they
+	need to be set to their previous or newly adjusted values
+	after reset.
+	</para>
+
+	<para>
+	Parameters affected are.
+	</para>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	CHS set up with INITIALIZE DEVICE PARAMETERS (seldomly used)
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Parameters set with SET FEATURES including transfer mode setting
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Block count set with SET MULTIPLE MODE
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Other parameters (SET MAX, MEDIA LOCK...)
+	</para>
+	</listitem>
+
+	</itemizedlist>
+
+	<para>
+	ATA/ATAPI standard specifies that some parameters must be
+	maintained across hardware or software reset, but doesn't
+	strictly specify all of them.  Always reconfiguring needed
+	parameters after reset is required for robustness.  Note that
+	this also applies when resuming from deep sleep (power-off).
+	</para>
+
+	<para>
+	Also, ATA/ATAPI standard requires that IDENTIFY DEVICE /
+	IDENTIFY PACKET DEVICE is issued after any configuration
+	parameter is updated or a hardware reset and the result used
+	for further operation.  OS driver is required to implement
+	revalidation mechanism to support this.
+	</para>
+
+     </sect2>
+
+     <sect2 id="exrecReconf">
+        <title>Reconfigure transport</title>
+
+	<para>
+	For both PATA and SATA, a lot of corners are cut for cheap
+	connectors, cables or controllers and it's quite common to see
+	high transmission error rate.  This can be mitigated by
+	lowering transmission speed.
+	</para>
+
+	<para>
+	The following is a possible scheme Jeff Garzik suggested.
+	</para>
+
+	<blockquote>
+	<para>
+	If more than $N (3?) transmission errors happen in 15 minutes,
+	</para>	
+	<itemizedlist>
+	<listitem>
+	<para>
+	if SATA, decrease SATA PHY speed.  if speed cannot be decreased,
+	</para>
+	</listitem>
+	<listitem>
+	<para>
+	decrease UDMA xfer speed.  if at UDMA0, switch to PIO4,
+	</para>
+	</listitem>
+	<listitem>
+	<para>
+	decrease PIO xfer speed.  if at PIO3, complain, but continue
+	</para>
+	</listitem>
+	</itemizedlist>
+	</blockquote>
+
+     </sect2>
+
+  </sect1>
+
+  </chapter>
+
   <chapter id="PiixInt">
      <title>ata_piix Internals</title>
 !Idrivers/scsi/ata_piix.c

