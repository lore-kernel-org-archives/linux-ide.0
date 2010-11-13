From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Sat, 13 Nov 2010 10:46:11 -0500
Message-ID: <4CDEB2C3.20806@cfl.rr.com>
References: <4CDB63E7.1040106@cfl.rr.com> <4CDB79CA.6000606@garzik.org> <4CDE20CF.3010708@cfl.rr.com> <4CDE2274.8060807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:48065 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab0KMPqQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Nov 2010 10:46:16 -0500
In-Reply-To: <4CDE2274.8060807@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On 11/13/2010 12:30 AM, Jeff Garzik wrote:
> As you noted in your previous mail, the entire PORT_CMD is already
> exported as a attribute. I don't see much point in exporting this
> information a second time.

Unfortunately it is not exported in a way that udev can make use of it. 
  Firstly because udev can only compare on specific value matches rather 
than an individual bit, and secondly because it is in the weird 
scsi_host device rather than the host device, so the attribute is not in 
an ancestor device of the disk device.  Placing this attribute this way 
puts it in the ancestry of the disk device so it can be matched by a 
udev ATTRS rule.
