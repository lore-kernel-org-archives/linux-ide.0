From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Sun, 18 Mar 2007 15:26:24 -0300
Message-ID: <20070318182624.GA29422@khazad-dum.debian.net>
References: <20070315031015.GA6292@khazad-dum.debian.net>
	<20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <45FCD062.3050001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sun, 18 Mar 2007, Tejun Heo wrote:
> Kristen Carlson Accardi wrote:
> >> 1. It will handle all device types (ATAPI, PATA, SATA, batteries);
> >>
> >> 2. It will do the right thing on plug and unplug.  This means telling the
> >> rest of the kernel to disable the device in the bay, for example.  Right now
> >> we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
> >> leave libata to scream blood murder until it disables its end due to too
> >> many retries, for example;
> 
> :-)

Yeah :)  Try it with old ide, and the results are not... pretty.  libata new
EH *rules*.

> > Personally - I think tighter integration to libata here would be beneficial.
> > Once libata acpi support is straightened out, if we can store acpi handles
> > associated with libata devices, we can perhaps have a mechanism of obtaining
> > ata_device structs so that we can have a nice way of telling libata to 
> > delete devices etc.  I am hoping libata-acpi will be straightened out for
> > 2.6.22.
> 
> I dunno what the thread is really about but can't this be dealt within
> acpid?  Finding out the correct scsi host node can be tricky but I think

It could, yes.

But to me the kernel looks like the proper place for this one.  Not to
mention that we *really* should know the ACPI namespace -> kernel device
mapping in kernel, instead of doing half-assed things in userspace to call
back into kernel land later... it may come in handy for other things (proper
ACPI/driver exclusion of access to devices, for one), not just libata
matters and dock/bay ejects.

It is not like it is a policy thing.  The only possible correct path to
follow when doing an eject is to disable the devices and buses in the "it
will be powered off" side of the ejection hardware.  And depending on
userspace for this is just (IMHO) ugly and error-prone.  The kernel really
should know how to do it, and doing it is *easy* as long as you know the
mapping (which you should know for other reasons).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
