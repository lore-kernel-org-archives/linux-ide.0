From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 23 Feb 2007 09:41:01 +0100
Message-ID: <8d158e1f0702230041i7d3c28a4r202d9f8f628120f4@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
	 <45DAD8DA.4000108@gmail.com>
	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>
	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
	 <45DBEB63.3010905@gmail.com>
	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
	 <45DC46DF.8030704@gmail.com>
	 <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>
	 <45DE74CA.2010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:6461 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbXBWIlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 03:41:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so312301uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 00:41:07 -0800 (PST)
In-Reply-To: <45DE74CA.2010603@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 2/23/07, Tejun Heo <htejun@gmail.com> wrote:
>
> libata and ide use different methods to discover devices.  libata
> depends on reset to work.  After reset, devices are supposed to send
> diagnostic and the classfication code via TF registers.  OTOH, ide just
> issues IDENTIFY and then IDENTIFY PACKET to each device slot without
> resetting the channel.  Maybe we're doing something wrong in the pdc
> driver or the controller just doesn't like libata's probing method.

Extra info for you:

Tejun, you have way more libata experience as me, all of you do
probably and I don't question your theory but let me try to give you
my theory about why I think it's a drive or cable.

As you remember I have this onboard controller,also Promise, with
master and slave on one controller. And this works just fine, which
makes it kind of hard for me to believe that it is something in the
driver. Why would one bus work great and the other doesnt?

A very short summary for the gurus:

- The secundaiy bus on the onboard promise board wasnt in use yet, so
I connected the drives to this bus, and you can guess it, the drives
got detected by the BIOS but not by the drivers. So we can rule out at
least that my PCI-Add on Promise controller is broken and that we have
to look for the problem some where else.

- Legacy IDE drivers DO work, but, as you say yourself, they dont
depend on a drive reset,

- libata detects the drives, but only with one drive attached to the cable.

Now, taking the single drive operation working with libata and the old
ide drives not needing a reset to detect disks into account, plus this
information above in account: my theory.

What if, the Promise BIOS doesn't depend on this reset either?
What if the BIOS does something along the line of screaming "HELLO?!"
and the drives, both independent from each other yell back: "Ola, I am
a Seagate ST8whatever and I can do UDMA100", and the BIOS just takes
this for granted. With other words, what if the BIOS only cares for
the disk controller to be able to give its identification information
from the firmware, even if the platters are all to the moon? It
wouldn't  be the first time I see disks being detected by an ATA BIOS
and the disks being totally useless, not to mention, disks lying about
their capabilities,

Please note in past dmesg-es I sent that the legacy IDE drivers claim
how the native capacity of both drives is something like 102 petabyte.
Do disks these size exist even?
Based on what you tell me, the legacy IDE drivers tend to take things
for granted too, either it just reads what the ATA BIOS tells the
drivers or it does it own check, just by screaming "HELLO" and getting
the same "Ola" back from the drives.

Now, libata seems to be way more suffisticated and handles drives and
detection in a way more fancy matter. So, what if the machine boots
fine, less suffisticated BIOS "detects" the drives and its sizes and
now we boot the kernel. Libata does its stuff, does a reset of the bus
and *bang* a collision of some sort comes forth?

I checked the jumpers, changed them, changed the ATA bus even, nothing helps.
And even tho I changed the ATA cable allready, who guarantees me that
this cable is correct? With my luck, it isnt. Which is why I want to
just yank the cables from the other _working_ master and slave combo
and see how this goes.

Right now I am moving data from the "problem" disks to a safe
location, just to guarantee I dont fry my data in any sort.

Please let me know if my theory makes any sense or if I should cut on
the slibovica and palinka :)


Patrick
