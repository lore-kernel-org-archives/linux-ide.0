From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Tue, 01 May 2007 09:00:20 -0400
Message-ID: <463739E4.1030306@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2137 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbXEANAX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 09:00:23 -0400
In-Reply-To: <4634CC18.4080208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> So, this is specific to SATA (the host side at least) piix && PIO READ,
>> right?  I think we can fit this code nicely into
>> piix_sata_error_handler() if we make sure that it triggers under the
>> right condition - after a PIO READ command fails due to HSM violation
>> caused by stuck DRQ.
> 
> Yeah, so far it's just PIO FROM DEVICE on a "SATA" device on ata_piix.
> It *may* be more widespread than that, but we'll have to test some others.

I retested this again today on my new pure-SATA notebook with ata_piix.
In this case, the DRQ drain is not necessary, but also doesn't harm anything.
Tested it both ways.  This is with a Hitachi HTS541612J9SA00 SATA drive.

The original fault was on ata_piix SATA, with some kind of external
bridge (on the motherboard) to a Seagate PATA drive.  Sometime in the
next few days I'll have the exact same drive, but with a SATA interface,
and we'll try that in the pure-SATA situation.

This will tell us whether it's the bridge, or the drive, that was the issue.

The fix remains the same: drain the data fifo when DRQ is left high.
