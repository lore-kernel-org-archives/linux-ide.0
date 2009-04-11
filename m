From: "John Stoffel" <john@stoffel.org>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 17:31:14 -0400
Message-ID: <18913.3106.750732.50314@stoffel.org>
References: <49E0D47B.9070205@garzik.org>
	<20090411203246.513a0892@lxorguk.ukuu.org.uk>
	<49E0F581.6010901@garzik.org>
	<18913.1720.994638.274611@stoffel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758555AbZDKVdZ@vger.kernel.org>
In-Reply-To: <18913.1720.994638.274611@stoffel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stoffel <john@stoffel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

>>>>> "John" == John Stoffel <john@stoffel.org> writes:

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:
Jeff> Alan Cox wrote:

>>>> With a brand new command set, might as well avoid SCSI completely
>>>> IMO, and create a brand new block device.
>>> 
>>> Providing we allow for the (inevitable ;)) joys of NVHCI over SAS etc 8)

Jeff> Perhaps...  from what I can tell, this is a direct, asynchronous
Jeff> NVM interface.  It appears to lack any concept of bus or bus
Jeff> enumeration.  No worries about link up/down, storage device
Jeff> hotplug, etc.  (you still have PCI hotplug case, of course)

John> Didn't we just spend years merging the old IDE PATA block devices into
John> the libata/scsi block device setup to get a more unified userspace and
John> to share common code?  

John> I'm a total ignoramous here, but it would seem that it would be nice
John> to keep the /dev/sd# stuff around for this, esp since it is supported
John> through/with/around AHCI and libata stuff.

John> Honestly, I don't care as long as userspace isn't too affected and I
John> can just format it using ext3.  :]  Which I realize would be silly
John> since it's probably nothing like regular disk access, but more like
John> the NVRAM used on Netapps for caching writes to disk so they can be
John> acknowledged quicker to the clients.  Or like the old PrestoServe
John> NVRAM modules on DECsystems and Alphas.  

And actually spending some thought on this, I'm thinking that this
will be like the MTD block device and such... seperate specialized
block devices, but still usable.  So maybe I'll just shutup now.  :]

John
