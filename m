From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Thu, 18 Nov 2010 14:37:05 -0500
Message-ID: <4CE58061.4080906@cfl.rr.com>
References: <4CDB63E7.1040106@cfl.rr.com> <4CDB79CA.6000606@garzik.org> <4CDE20CF.3010708@cfl.rr.com> <4CDE2274.8060807@garzik.org> <4CDEB2C3.20806@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exhub016-2.exch016.msoutlookonline.net ([207.5.72.164]:25840
	"EHLO EXHUB016-2.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0KRTff (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2010 14:35:35 -0500
In-Reply-To: <4CDEB2C3.20806@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

I never got any comment back on this.  In order for udev to use the
existing attribute, it needs to be moved out of the scsi_host device,
and udev needs patched to handle bitwise comparisons, or my simple patch
adding the new attribute can be applied.

Are you certain you do not want to add a new attribute, and if so, would
you accept a patch moving the existing one out of the scsi_host device
so it will be a proper ancestor of the disk device?

On 11/13/2010 10:46 AM, Phillip Susi wrote:
> On 11/13/2010 12:30 AM, Jeff Garzik wrote:
>> As you noted in your previous mail, the entire PORT_CMD is already
>> exported as a attribute. I don't see much point in exporting this
>> information a second time.
> 
> Unfortunately it is not exported in a way that udev can make use of it.
>  Firstly because udev can only compare on specific value matches rather
> than an individual bit, and secondly because it is in the weird
> scsi_host device rather than the host device, so the attribute is not in
> an ancestor device of the disk device.  Placing this attribute this way
> puts it in the ancestry of the disk device so it can be matched by a
> udev ATTRS rule.

