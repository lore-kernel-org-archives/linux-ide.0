From: Jano <jasieczek@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 9 Nov 2006 18:22:36 +0100
Message-ID: <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
	 <455360CF.9070600@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54404 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S966045AbWKIRXL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 12:23:11 -0500
Received: by py-out-1112.google.com with SMTP id a29so129495pyi
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 09:22:37 -0800 (PST)
In-Reply-To: <455360CF.9070600@cfl.rr.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
> Jano wrote:
> > I've compiled it into the kernel, but it doesn't work.
>
> But I guess, you either haven't mkinitrd'ed it or you don't have an initrd line
> in your loader config (I can't see any difference in dmesgs diff)?
>

It is quite possible. All I've done was:

# make all
# make modules_install
# make install

And update of /boot/grub/menu.lst. Additionally I've tried to do it using:

# make-kpkg --initrd kernel_image kernel_headers

And installing the deb package. Please correct me if I've made any mistakes.

2006/11/9, Phillip Susi <psusi@cfl.rr.com>:
> I didn't ask for /proc/mounts, I asked for the output of the mount
> command with no arguments, which prints the contents of /etc/mtab.  I
> was thinking that /etc/mtab might show the partitions as mounted even
> though they are not, which could be why mount is complaining.
>

Here you are, this is output of 'mount' while in recovery mode using
kernel 2.6.18.1

$ mount
 /dev/hda3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
/sys on /sys type sysfs (rw)
varrun on /var/run type tmpfs (rw)
varlock on /var/lock type tmpfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
devshm on /dev/shm type tmpfs (rw)
/dev/hda1 on /boot type ext3 (rw)
/dev/hda5 on /usr type ext3 (rw)

As you can see, no trace of /dev/hdb1.

Best regards,
Jano

-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	stepien.com.pl
