From: Samuel Flory <sflory@rackable.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Date: Thu, 05 Jun 2003 13:48:08 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3EDFAC88.4040609@rackable.com>
References: <20030605193514.GB1542@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:63037 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265122AbTFEUjT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2003 16:39:19 -0400
In-Reply-To: <20030605193514.GB1542@carfax.org.uk>
List-Id: linux-ide@vger.kernel.org
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org, alan@redhat.com

Hugo Mills wrote:

>   I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
>adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
>the kernel driver doesn't seem to notice this device on boot --
>nothing at all appears relating to this device in the boot messages.
>Can you help me?
>
>   I'm not a kernel hacker, I'm afraid, but I can apply patches and
>test stuff for this card+drive as much as you like...
>
>   (The card is configured in its on-board BIOS with a single disk as
>JBOD).
>
>  
>

  The card is a serial ata controller with what adaptec refers to as 
"hostraid".  (Meaning the raid is done in the driver.)  There are binary 
drivers for it on adptec's site, but no open source drivers.  The binary 
drivers are fairly good, but they are binary drivers.  (Which brings the 
headaches that binary drivers entail.)

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


