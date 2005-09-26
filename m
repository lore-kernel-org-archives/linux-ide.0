From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:upstream] libata EH document update
Date: Mon, 26 Sep 2005 11:28:47 +0900
Message-ID: <20050926022847.GA9724@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:7433 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751600AbVIZC2z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Sep 2005 22:28:55 -0400
Received: by zproxy.gmail.com with SMTP id 13so284530nzn
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2005 19:28:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

 Hello, Jeff.

 Here's DocBook'fied libata_eh document.  Sorry it took so long.

 To whine a little bit, I still think it's better to go plain text
with ata docs under Documentation/ata.  I don't really see the
benefits of DocBook as it currently stands.  It's so much less
accessible.  make pdf/ps docs still don't work and although it's been
broken for quite a while now, nobody really cares.

 One benefit of using DocBook is integrating docs generated from
comments with the rest of template but I think such generated content
can (maybe should) stay separate from other stuff.  I think the
generated content and the rest won't stay synchronized for very long
considering the rate of change, lazy doc updates and even less
interest in DocBook docs.  Okay, enough whining.

 For libata_eh doc, I just created a <sect1> which contains the whole
thing.  I thought about separating out origins of commands and stuff
into separate chapters so that the structure of the document is more
consistent, but the contents were too little to be spread out and they
are describing in EH centric way, so I just left all in one chapter.

 I'm thinking about attaching ata_exceptions doc at the end of this
DocBook file as a separate supplementary chapter.  What do you think?

 Thanks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -413,6 +413,362 @@ and other resources, etc.
 	</sect2>
 
      </sect1>
+     <sect1>
+        <title>Error handling</title>
+
+	<para>
+	This chapter describes how errors are handled under libata.
+	Readers are advised to read SCSI EH
+	(Documentation/scsi/scsi_eh.txt) and ATA exceptions doc first.
+	</para>
+
+	<sect2><title>Origins of commands</title>
+	<para>
+	In libata, a command is represented with struct ata_queued_cmd
+	or qc.  qc's are preallocated during port initialization and
+	repetitively used for command executions.  Currently only one
+	qc is allocated per port but yet-to-be-merged NCQ branch
+	allocates one for each tag and maps each qc to NCQ tag 1-to-1.
+	</para>
+	<para>
+	libata commands can originate from two sources - libata itself
+	and SCSI midlayer.  libata internal commands are used for
+	initialization and error handling.  All normal blk requests
+	and commands for SCSI emulation are passed as SCSI commands
+	through queuecommand callback of SCSI host template.
+	</para>
+	</sect2>
+
+	<sect2><title>How commands are issued</title>
+
+	<variablelist>
+
+	<varlistentry><term>Internal commands</term>
+	<listitem>
+	<para>
+	First, qc is allocated and initialized using
+	ata_qc_new_init().  Although ata_qc_new_init() doesn't
+	implement any wait or retry mechanism when qc is not
+	available, internal commands are currently issued only during
+	initialization and error recovery, so no other command is
+	active and allocation is guaranteed to succeed.
+	</para>
+	<para>
+	Once allocated qc's taskfile is initialized for the command to
+	be executed.  qc currently has two mechanisms to notify
+	completion.  One is via qc->complete_fn() callback and the
+	other is completion qc->waiting.  qc->complete_fn() callback
+	is the asynchronous path used by normal SCSI translated
+	commands and qc->waiting is the synchronous (issuer sleeps in
+	process context) path used by internal commands.
+	</para>
+	<para>
+	Once initialization is complete, host_set lock is acquired
+	and the qc is issued.
+	</para>
+	</listitem>
+	</varlistentry>
+
+	<varlistentry><term>SCSI commands</term>
+	<listitem>
+	<para>
+	All libata drivers use ata_scsi_queuecmd() as
+	hostt->queuecommand callback.  scmds can either be simulated
+	or translated.  No qc is involved in processing a simulated
+	scmd.  The result is computed right away and the scmd is
+	completed.
+	</para>
+	<para>
+	For a translated scmd, ata_qc_new_init() is invoked to
+	allocate a qc and the scmd is translated into the qc.  SCSI
+	midlayer's completion notification function pointer is stored
+	into qc->scsidone.
+	</para>
+	<para>
+	qc->complete_fn() callback is used for completion
+	notification.  ATA commands use ata_scsi_qc_complete() while
+	ATAPI commands use atapi_qc_complete().  Both functions end up
+	calling qc->scsidone to notify upper layer when the qc is
+	finished.  After translation is completed, the qc is issued
+	with ata_qc_issue().
+	</para>
+	<para>
+	Note that SCSI midlayer invokes hostt->queuecommand while
+	holding host_set lock, so all above occur while holding
+	host_set lock.
+	</para>
+	</listitem>
+	</varlistentry>
+
+	</variablelist>
+	</sect2>
+
+	<sect2><title>How commands are processed</title>
+	<para>
+	Depending on which protocol and which controller are used,
+	commands are processed differently.  For the purpose of
+	discussion, a controller which uses taskfile interface and all
+	standard callbacks is assumed.
+	</para>
+	<para>
+	Currently 6 ATA command protocols are used.  They can be
+	sorted into the following four categories according to how
+	they are processed.
+	</para>
+
+	<variablelist>
+	   <varlistentry><term>ATA NO DATA or DMA</term>
+	   <listitem>
+	   <para>
+	   ATA_PROT_NODATA and ATA_PROT_DMA fall into this category.
+	   These types of commands don't require any software
+	   intervention once issued.  Device will raise interrupt on
+	   completion.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>ATA PIO</term>
+	   <listitem>
+	   <para>
+	   ATA_PROT_PIO is in this category.  libata currently
+	   implements PIO with polling.  ATA_NIEN bit is set to turn
+	   off interrupt and pio_task on ata_wq performs polling and
+	   IO.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>ATAPI NODATA or DMA</term>
+	   <listitem>
+	   <para>
+	   ATA_PROT_ATAPI_NODATA and ATA_PROT_ATAPI_DMA are in this
+	   category.  packet_task is used to poll BSY bit after
+	   issuing PACKET command.  Once BSY is turned off by the
+	   device, packet_task transfers CDB and hands off processing
+	   to interrupt handler.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+
+	   <varlistentry><term>ATAPI PIO</term>
+	   <listitem>
+	   <para>
+	   ATA_PROT_ATAPI is in this category.  ATA_NIEN bit is set
+	   and, as in ATAPI NODATA or DMA, packet_task submits cdb.
+	   However, after submitting cdb, further processing (data
+	   transfer) is handed off to pio_task.
+	   </para>
+	   </listitem>
+	   </varlistentry>
+	</variablelist>
+        </sect2>
+
+	<sect2><title>How commands are completed</title>
+	<para>
+	Once issued, all qc's are either completed with
+	ata_qc_complete() or time out.  For commands which are handled
+	by interrupts, ata_host_intr() invokes ata_qc_complete(), and,
+	for PIO tasks, pio_task invokes ata_qc_complete().  In error
+	cases, packet_task may also complete commands.
+	</para>
+	<para>
+	ata_qc_complete() does the following.
+	</para>
+
+	<orderedlist>
+
+	<listitem>
+	<para>
+	DMA memory is unmapped.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	ATA_QCFLAG_ACTIVE is clared from qc->flags.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	qc->complete_fn() callback is invoked.  If the return value of
+	the callback is not zero.  Completion is short circuited and
+	ata_qc_complete() returns.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	__ata_qc_complete() is called, which does
+	   <orderedlist>
+
+	   <listitem>
+	   <para>
+	   qc->flags is cleared to zero.
+	   </para>
+	   </listitem>
+
+	   <listitem>
+	   <para>
+	   ap->active_tag and qc->tag are poisoned.
+	   </para>
+	   </listitem>
+
+	   <listitem>
+	   <para>
+	   qc->waiting is claread &amp; completed (in that order).
+	   </para>
+	   </listitem>
+
+	   <listitem>
+	   <para>
+	   qc is deallocated by clearing appropriate bit in ap->qactive.
+	   </para>
+	   </listitem>
+
+	   </orderedlist>
+	</para>
+	</listitem>
+
+	</orderedlist>
+
+	<para>
+	So, it basically notifies upper layer and deallocates qc.  One
+	exception is short-circuit path in #3 which is used by
+	atapi_qc_complete().
+	</para>
+	<para>
+	For all non-ATAPI commands, whether it fails or not, almost
+	the same code path is taken and very little error handling
+	takes place.  A qc is completed with success status if it
+	succeeded, with failed status otherwise.
+	</para>
+	<para>
+	However, failed ATAPI commands require more handling as
+	REQUEST SENSE is needed to acquire sense data.  If an ATAPI
+	command fails, ata_qc_complete() is invoked with error status,
+	which in turn invokes atapi_qc_complete() via
+	qc->complete_fn() callback.
+	</para>
+	<para>
+	This makes atapi_qc_complete() set scmd->result to
+	SAM_STAT_CHECK_CONDITION, complete the scmd and return 1.  As
+	the sense data is empty but scmd->result is CHECK CONDITION,
+	SCSI midlayer will invoke EH for the scmd, and returning 1
+	makes ata_qc_complete() to return without deallocating the qc.
+	This leads us to ata_scsi_error() with partially completed qc.
+	</para>
+
+	</sect2>
+
+	<sect2><title>ata_scsi_error()</title>
+	<para>
+	ata_scsi_error() is the current hostt->eh_strategy_handler()
+	for libata.  As discussed above, this will be entered in two
+	cases - timeout and ATAPI error completion.  This function
+	calls low level libata driver's eng_timeout() callback, the
+	standard callback for which is ata_eng_timeout().  It checks
+	if a qc is active and calls ata_qc_timeout() on the qc if so.
+	Actual error handling occurs in ata_qc_timeout().
+	</para>
+	<para>
+	If EH is invoked for timeout, ata_qc_timeout() stops BMDMA and
+	completes the qc.  Note that as we're currently in EH, we
+	cannot call scsi_done.  As described in SCSI EH doc, a
+	recovered scmd should be either retried with
+	scsi_queue_insert() or finished with scsi_finish_command().
+	Here, we override qc->scsidone with scsi_finish_command() and
+	calls ata_qc_complete().
+	</para>
+	<para>
+	If EH is invoked due to a failed ATAPI qc, the qc here is
+	completed but not deallocated.  The purpose of this
+	half-completion is to use the qc as place holder to make EH
+	code reach this place.  This is a bit hackish, but it works.
+	</para>
+	<para>
+	Once control reaches here, the qc is deallocated by invoking
+	__ata_qc_complete() explicitly.  Then, internal qc for REQUEST
+	SENSE is issued.  Once sense data is acquired, scmd is
+	finished by directly invoking scsi_finish_command() on the
+	scmd.  Note that as we already have completed and deallocated
+	the qc which was associated with the scmd, we don't need
+	to/cannot call ata_qc_complete() again.
+	</para>
+
+	</sect2>
+
+	<sect2><title>Problems with the current EH</title>
+
+	<itemizedlist>
+
+	<listitem>
+	<para>
+	Error representation is too crude.  Currently any and all
+	error conditions are represented with ATA STATUS and ERROR
+	registers.  Errors which aren't ATA device errors are treated
+	as ATA device errors by setting ATA_ERR bit.  Better error
+	descriptor which can properly represent ATA and other
+	errors/exceptions is needed.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	When handling timeouts, no action is taken to make device
+	forget about the timed out command and ready for new commands.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	EH handling via ata_scsi_error() is not properly protected
+	from usual command processing.  On EH entrance, the device is
+	not in quiescent state.  Timed out commands may succeed or
+	fail any time.  pio_task and atapi_task may still be running.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	Too weak error recovery.  Devices / controllers causing HSM
+	mismatch errors and other errors quite often require reset to
+	return to known state.  Also, advanced error handling is
+	necessary to support features like NCQ and hotplug.
+	</para>
+	</listitem>
+
+	<listitem>
+	<para>
+	ATA errors are directly handled in the interrupt handler and
+	PIO errors in pio_task.  This is problematic for advanced
+	error handling for the following reasons.
+	</para>
+	<para>
+	First, advanced error handling often requires context and
+	internal qc execution.
+	</para>
+	<para>
+	Second, even a simple failure (say, CRC error) needs
+	information gathering and could trigger complex error handling
+	(say, resetting &amp; reconfiguring).  Having multiple code
+	paths to gather information, enter EH and trigger actions
+	makes life painful.
+	</para>
+	<para>
+	Third, scattered EH code makes implementing low level drivers
+	difficult.  Low level drivers override libata callbacks.  If
+	EH is scattered over several places, each affected callbacks
+	should perform its part of error handling.  This can be error
+	prone and painful.
+	</para>
+	</listitem>
+
+	</itemizedlist>
+	</sect2>
+
+     </sect1>
   </chapter>
 
   <chapter id="libataExt">
