From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] sata_nv: use hardreset only for post-boot probing
Date: Wed, 10 Jun 2009 11:05:51 -0400
Message-ID: <4A2FCBCF.7010308@garzik.org>
References: <4A2F60C3.2070805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54611 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbZFJPGD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 11:06:03 -0400
In-Reply-To: <4A2F60C3.2070805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, david@lang.hm, lament.email.si@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> When I thought it was finally defeated, it came back with vengeance.
> The failure cases are ever more convoluted.  Now there is a single
> combination which fails boot probing - MCP5x + Intel SSD and there are
> two hotplug failure reports on different flavors where softreset fails
> to bring up the device.
> 
> Through the many bug reports after the switch to hardreset, the
> following patterns emerged.
> 
> - Softreset during boot always works.
> 
> - Hardreset during boot sometimes fails to bring up the link on
>   certain comibnations and device signature acquisition is unreliable.
> 
> - Hardreset is often necessary after hotplug.
> 
> It looks like the old behavior of preferring softreset was somehow
> pretty close to the working reset protocol although it could have lost
> a device during phy error handling by issuing hardreset.
> 
> This patch implements nv_hardreset() which kicks in only for post-boot
> (!LOADING) device probing resets.  This should be able to work around
> all known problem cases.  This isn't perfect but given the various
> hardreset quirks on these controllers, I think this is as good as it
> can get.
> 
> Tested on mcp5x (swncq), nf3 and ck804 for all both boot, warm and
> hot probing cases.
> 
> Kudos to all the bug reporters and their painful hours with these damn
> controllers.  ;-)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Robert Hancock <hancockr@shaw.ca>
> Reported-by: David Lang <david@lang.hm>
> Reported-by: Samo Vodopivec <lament.email.si@gmail.com>
> ---
> Jeff, please queue for 2.6.31.  I think this should be pretty safe but
> well I've said that before several times for sata_nv already and was
> wrong, so...
> 
> Thanks.
> 
>  drivers/ata/sata_nv.c |  131 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 50 deletions(-)

applied


