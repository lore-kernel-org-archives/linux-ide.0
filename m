From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 21:47:56 -0400
Message-ID: <47DC7C4C.4040400@garzik.org>
References: <20080315153730.GX613@parisc-linux.org> <47DC04CD.7060209@garzik.org> <20080315174929.GY613@parisc-linux.org> <47DC5223.6080105@garzik.org> <20080316004609.GZ613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39173 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYCPBsA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Mar 2008 21:48:00 -0400
In-Reply-To: <20080316004609.GZ613@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Mar 15, 2008 at 06:48:03PM -0400, Jeff Garzik wrote:
>> P.S.  I encourage others to investigate making the libata SCSI simulator 
>> an optional kernel module.
>>
>> Long term, a preferred solution would be to use SCSI layer for ATAPI 
>> devices, and a kernel block device for ATA devices.
> 
> I think that's the right method to take, though we probably still want
> to emulate the scsi ioctls.

We'll want the ATA<->SCSI simulator in its entirety as an optional 
module for compatibility.  People have built applications assuming they 
must use SCSI (more specifically, SAT) to probe and manipulate ATA devices.

	Jeff



