From: "Jim Ramsay" <jim.ramsay@gmail.com>
Subject: Hotplug in newest libata
Date: Tue, 29 Aug 2006 11:28:01 -0600
Message-ID: <4789af9e0608291028n7f7b5db6g827ecf648c7da354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:32547 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965045AbWH2R2C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 13:28:02 -0400
Received: by wr-out-0506.google.com with SMTP id i28so731409wra
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 10:28:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

I'm working with the new EH in the libata from the 2.6.18-rc4, and I'm
curious what the proper way is to signal the EH code that a hotplugin
event has occurred, or that a hotunplug event has occurred.

(this is for the sata_promise driver which does its own interrupt
handling, with special register flags for each drive's hotplugin and
hotunplug events).  Here is what I have so far (seems to work):

if( plugdata & (1 << i) ) {
	printk( KERN_DEBUG "ata%d: Hot-unplug interrupt\n", ap->id );
	/*
	 * Set up drive as already missing so it is not
	 * re-probed multiple times.
	 */
	struct ata_device *dev = &ap->device[0];
	dev->flags |= ATA_DFLAG_DETACH;

	if( !(ap->pflags & ATA_PFLAG_FROZEN) )
		ata_port_freeze(ap);
	handled++;
} else if( plugdata & (1 << (i+4)) ) {
	printk( KERN_DEBUG "ata%d: Hot-plugin interrupt\n", ap->id );
	/*
	 * Just 'freezing' the drive works... it is
	 * reset and re-probed automatically!
	 */
	if( !(ap->pflags & ATA_PFLAG_FROZEN) )
		ata_port_freeze(ap);
	handled++;
}

The only problem that I've noticed so far is that in the plugin case,
the bus scanning never seems to run the ata_wait_spinup routine.  Is
there something more I should do in this case to let everything know
that we've got a new device and should wait for it to spinup?

Also, I added the 'dev->flags |= ATA_DFLAG_DETACH' on a hunch...
before this on an unplug event it would try to scan the device 3 times
before actually removing it, and this isn't strictly necessary.  Is
this wrong, or is there a better way to tell everything that the drive
is gone and shouldn't be rescanned?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
