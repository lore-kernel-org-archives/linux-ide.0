From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10752] New: pata_isapnp driver causes the ata
 layer to go splat
Date: Mon, 19 May 2008 15:25:49 -0700
Message-ID: <20080519152549.09be22b2.akpm@linux-foundation.org>
References: <bug-10752-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36927 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294AbYESW03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 18:26:29 -0400
In-Reply-To: <bug-10752-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, Arjan van de Ven <arjan@infradead.org>

On Mon, 19 May 2008 14:46:08 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10752
> 
>            Summary: pata_isapnp driver causes the ata layer to go splat
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.25
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: arjan@linux.intel.com
> 
> 
> This happens quite a bit based on Fedora 9 feedback, but already happened in
> 2.6.24 and possibly earlier.
> 
> http://www.kerneloops.org/search.php?search=bad_io_access
> 
> shows the basic backtrace:
> *bad_io_access
> ioread8
> ata_altstatus
> ata_std_dev_select
> ata_dev_select
> ata_qc_issue_prot
> ata_qc_issue
> ata_exec_internal_sg
> ata_exec_internal
> ata_dev_read_id
> ata_eh_recover
> ata_do_eh
> ata_bmdma_drive_eh
> ata_bmdma_error_handler
> ata_scsi_error
> scsi_error_handler
> kthread
> kernel_thread_helper
> 
> in all cases, this happens while pata_isapnp is being loaded; so it's not
> unlikely that this driver stomps on some other driver which then goes splat
> 

Unclear who maintains pata_isapnp?
