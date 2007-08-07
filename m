From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 22:32:07 +0900
Message-ID: <46B87457.4020704@gmail.com>
References: <1186411815.4355.7.camel@nx6310> <20070806150159.GC31615@khazad-dum.debian.net> <200708061732.03425.rjw@sisk.pl> <46B75459.9020204@gmail.com> <1186424492.4355.1.camel@nx6310> <46B76BBC.9010107@gmail.com> <20070806234509.GC27640@khazad-dum.debian.net> <46B816FF.7060303@gmail.com> <20070807125104.GC30661@khazad-dum.debian.net> <46B86F21.4030805@gmail.com> <20070807131651.GE30661@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070807131651.GE30661@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-ide@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Tue, 07 Aug 2007, Tejun Heo wrote:
>> Henrique de Moraes Holschuh wrote:
>>>> approximately translates into "if you have too many boatmen on a ship,
>>>> it goes to mountain".  We also have a bunch of Toshiba laptops which
>>> Yeah, that's a problem.  But we can avoid it if we start snooping what ACPI
>>> is asking us to deliver to the disks, which IMO is an extremely good idea
>>> anyway.
>> If it were done that way (by asking OS driver to deliver commands TFs),
>> I wouldn't have any problem at all.  The spin down command is issued
>> from deep down in the acpi power off method - entering S5 directly
>> issues ATA commands bypassing the whole OS except for the ACPI
>> interpreter.  It's just like the toshiba suspend crap and there's no
>> standard way to tell whether the acpi power off method is gonna do it or
>> not.  We'll just have to blacklist it.
> 
> Urk. I see.
> 
> I'd also suggest adding a FAIL to the Linux firmware toolkit to any DSDT
> doing this.  Who should we prod to add that check?

Dunno how the firmware toolkit works but this one can be pretty
difficult to test (if it were easy, we could test it in libata) as it
involves entering S5.  If it's possible, I'm all for it.  Also, it would
be nice if we can test the same thing for S3 and S4.

Thomas, who should we ask things about the Linux firmware toolkit?  Thanks.

-- 
tejun
