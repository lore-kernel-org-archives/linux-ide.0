From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 13:06:29 +0100
Message-ID: <47B2DD45.7080709@keyaccess.nl>
References: <20080213001506.GA13933@kroah.com> <47B24AB3.3040009@keyaccess.nl> <20080213044436.GB10101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758152AbYBMMFB@vger.kernel.org>
In-Reply-To: <20080213044436.GB10101@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org
List-Id: linux-ide@vger.kernel.org

On 13-02-08 05:44, Greg KH wrote:

>> While details escape me somewhat again at the monment, a few months ago
>> I was playing around with a PCI Promise IDE controller and needed
>> ide=reverse to save me from having to switch disks around to still have
>> a bootable system.
>> 
>> Or some such. Not too clear anymore, but I remember it saved the day.
> 
> You couldn't just change the boot disk in grub?
> 
> Or use an initramfs and /dev/disk/by-id/ to keep any future moves stable?

No. The thing is that you need these kinds of hacks while messing with old 
systems, building and stripping them, often in recovery type of situations.

As said (same as the other person I saw reacting) details of what was most 
decidedly needed last time around escape me at the moment, but ide=reverse 
is the kind of hack that saves one hours of unscrewing computer cases and 
switching disks around while building stuff, making quick tests, doing 
recovery...

If it must go for the greater architectural good, so be it, but it's the 
type of thing that's used specifically in the situations where you don't 
have stable, well arranged (or known!) setups to begin with.

Rene.
