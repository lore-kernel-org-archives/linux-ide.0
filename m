From: Brian O'Reilly <fade@deepsky.com>
Subject: SiL seagate errata fix...
Date: Sun, 16 Jan 2005 13:53:52 -0500
Message-ID: <41EAB840.4010609@deepsky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outrider.deepsky.com ([66.207.216.43]:60315 "HELO deepsky.com")
	by vger.kernel.org with SMTP id S262571AbVAPSyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2005 13:54:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@popox.com, linux-ide@vger.kernel.org

Apologies if this email is errant in terms of standard procedure. I'm 
following instructions in the header of sata_sil.c in cc'ing the list.

==

I'm running an amd64 system driven by Linux 2.6.x with gentoo userland 
on top of it. I have been running the gentoo-development kernels, as 
they're basically required for the amd64, although in this case there 
are no gentoo-specific patches to this source file. Once support for the 
SiL controller in my shuttle SN85G4 was added, it has been flawless, 
until 2.6.10.

Kernel compiles fine, but upon boot, the system hangs interminably until 
a reset (ctrl-alt-delete works). The last message to the screen is:

applying Seagate errata fix

... which is obviously from the sata_sil.c source, as uncovered by egrep. ;)

some relevant info from the system:

[Sun Jan 16 <13:44:50>]\>gcc -v
Reading specs from /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.3/specs
Configured with: /var/tmp/portage/gcc-3.4.3-r1/work/gcc-3.4.3/configure 
--enable-version-specific-runtime-libs --prefix=/usr 
--bindir=/usr/x86_64-pc-linux-gnu/gcc-bin/3.4.3 
--includedir=/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.3/include 
--datadir=/usr/share/gcc-data/x86_64-pc-linux-gnu/3.4.3 
--mandir=/usr/share/gcc-data/x86_64-pc-linux-gnu/3.4.3/man 
--infodir=/usr/share/gcc-data/x86_64-pc-linux-gnu/3.4.3/info 
--with-gxx-include-dir=/usr/lib/gcc/x86_64-pc-linux-gnu/3.4.3/include/g++-v3 
--host=x86_64-pc-linux-gnu --disable-altivec --enable-nls 
--without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu 
--with-system-zlib --disable-checking --disable-werror 
--disable-libunwind-exceptions --enable-shared --enable-threads=posix 
--enable-multilib --disable-libgcj --enable-languages=c,c++,f77
Thread model: posix
gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)

... I used the kernel config from my running 2.6.9 kernel to generate 
the 2.6.10 boot image. If you would like to see it, or any other piece 
of information, I would be happy to oblige.

Thanks for the good work. =)

Brian O'Reilly
DeepSky Systems
