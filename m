From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Inquiry data and emulated SG devices
Date: Wed, 17 Oct 2007 19:22:50 -0600
Message-ID: <4716B56A.1090501@shaw.ca>
References: <fa.PgEHbZ0E5ogcX8bZwvrUeZB+eJs@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:9521 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbXJRBW7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 21:22:59 -0400
In-reply-to: <fa.PgEHbZ0E5ogcX8bZwvrUeZB+eJs@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

(cc-ing linux-ide)

Mathieu Fluhr wrote:
> Hello all,
> 
> 
> First of all, let me introduce myself a little bit. I am the responsable
> for the development of the Nero Linux burning application. So I have
> access to all the source code of the application.
> 
> 
> Now let's go with the story: It seems that there is a slight problem in
> the libata (and also the new pata_xxx) interfaces with the data returned
> by the INQUIRY cmd since every S-ATA or IDE device is assumed to be a
> SCSI dev.
> 
> Normally, the IDE devices (physical type) can be differentied with the
> format field of the inquiry data, i.e. the last bytes (ANSI version) are
> set to 0 -> This is done and works great with USB external devices for
> example.
> 
> 
> The thing is that with S-ATA/IDE devices when using the libata/pata
> driver, the version field is (always?) set to 5, as any _real_ SCSI
> device, and thus the physical device type cannot be checked anymore.

This doesn't seem a very reliable way to identify an IDE device, as all
that 0 means is that the device does not claim conformance to any
standard. I would think it would be legitimate for an IDE device to put
a value like 5 in there as well, if it complies with SPC-4..

In the case of libata though, that appears to be due to this code in
drivers/ata/libata-scsi.c:

	/* ATAPI devices typically report zero for their SCSI version,
	 * and sometimes deviate from the spec WRT response data
	 * format.  If SCSI version is reported as zero like normal,
	 * then we make the following fixups:  1) Fake MMC-5 version,
	 * to indicate to the Linux scsi midlayer this is a modern
	 * device.  2) Ensure response data format / ATAPI information
	 * are always correct.
	 */
			if (buf[2] == 0) {
				buf[2] = 0x5;
				buf[3] = 0x32;
			}

This technically seems to go against what the SCSI/ATA Translation (SAT)
spec says regarding INQUIRY on ATAPI devices: "the SATL shall use the
ATA PACKET Command feature set to pass all INQUIRY commands and
parameter data to the ATAPI device without altering the INQUIRY
commands or the parameter data." However, it might realistically be
needed if the SCSI layer in the kernel has problems with a device
indicating it supports no SCSI version..

> 
> I cannot go so deep in details, but our burn engine is differentiating
> IDE and read-good-old-SCSI devices and handles them sometimes in a
> different way, so this differenciation is really important for us.
> 
>    -> How can I detect the real physical device type now?

I don't have a great answer off the top of my head..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


