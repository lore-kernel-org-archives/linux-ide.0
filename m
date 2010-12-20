From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Slow disks.
Date: Mon, 20 Dec 2010 13:32:44 -0500
Message-ID: <AANLkTi=VAJbVSzX_DH9_==a3RonLJmawYu3MzF-uqGXC@mail.gmail.com>
References: <20101220141553.GA6088@bitwizard.nl> <20101220190630.66084e1d@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101220190630.66084e1d@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 20, 2010 at 1:06 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> Hi,
>
> [ccing linux-ide]
>
> Please provide the part of kernel log showing initialization of your
> disk controller(s) as well as detection of all the discs.
> Verbose lspci output for the disc controller and $(smartctl -i -A $di=
sk)
> output might be useful as well.
>
> Did you try the individual discs on a completely different system (e.=
g.
> plain desktop system) and what revision of SATA are both components
> supporting?
>
> Bruno
>
>
> On Mon, 20 December 2010 Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:
>> Hi,
>>
>> A friend of mine has a server in a datacenter somewhere. His machine
>> is not working properly: most of his disks take 10-100 times longer
>> to process each IO request than normal.
>>
>> iostat -kx 10 output:
>> Device: rrqm/s wrqm/s r/s =A0w/s =A0rkB/s wkB/s avgrq-sz avgqu-sz aw=
ait svctm %util
>> sdd =A0 =A0 0.30 =A0 0.00 =A0 0.40 1.20 2.80 =A01.10 =A04.88 =A0 =A0=
 0.43 =A0271.50 271.44 =A043.43
>>
>> shows that in this 10 second period, the disk was busy for 4.3 secon=
ds
>> and serviced 15-16 requests during that time.
>>
>> Normal disks show "svctm" of around 10-20ms.
>>
>> Now you might say: It's his disk that's broken.
>> Well no: I don't believe that all four of his disks are broken.
>> (I just showed you output about one disk, but there are 4 disks in t=
here
>> all behaving similar, but some are worse than others.)
>>
>> Or you might say: It's his controller that's broken. So we thought
>> too. We replaced the onboard sata controller with a 4-port sata
>> card. Now they are running off the external sata card... Slightly
>> better, but not by much.
>>
>> Or you might say: it's hardware. But suppose the disk doesn't proper=
ly
>> transfer the data 9 times out of 10, wouldn't the driver tell us
>> SOMETHING in the syslog that things are not fine and dandy? Moreover=
,
>> In the case above, 12kb were transferred in 4.3 seconds. If CRC erro=
rs
>> were happening, the interface would've been able to transfer over
>> 400Mb during that time. So every transfer would need to be retried o=
n
>> average 30000 times... Not realistic. If that were the case, we'd
>> surely hit a maximum retry limit every now and then?
>>
>>
>> These syptoms started when the system was running 2.6.33, but are
>> still present now the system has been upgraded to 2.6.36.
>>
>> Is there anything you can suggest to get to the root of this problem=
?
>> Could this be a software issue with the driver? Can we enable some
>> driver debugging to find out what is wrong?
>>
>> Any help will be appreciated.
>>
>> =A0 =A0 =A0 Roger.

My personal guess would definitely be hardware.  The only common
component I can think of is power.  SATA is very sensitive to
requiring high-quality power.  Much more so than IDE.

Greg
