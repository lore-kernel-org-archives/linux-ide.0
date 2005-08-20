From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [SUMMARY] libata EH
Date: Sat, 20 Aug 2005 00:48:47 -0400
Message-ID: <4306B62F.7090509@pobox.com>
References: <20050820023351.GA690@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:62431 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751039AbVHTEtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 00:49:03 -0400
In-Reply-To: <20050820023351.GA690@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, mlord@pobox.com, lkosewsk@gmail.com, luben_tuikov@adaptec.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <axboe@suse.de>


(added Alan, Bart and Jens to CC)

Tejun Heo wrote:
>  Hello, Jeff & libata developers.
> 
>  I've been spending some time on libata EH and am trying to make a
> list of things which can be improved.  If you have something, please
> add to the list.
> 
> 1. Errors are handled in multiple paths.
> 
> 	* ATA errors are handled directly in intr context

Simple stuff like "command aborted" (invalid command) can be handled 
immediately, no need to kick in the error handling.

But as long as the right hardware interrupts are acknowledged, I don't 
mind if all error handling is moved to the thread.


> 	* timeouts are handled by ->eng_timeout via SCSI EH
> 
> 	* ATAPI errors are forwarded to ->eng_timeout in somewhat hackish way

->eng_timeout is somewhat misnamed.  A more correct name would be 
"error_hander".  ATAPI errors are intentionally forwarded to SCSI EH via 
the normal check-condition handling paths, which cause the SCSI EH to be 
invoked.


> 2. Synchronization
> 
> 	* SCSI EH entrance is not synchronized with normal processing.
> 	  ATAPI error handling/timeout handling can run concurrently
> 	  with normal command processing.  Albert, I think it's the
> 	  same problem you're trying to solve by moving ATA_QCFLAG_ACTIVE
> 	  clearing.
> 
> 	  http://marc.theaimsgroup.com/?l=linux-ide&m=112417360223374&w=2

The SCSI layer stops all command processing before calling 
->eh_strategy_handler().  Where do you see that it runs concurrently 
with normal command processing?  That should definitely -not- be happening.


> 	* SCSI EH entrance is not synchronized with polling tasks.

Yes, this definitely needs fixing.

Luckily the polling task is very rarely used, by normal users.


> 3. Error handling too weak
> 
> 	* We need to check the device responds to commands (say, w/
> 	  IDENTIFY or CHK_POWER) after an error, and then reset if it
>           doens't.  To do this, we need to handle all errors in EH.

First you need to classify the error, then handle based on that 
classification.

- DMA and PCI bus errors are usually indicated via status bits in 
controller registers, such as ATA_DMA_ERR on standard PCI IDE controllers.

- Device errors will be indicated via the ATA Status and Error registers.


- PCI bus errors should be handled by resetting the host controller (if 
possible), and then retrying the command [NOTE: better suggestions welcome]

- DMA errors should be handled by hueristics:  If more than $N (3?) DMA 
errors happen in 15 minutes,
* decrease SATA PHY speed.  if speed cannot be decreased,
* decrease UDMA xfer speed.  if at UDMA0, switch to PIO4
* decrease PIO xfer speed.  if at PIO3, complain, but continue

Commands should be retried after DMA errors.

- Device errors should handled as per ATA specs.  Usually these error do 
not cause a retry, but they may require additional inquiry such as READ 
LOG EXT if its a media error.


> 4. Better error reporting
> 
> 	* We currently depend on ATA_STAT and ATA_ERR register values
> 	  to check for and report errors.  As Jeff said, this is way
> 	  too crude.  We need better error reporting.  I think having
> 	  unified code path for error handling will help implementing
> 	  this.

This will fall naturally out of better error handling (stuff I described 
above).


> 5. EH is currently holding off other improvements
> 
> 	* NCQ controllers (or any other non-legacy ATA interface based
>           ones) don't fit nicely into current ATA error handling in
>           interrupt scheme.  As NCQ errors require issuing read log
> 	  command, we need to be in EH context to handle these errors.
> 
> 	* To properly implement hotplug, we need to have solid error
>           handling.  IMHO, implementing hotplug with current EH will
> 	  be quite fragile.

Correct.  Both NCQ and hotplug really want decent error handling -- 
particularly hotplug.  Hotplug will likely travel the error handling 
paths, though at that point we prefer the English word "exception" 
rather than "error"  :)


>  Whether we choose to stay with ->eh_strategy_handler or move over to
> fine-grained SCSI EH, IMHO, libata EH needs some work.  So... how
> should we proceed?

Well, moving over to the fine-grained hooks should make the remaining 
problems Mark sees go away, as well as guaranteeing that we get command 
completion right.

Staying with ->eh_strategy_handler() means auditing the entire SCSI 
layer to check and see what gets set on error, which libata must then 
manually reset.  Obviously there are still some bugs in this area, as 
Mark has demonstrated.  The big reason why I don't like 
->eh_strategy_handler() is that it continues to be an unknown quantity, 
in terms of, we don't still have a complete list of things-to-do during 
error handling.

If you are interested in tackling the work, you're more than welcome to 
choose either path.  Either way, the work won't go to waste.

	Jeff


