From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: ahci enclosure save new led state
Date: Tue, 24 Mar 2009 22:43:05 -0400
Message-ID: <49C99A39.4090903@garzik.org>
References: <20090320191423.GA16289@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36695 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbZCYCnL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:43:11 -0400
In-Reply-To: <20090320191423.GA16289@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

David Milburn wrote:
> ahci_transmit_led_message saves off the led_state
> with a value that includes the port number OR'd
> in, this incorrect value maybe reported back
> in ahci_led_store.
> 
> For instance, if you turn off all the leds for
> port 1 and cat the value back it will report 1
> instead of 0.
> 
> # echo 0 > /sys/class/scsi_host/host1/em_message
> # cat /sys/class/scsi_host/host1/em_message
> 1
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/ahci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

applied


