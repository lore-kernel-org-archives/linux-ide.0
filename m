From: Vlad Codrea <VladCodrea@mail.utexas.edu>
Subject: Re: CD problems booting FC7 RC3
Date: Fri, 06 Apr 2007 21:55:28 -0500
Message-ID: <46170820.2000105@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironmaiden.mail.utexas.edu ([128.83.32.53]:25692 "EHLO
	ironmaiden.mail.utexas.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965194AbXDGCzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2007 22:55:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: linux-ide@vger.kernel.org

Hi Steve,

 > Do you know if this patch has been put into the mainline kernel?

Yes, it's in the mainline 2.6.21-rc6 kernel.

 > I got
 > this problem when trying to boot the Fedora Core 7 RC3 livecd - so I
 > really can't make a new kernel and test it.

If your HP N5430 laptop has a floppy drive, I suggest you install a 
minimal Linux distro through that. While tracking down a CD drive error, 
I found that Debian works well for compiling kernels and testing 
patches. Here are the steps:

Download boot.img, root.img, net-drivers-1.img, and net-drivers-2.img 
from 
http://http.us.debian.org/debian/dists/sid/main/installer-i386/current/images/floppy 
. Write each image to a different floppy using the command "dd 
if=XXX.img of=/dev/fd0 bs=1024 conv=sync ; sync". Boot from the boot 
floppy and follow the installation directions.

Once the system is up, install the following apps:
# apt-get install wget automake bzip2 gzip gcc kernel-package patch tar

Download and unpack the latest kernel:
# wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.20.tar.bz2
# tar -xvf linux-2.6.20.tar.bz2
# cd linux-2.6.20
# wget http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.21-rc6.bz2
# bunzip2 patch-2.6.21-rc6.bz2
# patch -p0 < patch-2.6.21-rc6

Download a .config file that specifies libata drivers:
# wget http://marc.info/?l=linux-ide&m=117391341014871&q=p4
# mv index.html\?l\=linux-ide .config

Compile and install the kernel:
# make-kpkg  kernel_image --initrd &
# dpkg --install ../linux-image-2.6.21-rc6_2.6.21-rc6-10.00.Custom_i386.deb

Reboot.

 > Also it takes
 > over an hour to build the kernel on my laptop

The initial compilation does take awhile, but subsequent compilations 
(ie. after applying a patch) should only take a couple of minutes.

Vlad
