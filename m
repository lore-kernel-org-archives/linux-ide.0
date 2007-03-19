From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 11:17:45 -0700
Message-ID: <20070319111745.faa38198.kristen.c.accardi@intel.com>
References: <20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com>
	<20070318082751.GA28591@homac2>
	<20070318183652.GB29422@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070318183652.GB29422@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 18 Mar 2007 15:36:52 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Sun, 18 Mar 2007, Holger Macht wrote:
> > those ThinkPads where it is needed. Afterwards it does the corresponding
> > dock/undock request on ibm_acpi. And this works reliably good what I can
> > see from the feedback I already got. But for this to work, userspace would
> 
> It should work with the generic bay device too, but I have no ideas about
> dock.  But you'll need to deal with udev with the new bay device, something
> I am not too happy about.  These things are ACPI events, they should remain
> so unless all other ACPI events are going to become uevents.

So ACPI is just a mechanism - an implementation detail in the kernel.  I
don't think we should have special ACPI events to deal with bay/dock activity.
If for whatever reason we ever dock something without using ACPI, we can
make this transparent to userspace.  
