From: "John Stoffel" <john@stoffel.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 17:08:08 -0400
Message-ID: <18913.1720.994638.274611@stoffel.org>
References: <49E0D47B.9070205@garzik.org>
	<20090411203246.513a0892@lxorguk.ukuu.org.uk>
	<49E0F581.6010901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759417AbZDKVLM@vger.kernel.org>
In-Reply-To: <49E0F581.6010901@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:

Jeff> Alan Cox wrote:

>>> With a brand new command set, might as well avoid SCSI completely
>>> IMO, and create a brand new block device.
>> 
>> Providing we allow for the (inevitable ;)) joys of NVHCI over SAS etc 8)

Jeff> Perhaps...  from what I can tell, this is a direct, asynchronous
Jeff> NVM interface.  It appears to lack any concept of bus or bus
Jeff> enumeration.  No worries about link up/down, storage device
Jeff> hotplug, etc.  (you still have PCI hotplug case, of course)

Didn't we just spend years merging the old IDE PATA block devices into
the libata/scsi block device setup to get a more unified userspace and
to share common code?  

I'm a total ignoramous here, but it would seem that it would be nice
to keep the /dev/sd# stuff around for this, esp since it is supported
through/with/around AHCI and libata stuff.

Honestly, I don't care as long as userspace isn't too affected and I
can just format it using ext3.  :]  Which I realize would be silly
since it's probably nothing like regular disk access, but more like
the NVRAM used on Netapps for caching writes to disk so they can be
acknowledged quicker to the clients.  Or like the old PrestoServe
NVRAM modules on DECsystems and Alphas.  

John
