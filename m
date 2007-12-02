From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 22:45:09 -0500
Message-ID: <47522A45.50706@rtr.ca>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu> <475110A8.5090709@clear.net.nz> <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com> <4751B3DA.6030508@clear.net.nz> <4751BDA4.9080102@rtr.ca> <4751C6DA.3080409@garzik.org> <4751F482.60204@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1527 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbXLBDpL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 22:45:11 -0500
In-Reply-To: <4751F482.60204@clear.net.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Richard Scobie wrote:
> 
> 
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> SATA port multipliers (think, "hub") permit multiple drives
>>> to be active simultaneously.
>>
>> Quite true, although the host controller could artificially limit 
>> this, giving the user a mistaken impression of their port multiplier 
>> being limited to one-command-per-N-drives.
> 
> Interesting. I was basing my comments on what may well be a vested 
> interest slanted paper - see the sidebar on page 2.
> 
> http://www.xtore.com/Downloads/WhitePapers/SAS_SATAValue%20Whitepaper_final.pdf 
> 
> 
> For the modest extra cost of a non-RAID SAS HBA and JBOD enclosure with 
> SATA drives, over a port multiplied setup, there would seem to be some 
> advantages.
> 
> Or have I been taken in by the hype... :)
..

Here's the "hype" part from that biased paper:
>
> Performance: Port Multipliers only support one active host
> connection at a time, signicantly degrading e
ective
> throughput. Each time communication is initiated with a drive
> time-consuming drive reset must occur.
>
> Data Integrity: PMs must close the connection to one drive
> to open a new one to another. When a connection is closed
> drive history (e.g., data source, destination drive, data &
> command context) is lost; with each opened connection the
> chance of misidentification and sending data to the wrong
> drive is increased.

Fiction.  Or rather, heavily biased.
Modern SATA hosts and PMs have no such issues.
The key SATA term to ask for is "FIS-based switching".

The biggest difference between SATA and SAS,
is the same one we previously had between ATA and SCSI:

   Vendors like to position SAS/SCSI as a "premium" brand,
   and therefore cripple SATA/ATA with lower spin-rates
   (7200rpm max, or 10000rpm for WD Raptors, vs. 20000rpm
   for high end SAS/SCSI).

There may be other firmware algorithm differences as well,
but "RAID edition" SATA/ATA drives have similar low-readahead
and fast-seek programming as their SAS/SCSI counterparts.

Simple spin-rate (RPM) is the most significant distinguishing
factor in nearly all scenarios.  SAS/SCSI may also still win when
connecting a ridiculously large number of drives to a single port.

Cheers
