From: Tobias Rittweiler <inkognito.anonym@uni.de>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Date: Tue, 9 Jul 2002 14:43:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <01742490.20020709144349@uni.de>
References: <20020709102249.GA20870@suse.de>
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020709102249.GA20870@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello Jens,

Tuesday, July 9, 2002, 12:22:49 PM, you wrote:

JA> *.kernel.org://pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/

After downloading each of the 7 .gz-patches, applying them without any
complains, I started to compile the new bzImage, but I got an error
in relation to the FAT support. By switching this support off
everything'll compile without any further problem though, and I can
boot from this image even.. :-)

<out of subject>
Before appending the error messages I want to know if `shm' is named
`shmem' in 2.5 (it seems so anyway)?
</out of subject>

Hope it will be fixed ASAP.

FYI:
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y

Make's complaints:
====================
make[1]: Entering directory `/usr/src/linux-2.5.25/scripts'
make[1]: Leaving directory `/usr/src/linux-2.5.25/scripts'
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Entering directory `/usr/src/linux-2.5.25/init'
  Generating /usr/src/linux-2.5.25/include/linux/compile.hdnsdomainname: Host name lookup failure
 (unchanged)
make[1]: Leaving directory `/usr/src/linux-2.5.25/init'
make[1]: Entering directory `/usr/src/linux-2.5.25/kernel'
make[1]: Leaving directory `/usr/src/linux-2.5.25/kernel'
make[1]: Entering directory `/usr/src/linux-2.5.25/mm'
make[1]: Leaving directory `/usr/src/linux-2.5.25/mm'
make[1]: Entering directory `/usr/src/linux-2.5.25/fs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/devfs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/devfs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/devpts'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/devpts'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/driverfs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/driverfs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/ext2'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/ext2'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/ext3'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/ext3'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/fat'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/fat'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/isofs'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/isofs'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/jbd'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/jbd'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/nls'
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/nls'
make[2]: Entering directory `/usr/src/linux-2.5.25/fs/partitions'
  gcc -Wp,-MD,./.msdos.o.d -D__KERNEL__ -I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=msdos -DEXPORT_SYMTAB  -c -o msdos.o msdos.c
In file included from msdos.c:32:
/usr/src/linux-2.5.25/include/linux/ide.h:651: field `taskfile' has incomplete type
/usr/src/linux-2.5.25/include/linux/ide.h:652: field `hobfile' has incomplete type
make[2]: *** [msdos.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.25/fs/partitions'
make[1]: *** [partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.25/fs'
make: *** [fs] Error 2


-- 
cheers,
  Tobias

http://freebits.org

