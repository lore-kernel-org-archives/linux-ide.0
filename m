From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Fri, 28 Sep 2007 02:45:59 -0700
Message-ID: <46FCCD57.2020507@gmail.com>
References: <46FC4384.7080607@df.uba.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46FC4384.7080607@df.uba.ar>
Sender: linux-acpi-owner@vger.kernel.org
To: solari@df.uba.ar, hgsolari@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

[restoring LKML and cc'ing linux-ide and linux-acpi]

Hernan Gustavo Solari wrote:
>     I am replying directly to you since, finding that most of the
> material in the kernel list is well beyond my understanding, I cancelled
> my subscription.
> 
>     You can forward as much of my replies to the list as you think it suits

You don't have to be subscribed to the list.  Just keep them cc'd.

>> Can you set up netconsole and collect the kernel log from the failing
>> boot and post it here?
> 
> Let me first update you on the issue. I installed the kernel 2.6.22.8
> when it was the latest stable release (today stable release is 2.6.22.9)
> Trying to reproduce the problem with this kernel I get a crash but
> different from that in the 2.6.22 kernel.
> 
> The kernel is compiled as it comes, with AMD64 generic option set and
> the small systems option set by me.
> 
> With acpi=off it runs.
> With acpi=on crashes after lines
> aer: probe of 0000:00:04.0:pcie01 failed with error 2
> aer: probe of 0000:00:05.0:pcie01 failed with error 2
> aer: probe of 0000:00:06.0:pcie01 failed with error 2
> aer: probe of 0000:00:07.0:pcie01 failed with error 2
> 
> With acpi=ht runs and complaints saying
> aerinit_init: AER service init fails - No ACPI _05C support
> aer: probe of 0000:00:04.0:pcie01 failed with error 1
> and the same message for the other probes.
> 
> The next line is:
> Real Time clock driver v1.12ac
> Linux agpgart interface v0.102 (c) Dave Jones
> Serial: 8250/16550 driver ....
> 
> 
> I have filled a ticket with respect to the ACPI problems, much of them
> can be avoided disabling part of the ACPI system.
> 
> Options: I can compile the 2.6.22 kernel to get the reported problem
>      or try to debug the problem in 2.6.22.8 or something else it
>       fits the kernel-team.
> 
> With respect to netconsole, the kernel parameter would be
> netconsole=[src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> According to
> http://www.mjmwired.net/kernel/Documentation/networking/netconsole.txt
> and based on kernel 2.6.22.1
> 
> and I cannot figure out what is [tgt-macaddr] "ethernet MAC address for
> logging agent (broadcast)"
> is it Internet Hardware address? (here
> Ethernet  HWaddr 00:0E:A6:5F:13:B2 ) or something else I cannot imagine?

Yes, correct, ethernet hardware address.  Things surrounded by brackets
are optional, BTW.

> PS: using netconsole may take me a few days since I do not have a
> network at home, I have to find the network at work available.

I see.  If you have access to a second machine, you can connect the two
directly.

Thanks.

-- 
tejun
