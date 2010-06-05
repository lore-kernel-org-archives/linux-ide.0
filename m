From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: Hang during boot, bisected to commit 96d60303fd
Date: Fri, 4 Jun 2010 21:45:50 -0400
Message-ID: <AANLkTinKqB95MvThlHShlT6snqf0fKHBuxgcPpNuslAb@mail.gmail.com>
References: <AANLkTiktNufXK_pn6mP2-zyowAIbHlUy5TGu3AtpALv-@mail.gmail.com>
	<20100603020006.GB19123@srcf.ucam.org>
	<AANLkTikpv86r5BBPCEOHujpm8uCgY0DxghSKjBufBWiM@mail.gmail.com>
	<4C08760B.8050002@gmail.com>
	<AANLkTimFY5YQv8DC-zTQ1RF84rno6svvcyLzHGWL6HOk@mail.gmail.com>
	<AANLkTimXcF1pafrSt8dMbUs59AjnqaRwpzDnPIPjdjsn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimXcF1pafrSt8dMbUs59AjnqaRwpzDnPIPjdjsn@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, garzik@redhat.com
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 4, 2010 at 9:37 PM, Robert Hancock <hancockrwd@gmail.com> w=
rote:
> =A0Fri, Jun 4, 2010 at 7:23 PM, Marc Dionne <marc.c.dionne@gmail.com>=
 wrote:
>> On Thu, Jun 3, 2010 at 11:42 PM, Robert Hancock <hancockrwd@gmail.co=
m> wrote:
>>> On 06/03/2010 07:21 PM, Marc Dionne wrote:
>>>>
>>>> On Wed, Jun 2, 2010 at 10:00 PM, Matthew Garrett<mjg59@srcf.ucam.o=
rg>
>>>> =A0wrote:
>>>>>
>>>>> On Wed, Jun 02, 2010 at 09:49:27PM -0400, Marc Dionne wrote:
>>>>>>
>>>>>> =A0 =A0Since somewhere early in the 2.6.35 merge window I've bee=
n seeing a
>>>>>> hang
>>>>>> =A0 =A0during boot. =A0The hang last roughly 30 seconds and is f=
ollowed by
>>>>>> this:
>>>>>>
>>>>>> =A0 =A0ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6=
 frozen
>>>>>> =A0 =A0ata4.00: failed command: READ FPDMA QUEUED
>>>>>> =A0 =A0ata4.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 nc=
q 4096 in
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 res 40/00:00:00:00:00/00:00:00:00:00/00 =
Emask 0x4 (timeout)
>>>>>> =A0 =A0ata4.00: status: { DRDY }
>>>>>> =A0 =A0ata4: hard resetting link
>>>>>> =A0 =A0ahci_is_device_present: status is: 80
>>>>>> =A0 =A0ahci_is_device_present: status(2) is: 3
>>>>>> =A0 =A0ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>>>>> =A0 =A0ata4.00: configured for UDMA/133
>>>>>> =A0 =A0ata4.00: device reported invalid CHS sector 0
>>>>>> =A0 =A0ata4: EH complete
>>>>>>
>>>>>> =A0 =A0The system works normally once booted. =A0I had some time=
 to do a
>>>>>> bisect
>>>>>> =A0 =A0today and it cleanly ended up pointing to this commit:
>>>>>> =A0 =A0 =A0 =A096d60303fd: ahci: Turn off DMA engines when there=
's no device
>>>>>> attached
>>>>>>
>>>>>> =A0 =A0Reverting the commit makes the system boot cleanly as bef=
ore. =A0System
>>>>>> has
>>>>>> =A0 =A0an Intel ICH10 based board, in AHCI mode, disk is an Inte=
l X25M SSD.
>>>>>
>>>>> Hm, interesting. Jeff, any immediate ideas? I don't see this beha=
viour
>>>>> on my ICH10. Is there actually a device on ata4?
>>>>>
>>>>> --
>>>>> Matthew Garrett | mjg59@srcf.ucam.org
>>>>
>>>> If it's helpful, attached are the dmesg output following a normal =
boot
>>>> and one with the hang.
>>>>
>>>> The only difference in the kernel used for those two boots is that=
 the
>>>> return statement in ahci_start_engine following the call to
>>>> ahci_is_device_present is commented out for the normal boot case.
>>>> When the return statement is active, the 30 second hang occurs.
>>>
>>> Can you try and put a printk in where it's returning out of the
>>> ahci_start_engine method? I wonder if that's getting triggered some=
where
>>> unexpected..
>>
>> Attached is a dmesg output with some printks added to show the statu=
s
>> when ahci_is_device_present causes ahci_start_engine to return early=
=2E.
>>
>> It looks to me like there's two passes through ahci_start_engine for
>> all ports, and during the first pass the port with the disk is showi=
ng
>> a status of 127, causing the function to return early and skipping t=
he
>> start DMA part. =A0This seems to cause the hang later on.
>>
>> I noticed that during this first pass all the print_id fields for th=
e
>> ports are still set to -1, so as a test I made ahci_start_engine onl=
y
>> do the check for ahci_is_device_present if print_id !=3D -1, and thi=
s
>> makes the system boot normally.
>
> Is that the right dmesg? I didn't see where the extra output was. It
> might be useful to put a WARN_ON(1); inside ahci_start_engine to see
> the two code paths where it's being called..

It's the right dmesg, look for lines containing
"ahci_is_device_present" or "ahci_start_engine" - sorry, I should have
pointed it out.

I'll try adding a WARN_ON to get the code paths.

Marc
