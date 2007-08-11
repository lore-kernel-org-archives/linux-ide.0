From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Fri, 10 Aug 2007 20:21:19 -0600
Message-ID: <46BD1D1F.70707@shaw.ca>
References: <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
 <fa.3VfWxxgY+5IvJGIam0al/rUn/Q4@ifi.uio.no>
 <fa.WVQYJNYB2uuhgQFoGpK6eCfWazo@ifi.uio.no>
 <fa.5IFtia9VWM6ePZjGzb+WVMoHQCY@ifi.uio.no>
 <fa.M8tTjYMrntIRJ5aXHPFPjCNEk6k@ifi.uio.no>
 <fa.IDurvYCLZ5ArGLsuNcLC3l1CSqQ@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <fa.IDurvYCLZ5ArGLsuNcLC3l1CSqQ@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
To: trenn@suse.de
Cc: Pavel Machek <pavel@ucw.cz>, Tejun Heo <htejun@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, firmwarekit-discuss <firmwarekit-discuss@bughost.org>
List-Id: linux-ide@vger.kernel.org

Thomas Renninger wrote:
> On Thu, 2007-08-09 at 15:16 +0000, Pavel Machek wrote:
>> Hi!
>>
>>>> firmwarekit-discuss <firmwarekit-discuss@bughost.org> (added to CC list)
>>>> see: http://linuxfirmwarekit.org/
>>>>
>>>> But if I understand this problem right, this won't be easy.
>>>> The ACPI tables are just parsed with system ("iasl ...") and syntactical
>>>> errors/warnings are printed out.
>>>> I also thought about a test, interpreting the DSDT and read out values
>>>> of cpufreq tables and sanity check them. AFAIK the linuxfirmwarekit is
>>>> not designed for that atm. You need to compile in most parts of the
>>>> acpica code and parse and interpret DSDT/SSDT code yourself in the
>>>> firmwarekit core or inside a plugin, then do a walk_namespace call or
>>>> whatever to find the functions/parts you like to examine. This is a lot
>>>> work and needs a proper design (providing an interface to plugins to let
>>>> them easily check specific AML/ASL code).
>>> Furthermore, we don't really know what we're looking for.  How can you
>>> tell a given write to an ioport is issuing STANDBYNOW to an ATA disk or
>>> trying to power the machine off?  Adding to the fun, many modern ATA
>>> controller have more than one way to issue a command.  Maybe we can
>>> match accesses inside regions specified by PCI BARs....  :-(
>> Hmmm... perhaps we should do it the other way. ACPI is allowed to
>> touch the embedded controller, what else? Maybe we should warn as soon
>> as API touches non-EC I/O port?
> 
> This is not working...
> ACPI can and does access all kind of other I/O ports and other
> resources.
> Hmm, are the disk accesses done by ACPI via OperationRegion/Field
> declared variables?
> I try to get a check for those clashing with native drivers (hopefully
> this approach is successful for 2.6.24, can't say for sure yet), I
> wonder whether this one would give a warning like "Libata driver is
> using the same SystemIO/SystemMem resources than ACPI OperationRegion
> declaration XY".
> This would not solve the problem, but at least show the need of such a
> test. Such ACPI vs native driver interference problems are very hard
> nuts (in identifying and solving).
> 
> Can someone post an ASL code snippet how ACPI actually access the disk
> and in which parts/functions, pls.

Again, it's not believed that this is being done via AML, but via a BIOS 
SMM trap on the ACPI sleep state hardware IO port. We have no real 
ability to find out what the BIOS is doing or prevent it in this case.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

