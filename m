From: Jaap Crezee <jaap@jcz.nl>
Subject: Re: Slow disks.
Date: Thu, 23 Dec 2010 20:10:38 +0100
Message-ID: <4D139EAE.9090307@jcz.nl>
References: <20101220141553.GA6088@bitwizard.nl> <20101220190630.66084e1d@neptune.home> <AANLkTi=VAJbVSzX_DH9_==a3RonLJmawYu3MzF-uqGXC@mail.gmail.com> <20101222104306.GB30941@bitwizard.nl> <x49aajxsrh3.fsf@segfault.boston.devel.redhat.com> <20101222224416.GE30941@bitwizard.nl> <x494oa48scp.fsf@segfault.boston.devel.redhat.com> <20101223170109.GA31591@bitwizard.nl> <x49bp4c7555.fsf@segfault.boston.devel.redhat.com> <AANLkTikbhzopmyfbJuHUQdEBJLLP9e65n0cNBuUjhDdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikbhzopmyfbJuHUQdEBJLLP9e65n0cNBuUjhDdd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Rogier Wolff <R.E.Wolff@bitwizard.nl>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/23/10 19:51, Greg Freemyer wrote:
 > On Thu, Dec 23, 2010 at 12:47 PM, Jeff Moyer<jmoyer@redhat.com>  wrote:
 > I suspect a mailserver on a raid 5 with large chunksize could be a lot
 > worse than 2x slower.  But most of the blame is just raid 5.

Hmmm, well if this really is so.. I use raid 5 to not "spoil" the storage space 
of one disk. I am using some other servers with raid 5 md's which seems to be 
running just fine; even under higher load than the machine we are talking about.

Looking at the vmstat block io the typical load (both write and read) seems to 
be less than 20 blocks per second. Will this drop the performance of the array 
(measured by dd if=/dev/md<x> of=/dev/null bs=1M) below 3MB/secs?

 > ie.
 > write 4K from userspace
 >
 > Kernel
 > Read old primary data, wait for data to actually arrive
 > Read old parity data, wait again
 > modify both for new data
 > write primary data to drive queue
 > write parity data to drive queue

What if I (theoratically) change the chunksize to 4kb? (I can try that in the 
new server...).

Jaap
