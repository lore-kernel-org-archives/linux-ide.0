From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Wed, 10 Mar 2004 02:22:06 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <404EC21E.4030809@pobox.com>
References: <200403100006.36405.andres.meyer@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36751 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262256AbUCJHWS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2004 02:22:18 -0500
In-Reply-To: <200403100006.36405.andres.meyer@computer.org>
List-Id: linux-ide@vger.kernel.org
To: Andres Meyer <andres.meyer@computer.org>
Cc: linux-ide@vger.kernel.org

Andres Meyer wrote:
> Hi,
> 
> I am trying to get an 2x Opteron system to work. As long as I use the 80GB 
> Maxtor installed on the integrated IDE controller, everything works fine. As 
> soon as I try to use the SATA disks, I get a machine check exception and the 
> system reboots, with the hw clock reset to some silly date.
> 
> This one here happened within ca. 7s when trying to write some zeros 
> (cat /dev/zero > test.file) to the first 160GB disk. On the disk, after 
> reboot, there was a very small test.file.
> 
> Interesting enough, it is possible to read the disks and even do a fsck on the 
> fs. It is also possible to run a script that writes a small file (eg the 
> current time) every 5s or so for several days. As I found some strange 
> behaviour at on port 3&4 on the siimage controller, I did not connect these 
> disks for now.
> 
> Any ideas? Something I could do to help?

The sata_sil driver is known to have problems at the moment.  Are you 
having problems with drives connected to the Promise controller as well? 
  That seems to be working fine on x86, but I wonder if there are 
problems on x86-64.

Can you try booting a 32-bit kernel to see if that changes your results?

	Jeff



