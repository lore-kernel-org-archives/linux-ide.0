From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA errors
Date: Sun, 9 Aug 2009 21:57:53 +0200
Message-ID: <19071.10817.664277.813057@pilspetsen.it.uu.se>
References: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:52554 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbZHIT57 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2009 15:57:59 -0400
In-Reply-To: <1249814200.13927.65.camel@meteotsunami.darksilence.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miah Gregory <mace@darksilence.net>
Cc: linux-ide@vger.kernel.org

Miah Gregory writes:
 > Hi,
 > 
 > One of my servers has started to log slightly odd errors following one
 > of the software RAID arrays having been degraded due to an error on sdb.
...
 > All of these errors might possibly related to smart self checking which
 > I've now set to run more regularly - although I wouldn't really expect a
 > reset being required to get the disk to respond during one.
 > 
 > I'm running a 2.6.28.2 kernel in a machine with 4 WDC WD5000AACS-0 500GB
 > disks.
 > 
 > I'm unable to check how the disks are physically wired at the moment,
 > however they're probably all on the promise controller:
 > 
 > 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
 > 01:04.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
 > 
 > Any assistance greatfully received - please let me know if further
 > information is needed.

1. Did these problems start spontaneously, or did they follow some
   system change like installing more disks or booting a newer kernel?
2. If there's reason to suspect a kernel issue, the disk-to-controller
   mapping in this machine will tell us which driver may be at fault.
   Please post a complete kernel boot log from e.g. `dmesg'.
3. If the disks are attached to the Promise controller, please try this patch:
   <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/2.6.28/patch-sata_promise-reset-updates-v1-2.6.28>
   It improved error recovery in a case where smart commands to a sleeping
   disk of a particular model timed out.

/Mikael
