From: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Tue, 20 Mar 2007 17:16:36 +0100
Message-ID: <20070320161636.GC6079@homac2.suse.de>
References: <20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
	<20070319134822.GA4885@homac2.suse.de>
	<20070319140403.GA3697@srcf.ucam.org>
	<20070319143746.GC4885@homac2.suse.de>
	<20070319111109.1a62740b.kristen.c.accardi@intel.com>
	<20070320160707.GB6079@homac2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070320160707.GB6079-tB0uoaAy/Z1bpigZmTR7Iw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue 20. Mar - 17:07:07, Holger Macht wrote:
> On Mon 19. Mar - 11:11:09, Kristen Carlson Accardi wrote:
> > On Mon, 19 Mar 2007 15:37:46 +0100
> > Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org> wrote:
> > 
> > > Sure. What actually bothers me is that in its current state, the dock
> > > station driver signals 'green' on the dock station as soon as the user
> > > presses the hardware undock button, but regardlessly of anything else. I
> > > think it would be ok to let the ACPI undock event up to userspace because
> > > in many situations it knows best when it is save to undock.
> > 
> > I disagree - as I mentioned, not all laptops actually let you (userspace)
> > control the undock process because they don't lock.  The dock driver
> > does notify user space of an undock, before it actually undocks:
> 
> Yes, I know that, but userspace won't have enough time to interact with
> the user in this case. I just imagine having an external disk connected to
> the usb port of the docking station. In the moment the user undocks, his
> unsynced or unwritten data is lost because the usb port gets
> disconnected. The user needs the knowledge to actually "save remove" the
> external disk before he undocks. You are right, this won't help in case
> the dock station has no indication when it is "safe" to undock. 

This mail was accidentially sent a little bit too early ;-)

What I wanted to add is just that with letting it up to userspace, it
would also work in all cases, with or without lock, it would just give
userspace more possibilities and might be more convenient for those
systems where the dock station locks the machine. But I clearly see the
advantage of not needing a userspace helper and for getting this docking
thing to work in 99% of all cases ;-)

Regards,
	Holger

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
