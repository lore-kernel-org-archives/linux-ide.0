From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in linux kernel when playing DVDs.
Date: Fri, 30 Jan 2004 20:46:59 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <401AC2C3.6010701@superbug.demon.co.uk>
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua> <3EAE220D.4010602@cyberone.com.au> <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua> <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk> <3EAFEA83.9030301@superbug.demon.co.uk> <20030430164641.GA8731@eskimo.com> <20030524204548.GA1552@eskimo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090608050806050802050901"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:18440 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S263571AbUA3Upu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2004 15:45:50 -0500
In-Reply-To: <20030524204548.GA1552@eskimo.com>
List-Id: linux-ide@vger.kernel.org
To: Elladan <elladan@eskimo.com>, linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua, Nick Piggin <piggin@cyberone.com.au>

This is a multi-part message in MIME format.
--------------090608050806050802050901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Elladan wrote:
> On Wed, Apr 30, 2003 at 09:46:41AM -0700, Elladan wrote:
> 
>>On Wed, Apr 30, 2003 at 04:23:47PM +0100, James Courtier-Dutton wrote:
>>
>>>Alan Cox wrote:
>>>
>>>>NOTABUG
>>>>
>>>>User space keeps asking it to read so it keeps using CPU, fix the user
>>>>space
>>>
>>>The application does an initial seek() command, which succeeds.
>>>It then just does read() commands for then on.
>>>For bug tracking, I have put printf statements in my application.
>>>I.e.
>>>
>>>[...]
>>>
>>>When an error occurs on the DVD, "read done" message is never printed on 
>>>the console and all applications fail to respond to user input. This is 
>>>why I thought that the kernel hogs CPU 100% and the application never 
>>>receives the error message.
>>>If I force a different error "tray open", by using a pin in the manual 
>>>eject hole on the front of the dvd rom device, I then see the "read 
>>>done" message and everything comes back to life.
>>
>>Are you sure it never returns, ever?
>>
>>The behavior most people seem to see here 90% of the time seems to be
>>that the IDE layer retries the request a few dozen times before
>>returning an error result.  This usually takes 1-5 minutes.
> 
> 
> Say, does this lame hack help at all?  I got so annoyed with the ide-cd
> driver the other night that I hacked this garbage in during the middle
> of a movie.  After patching, you load the module, possibly with a value,
> and it changes the max number of retries ide-cd will attempt on an
> error.
> 
> Numbers like 0 or 1 may be good.
> 
> Or maybe I'm just dreaming and this patch does nothing, because my
> hardware suddenly started working better.  It does that sometimes.  :-)
> 
> -J
> 
> 

I have not yet tried the patch, because I run kernel 2.6.2 at the moment.
I have concluded that the kernel (not user space) is doing some kind of 
read-ahead caching.
Example of a read happening correctly: -
bash-2.05b# dd if=/dev/dvd of=error.img skip=1598700 count=1
1+0 records in
1+0 records out

Example of a read failing, both on the same DVD, just different sectors.
bash-2.05b# dd if=/dev/dvd of=error.img skip=1598740 count=1
dd: reading `/dev/dvd': Input/output error
0+0 records in
0+0 records out
See attachment for output from dmesg for this single command.

As you can see, the read() call is at least returning now with kernel 
2.6.2, which did not happen with whichever previous kernel I tested 
with. The first error message arrives in the kernel log about 1 second 
after the request which is fine. We could work around that in the user 
space DVD player, but at the moment, the return takes about 20 seconds. 
20 seconds is an unacceptable break in the playing of a DVD.

As the kernel is at least returning control to the application, I can at 
least program some recovery logic into the linux dvd player now.

I think that this problem would be fixed if the kernel would stop the 
read-ahead function as soon as an error is seen, and thus pass control 
back to the application as soon as possible. read-ahead caching should 
only be enabled again on the next disc read() or lseek() request from 
user space.

Summary: -
If we could get the read() call to return as soon as the first error 
message arrives in the dmesg linux would play DVDs much better.

Cheers
James

--------------090608050806050802050901
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598736
Buffer I/O error on device hda, logical block 199842
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598744
Buffer I/O error on device hda, logical block 199843
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598752
Buffer I/O error on device hda, logical block 199844
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598760
Buffer I/O error on device hda, logical block 199845
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598768
Buffer I/O error on device hda, logical block 199846
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598776
Buffer I/O error on device hda, logical block 199847
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598784
Buffer I/O error on device hda, logical block 199848
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598792
Buffer I/O error on device hda, logical block 199849
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598800
Buffer I/O error on device hda, logical block 199850
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598808
Buffer I/O error on device hda, logical block 199851
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598816
Buffer I/O error on device hda, logical block 199852
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598824
Buffer I/O error on device hda, logical block 199853
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598832
Buffer I/O error on device hda, logical block 199854
hda: command error: status=0x51 { DriveReady SeekComplete Error }
hda: command error: error=0x54
end_request: I/O error, dev hda, sector 1598840
Buffer I/O error on device hda, logical block 199855

--------------090608050806050802050901--
