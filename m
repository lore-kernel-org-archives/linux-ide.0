From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement ata_exec_internal()
Date: Mon, 12 Dec 2005 23:58:32 -0500
Message-ID: <439E54F8.8020304@pobox.com>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:44744 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932447AbVLME6l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2005 23:58:41 -0500
In-Reply-To: <20051211042303.GA29403@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch implements ata_exec_internal() function which performs
> libata internal command execution.  Previously, this was done by each
> user by manually initializing a qc, issueing it, waiting for its
> completion and handling errors.  In addition to obvious code
> factoring, using ata_exec_internal() fixes the following bugs.
> 
> * qc not freed on issue failure
> * ap->qactive clearing could race with the next internal command
> * race between timeout handling and irq
> * ignoring error condition not represented in tf->status
> 
> Also, qc & hardware are not accessed anymore once it's completed,
> making internal commands more conformant with general semantics.
> ata_exec_internal() also makes it easy to issue internal commands from
> multiple threads if that becomes necessary.
> 
> This patch only implements ata_exec_internal().  A following patch
> will convert all users.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I ACK this version of the patchset, patches 1-4, but they don't seem to 
apply to 'upstream' branch:

[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
4 patch(es) to process.

Applying 'libata: implement ata_exec_internal()'

error: patch failed: include/linux/libata.h:136
error: include/linux/libata.h: patch does not apply


