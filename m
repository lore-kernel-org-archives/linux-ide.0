From: Gerald Hopf <gerald.hopf@nv-systems.net>
Subject: Re: sata_sil problems (lockup at boottime)
Date: Mon, 06 Dec 2004 23:16:23 +0100
Message-ID: <41B4DA37.5060209@nv-systems.net>
References: <41B2499E.1080905@nv-systems.net>	 <200412050908.33124.bausi@bausi.org> <58cb370e04120508104243799a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nv-systems.net ([62.75.252.178]:62592 "EHLO mail.nv-systems.net")
	by vger.kernel.org with ESMTP id S261679AbULFWQX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Dec 2004 17:16:23 -0500
In-Reply-To: <58cb370e04120508104243799a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello everyone,

i'm using this post to answer to multiple questions of more than one 
person, so bear in mind that the quotes are not all from the same 
person/post.

Oliver Bausinger wrote:

>>I have the same problem with this hardware. The harddisk is a SAMSUNG SP1614C
>>again and the controller is this one:
>>    
>>
Great ! I really like the idea that i'm not the only one with this 
problem :-)

Oliver Bausinger wrote:
>> I tried quite a lot to get rid of those problems, including:
>> - Flashing a new/different Bios (even with different versions of the
>> Silicon Image SATA Bios part: 4.2.47 and 4.2.50)

>Where did you get it? URL?

I got it from here: http://homepage.ntlworld.com/michael.mcclay/
It's the "A7N8X-Dlx Uber 1009-BETA Sata Enhanced with new SATA bios v4.2.50  <- new (20th nov 04)".

I read about this Bios in the http://www.nforcershq.com/ Forums.

Works fine, but didn't change much (well, actually, it changed nothing regarding this problem...).

Bartlomiej Zolnierkiewicz wrote:

>Looks like some other device is using the same IRQ
>(it is not handled correctly and gets disabled).
>
>  
>
On my system, according to the lspci command no IRQs are shared. Only 4 
IRQs are in use, and none of them shared (with all the onboard stuff 
disabled).

Oliver Bausinger wrote:

>>I think I can rule out hardware problems because a FreeBSD 5.3 install
>>worked flawlessly on this disk.
>>    
>>
Same here, this hardware combination has worked absolutely flawless in 
Windows XP for months!

I wrote and Bartlomiej Zolnierkiewicz commented/asked:

>>>This problem has been there in all of the latest 2.6.X kernel revisions.
>>>I'm currently using 2.6.10-rc3 (which came out today), but i've allready
>>>had this problem in 2.6.9 and 2.6.8 and probably even 2.6.7 if i
>>>remember correctly.
>>>      
>>>
>Was it working before 2.6.7?
>  
>
I only recently tried to make this work, so i was not sure about this.
Therefor I just did some (time-consuming) tests with all Kernels between 
2.6.5 and 2.6.10-rc3:

Kernel 2.6.5:
- Bootet once and seemed to work, however only ONCE! Unable to reproduce 
this even with many reboots.
- (also i am not 100% sure if it actually worked this ONE time, cfdisk 
claimed the disk had no partitioning information on it which i thought 
it should have had... partitioning and reiserfs-formating worked fine 
though)
- In all following boots, the same strange errors, but continued to boot.
- Pictures of the strange errors and continued booting:
- http://www.nv-systems.net/pics/lkml/sata_sil4.jpg (page 1)
- http://www.nv-systems.net/pics/lkml/sata_sil5.jpg (page 2)
- http://www.nv-systems.net/pics/lkml/sata_sil6.jpg (same as page 2 but 
slightly different error from another try)
- After booting, harddrive does not respond, commands which access it 
(like cfdisk or mount) hang forever.

Kernel 2.6.6:
- Same as 2.6.5, except it didn't even work once.

Kernel 2.6.7:
- Same as 2.6.5, except it didn't even work once.

Kernel 2.6.8.1:
- Same as 2.6.5, except it didn't even work once.

Kernel 2.6.9:
- Hangs during bootup, like described in my original Post here!

Kernel 2.6.10-rc3
- Same behaviour as in 2.6.9

I also tried the depreciated siimage driver (thanks to the 
CONFIG_BLK_DEV_IDE_SATA tip, i didn't notice this before and had the 
same problems) with kernel 2.6.9,
works flawless (as far as i can tell from such a short test, hdparm -t = 
60MB/s). No strange IRQ disabled errors during bootup. Flawless of 
course only if you ignore that it takes AGES until it finally gives up 
probing the second SATA port. I know someone who bought a second SATA 
harddrive just because booting took so long!

I guess i should switch to a more PROMISing SATA controller as soon as 
possible... ;-)

Yours sincerely,
                  Gerald Hopf
