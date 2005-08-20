From: Tejun Heo <htejun@gmail.com>
Subject: [SUMMARY] libata EH
Date: Sat, 20 Aug 2005 11:33:51 +0900
Message-ID: <20050820023351.GA690@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:50483 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932631AbVHTCeB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Aug 2005 22:34:01 -0400
Received: by zproxy.gmail.com with SMTP id i11so489771nzh
        for <linux-ide@vger.kernel.org>; Fri, 19 Aug 2005 19:33:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, mlord@pobox.com, lkosewsk@gmail.com, luben_tuikov@adaptec.com

 Hello, Jeff & libata developers.

 I've been spending some time on libata EH and am trying to make a
list of things which can be improved.  If you have something, please
add to the list.

1. Errors are handled in multiple paths.

	* ATA errors are handled directly in intr context

	* timeouts are handled by ->eng_timeout via SCSI EH

	* ATAPI errors are forwarded to ->eng_timeout in somewhat hackish way

2. Synchronization

	* SCSI EH entrance is not synchronized with normal processing.
	  ATAPI error handling/timeout handling can run concurrently
	  with normal command processing.  Albert, I think it's the
	  same problem you're trying to solve by moving ATA_QCFLAG_ACTIVE
	  clearing.

	  http://marc.theaimsgroup.com/?l=linux-ide&m=112417360223374&w=2

	* SCSI EH entrance is not synchronized with polling tasks.
	  We should cancel & wait for polling tasks on entry to EH, but
	  we don't.

3. Error handling too weak

	* We need to check the device responds to commands (say, w/
	  IDENTIFY or CHK_POWER) after an error, and then reset if it
          doens't.  To do this, we need to handle all errors in EH.

4. Better error reporting

	* We currently depend on ATA_STAT and ATA_ERR register values
	  to check for and report errors.  As Jeff said, this is way
	  too crude.  We need better error reporting.  I think having
	  unified code path for error handling will help implementing
	  this.

5. EH is currently holding off other improvements

	* NCQ controllers (or any other non-legacy ATA interface based
          ones) don't fit nicely into current ATA error handling in
          interrupt scheme.  As NCQ errors require issuing read log
	  command, we need to be in EH context to handle these errors.

	* To properly implement hotplug, we need to have solid error
          handling.  IMHO, implementing hotplug with current EH will
	  be quite fragile.

 Whether we choose to stay with ->eh_strategy_handler or move over to
fine-grained SCSI EH, IMHO, libata EH needs some work.  So... how
should we proceed?

 Thanks.

-- 
tejun
