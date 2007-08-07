From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 23:01:46 +0900
Message-ID: <46B87B4A.1020305@gmail.com>
References: <1186411815.4355.7.camel@nx6310>	 <20070806150159.GC31615@khazad-dum.debian.net>	 <200708061732.03425.rjw@sisk.pl> <46B75459.9020204@gmail.com>	 <1186424492.4355.1.camel@nx6310> <46B76BBC.9010107@gmail.com>	 <20070806234509.GC27640@khazad-dum.debian.net> <46B816FF.7060303@gmail.com>	 <20070807125104.GC30661@khazad-dum.debian.net> <46B86F21.4030805@gmail.com>	 <20070807131651.GE30661@khazad-dum.debian.net> <46B87457.4020704@gmail.com> <1186494328.8780.66.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1186494328.8780.66.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: trenn@suse.de
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, firmwarekit-discuss <firmwarekit-discuss@bughost.org>
List-Id: linux-ide@vger.kernel.org

Thomas Renninger wrote:
>>> I'd also suggest adding a FAIL to the Linux firmware toolkit to any DSDT
>>> doing this.  Who should we prod to add that check?
>> Dunno how the firmware toolkit works but this one can be pretty
>> difficult to test (if it were easy, we could test it in libata) as it
>> involves entering S5.  If it's possible, I'm all for it.  Also, it would
>> be nice if we can test the same thing for S3 and S4.
>>
>> Thomas, who should we ask things about the Linux firmware toolkit?  Thanks.
> 
> firmwarekit-discuss <firmwarekit-discuss@bughost.org> (added to CC list)
> see: http://linuxfirmwarekit.org/
> 
> But if I understand this problem right, this won't be easy.
> The ACPI tables are just parsed with system ("iasl ...") and syntactical
> errors/warnings are printed out.
> I also thought about a test, interpreting the DSDT and read out values
> of cpufreq tables and sanity check them. AFAIK the linuxfirmwarekit is
> not designed for that atm. You need to compile in most parts of the
> acpica code and parse and interpret DSDT/SSDT code yourself in the
> firmwarekit core or inside a plugin, then do a walk_namespace call or
> whatever to find the functions/parts you like to examine. This is a lot
> work and needs a proper design (providing an interface to plugins to let
> them easily check specific AML/ASL code).

Furthermore, we don't really know what we're looking for.  How can you
tell a given write to an ioport is issuing STANDBYNOW to an ATA disk or
trying to power the machine off?  Adding to the fun, many modern ATA
controller have more than one way to issue a command.  Maybe we can
match accesses inside regions specified by PCI BARs....  :-(

-- 
tejun
