From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI hot replace sdX incrementing
Date: Tue, 10 Apr 2007 05:50:04 -0400
Message-ID: <461B5DCC.4010208@garzik.org>
References: <39B20DF628532344BC7A2692CB6AEE070127216E@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34173 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364AbXDJJuF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 05:50:05 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE070127216E@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> When I hot-remove a SATA HD in AHCI mode and then hot-plug the drive
> back in again, the /dev/sdX number changes to the next available number.
> Is this going to be a problem when using a RAID array that includes that
> drive?

Well, it's certainly something you have to deal with.  You have to tell 
the RAID driver you added a component to the system.  Ideally mdadm or 
udev should take care of that, but I'm not sure it's all there yet.

In any case, it's a new device so, while inconvenient for some 
scenarios, I think it is best to represent a new device with a new 
device node.  Various entities are still probably holding references to 
the old device, and you don't want the system to think that you plugged 
in the _same_ device again.

	Jeff


