From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: sd_resume redundant?  [was: [PATCH] libata: implement
 ata_wait_after_reset()]
Date: Sun, 20 May 2007 11:53:53 -0700
Message-ID: <20070520115353.4428a735.randy.dunlap@oracle.com>
References: <fa.M0o+I253i7tt/LF97sml0AM+Gec@ifi.uio.no>
	<fa.j/gDhS9FZwWkX/stLhREkTHNbFs@ifi.uio.no>
	<fa.EalQUMJMBHX/KTGV2QFQLG6tYus@ifi.uio.no>
	<fa.Zh3ttZJ9A5tObhEjMLSALUpxCuQ@ifi.uio.no>
	<fa.tQ9LHpM0TOYAYEug36HHMvEVOO0@ifi.uio.no>
	<fa.jSmqI/kJPff3zaVtC404yNL5/Qk@ifi.uio.no>
	<4650891F.80301@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:57026 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXETSso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 May 2007 14:48:44 -0400
In-Reply-To: <4650891F.80301@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, ide <linux-ide@vger.kernel.org>
Cc: Indan Zupancic <indan@nul.nu>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On Sun, 20 May 2007 11:45:03 -0600 Robert Hancock wrote:

> Indan Zupancic wrote:
> >>> Everything seems to work fine without sd_resume(), so why is it needed?
> >> Because not all disks spin up without being told to do so and like it or
> >> not spinning disks up on resume is the default behavior.  As I wrote in
> >> the other reply, it would be worthwhile to make it configurable.
> > 
> > Not even after they receive a read command? Ugh.
> 
> ATA disks are supposed to spin up, yes. SCSI disks require a command to 
> tell them to spin up if they're in the "stopped" state.

Good info, but linux-ide was dropped.  Is that due to lack of
reply-to-all or is it a newsgroup thing or what?


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
