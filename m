From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 18:23:29 -0600
Message-ID: <46B90D01.6010703@shaw.ca>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no>
 <fa.Nj/igOoDE6GHsgyWFEo/9WCtE9c@ifi.uio.no>
 <fa.usmOl3OVQVx3VExwvKiQI5iAX5Q@ifi.uio.no>
 <fa.A9df+SR4FMdI7qZmsXY0xFyurbU@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <fa.A9df+SR4FMdI7qZmsXY0xFyurbU@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Tejun Heo <htejun@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 07 Aug 2007, Tejun Heo wrote:
>> Henrique de Moraes Holschuh wrote:
>>> On Tue, 07 Aug 2007, Tejun Heo wrote:
>>>> Michael Sedkowski wrote:
>>>>>> Hmmm... If the problem only shows up on nx6325, it might be that ACPI is
>>>>>> pulling unnecessary stunt.  Please apply the attached patch and report
>>>>>> when the disk spins down and up.
>>>>> Disk spins down on "Pre-shutdown prepare" and then goes up and down on
>>>>> "Power down".
>>>> Oh... crap, so acpi wants to sync cache on shutdown.  I wonder whether
>>>> it spins down the disk correctly.  Does emergency unload count increase
>>>> after each power down?  Also, please post the result of 'dmidecode'.
>>> You know, this actually make a lot of sense, and one can't even complain
>>> about firmware that pulls that off.
>> Well, I'm complaining.  I think the problem here is that it isn't clear
>> which one is who's responsibility.  There's a Korean saying which
> 
> The BIOS *has* to do it when in DOS mode, the HD manuals are very very clear
> about it.  Doing it through ACPI ATA objects is at least non-broken as far
> as these things go, as one knows when to do it directly ("non-ACPI mode"),
> and one doesn't talk to the disk directly.
> 
>> approximately translates into "if you have too many boatmen on a ship,
>> it goes to mountain".  We also have a bunch of Toshiba laptops which
> 
> Yeah, that's a problem.  But we can avoid it if we start snooping what ACPI
> is asking us to deliver to the disks, which IMO is an extremely good idea
> anyway.

Problem is I don't think we can do this. As far as I can tell, on my 
Compaq at least, it's not being done through ACPI AML in the DSDT, like 
in the _PTS function (which the kernel executes and can snoop), but when 
we actually do the power-off we write a value to a magic ACPI register. 
That likely triggers the BIOS to take control in SMM mode and access the 
controller directly before triggering the power off, which we have no 
control or knowledge of.

> 
>> want the ATA controller to be in enabled state when ACPI suspend is
>> invoked because the suspend method apparently wants to execute some
>> commands before going to sleep.
> 
> That's just broken, since it is not even using a OS-backed SATA/ATA ACPI
> method to do it.
> 
>> I wish ACPI spec carries a big fat sign saying "stay f*** away from
>> anything which isn't essential to the requested operation".
> 
> Shutting down disks *is* essential to the power off operation.  ACPI would
> have to mandate who is to do it, instead (ACPI table or OSI by itself).
> 
>>> Any chances of changing things
>>> so that we inspect/snoop all tasks sent to the device, and filter them
>>> out, or react to them accordingly?
>> No, we can't unless we snoop ACPI method execution and detect accesses
>> to IO ports or iomem regions.  It's not going through any driver.  This
>> is a gross mess.
> 
> I don't mean fixing the stuff clowns like Toshiba did.  The correct fix for
> that is to blacklist the hell out of that crap and patch their DSDT into
> something remotely sane.
> 
> I do mean snooping the ACPI methods that *return* a taskset to send to the
> driver, and we send that taskset ourselves in libata and libpata(?).
> 

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

