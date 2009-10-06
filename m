From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 15:25:37 +0300
Message-ID: <4ACB3741.2030101@gmail.com>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932469AbZJFMeO@vger.kernel.org>
In-Reply-To: <4ACA6904.1060509@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Bernie Innocenti <bernie@codewiz.org>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Bernie Innocenti wrote:
>> The error in the subject appears in the console immediately followed bv
>> a hard freeze of the machine.  The error occurs reproducibly on two
>> identical Opteron servers, each one equipped with two identical
>> controller cards:
>>
>> 03:04.0 SCSI storage controller: Marvell Technology Group Ltd. 
>> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>> 03:06.0 SCSI storage controller: Marvell Technology Group Ltd. 
>> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>>
>> We can trigger the problem within a few seconds by starting a
>> reconstruction on a drive hooked to port 4 (counting from 0) of the
>> second controller.  Oddly, every other drive works reliably and the
>> faulty drive works if we connect it to, for example, port 4 of the first
>> controller.
>>
>> Tested with Debian kernels 2.6.26-19 and 2.6.30-8.  Let me know if
>> further details are needed.
> ..
>> 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040..
> ..
>
>  0x30000040 here means "MRdPerr":
>    "bad data parity detected during PCI master read".
>
> Which means there that a data parity error happened
> during outgoing data transfer on the PCI-X bus.
> This could happen due to noise on the bus,
> dying capacitors, or (?) bad RAM (not sure about the last one).
>
I have heard same thing happened with same kind of configuration, using 
Supermicro H8DME-2 motherboard, Opteron 2378 CPU.

Even the controllers were on same slots.

My initial suspicion was that the motherboard does not drop the PCI-X 
bus frequency to 100MHz and drives the bus at 133MHz even though there 
are 2 controllers connected. Proposed fix was to move the other 
controller to other bus, as the H8DME-2 has four PCI-X slots, 2x100MHz 
and 2x133MHz, but I haven't yet heard back if it helped.

Even the kernel was same - latest Debian distribution kernel. Might be 
worthwile to try using vanilla kernel.org kernel if possible.

I have at home two 6081 controllers at same bus but at 100MHz and no 
problems yet.

-- 
Harri.
