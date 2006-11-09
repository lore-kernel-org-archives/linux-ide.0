From: Jano <jasieczek@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 9 Nov 2006 19:01:02 +0100
Message-ID: <d9a083460611091001tfee2abauf4b5bce88eec1110@mail.gmail.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
	 <455360CF.9070600@cfl.rr.com> <455369C9.7020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:47576 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1424180AbWKISBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 13:01:41 -0500
Received: by py-out-1112.google.com with SMTP id a29so134552pyi
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 10:01:07 -0800 (PST)
In-Reply-To: <455369C9.7020909@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
> Phillip Susi wrote:
> >
> > Please stop discouraging top posting.  There is no reason to have to
> > scroll down through a screen or two of quoted message that you  just
> > read the original of, before getting to the new subject matter.
>
> Nope.
> http://www.zipworld.com.au/~akpm/linux/patches/stuff/top-posting.txt
>

I'm sorry to interrupt, but could you continue this discussion
elsewhere? We've begun to bottom-post in this topic, and let's
continue it this way. Fair enough?

>
> Mount(8) calls mount(2) no matter what is in the /etc/mtab.
>

So what should I actually post? 'cat /etc/mtab'? If so, here it is:

# cat /etc/mtab
/dev/hda3 / ext3 rw,errors=remount-ro 0 0
proc /proc proc rw 0 0
/sys /sys sysfs rw 0 0
varrun /var/run tmpfs rw 0 0
varlock /var/lock tmpfs rw 0 0
udev /dev tmpfs rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
devshm /dev/shm tmpfs rw 0 0
/dev/hda1 /boot ext3 rw 0 0
/dev/hda5 /usr ext3 rw 0 0


Best regards,
Jano
-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	http://stepien.com.pl
