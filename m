From: Eric Mudama <edmudama@gmail.com>
Subject: Re: Kernel 2.6.9 undecoded slave problem, fixed in 2.6.10-rc2-bk8!
Date: Thu, 2 Dec 2004 14:53:39 -0700
Message-ID: <311601c904120213533b67ed3a@mail.gmail.com>
References: <Pine.LNX.4.61.0412020925040.25494@p500>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261776AbULBV4D@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412020925040.25494@p500>
Sender: linux-kernel-owner@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Um... if it happens on one controller and not another, the bug
shouldn't be in the drives themselves.  Every Maxtor drive ever made
has a unique serial number, and the ones people are seeing are
completely invalid.

This issue should be root caused, something is getting stomped on, and
it may affect more than just the ID of the drive.  I fear that these
are bandaids covering some underlying issue.

--eric


On Thu, 2 Dec 2004 09:27:20 -0500 (EST), Justin Piszcz
<jpiszcz@lucidpixels.com> wrote:
> The interesting part of all of this is that this only occurs when I have
> the two cdroms on a promise controller, on the same IDE channel, normally
> I have them both on the motherboard as master and slave.  I wanted to make
> sure the card worked however, so switched the connection over to the
> promise board and then I am getting the same error as the guy above,
> except in my case it is with two identical CDROMS and not hard drives.
> 
> The problem occurs with 2.6.9.
> 
> -------------------------------------------------------------------------
> 
> Update: With 2.6.10-rc2-bk8, it has fixed the problem!
> 
> hde: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
> hdf: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
> ide2 at 0xd8f8-0xd8ff,0xd8f2 on irq 11
> hde: ATAPI 40X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.20
> hdf: ATAPI 40X CD-ROM drive, 128kB Cache
> Probing IDE interface ide3...
> 
> root@p500b:~# mount /dev/hde /mnt/cd1
> mount: block device /dev/hde is write-protected, mounting read-only
> root@p500b:~# mount /dev/hdf /mnt/cd2
> mount: block device /dev/hdf is write-protected, mounting read-only
> root@p500b:~#
