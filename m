From: Holger Macht <hmacht@suse.de>
Subject: Re: CONFIG_IBM_BAY
Date: Sun, 18 Mar 2007 09:27:51 +0100
Message-ID: <20070318082751.GA28591@homac2>
References: <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45FCD062.3050001@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun 18. Mar - 14:38:42, Tejun Heo wrote:
> Hello,
> 
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
> 
> > Personally - I think tighter integration to libata here would be beneficial.
> > Once libata acpi support is straightened out, if we can store acpi handles
> > associated with libata devices, we can perhaps have a mechanism of obtaining
> > ata_device structs so that we can have a nice way of telling libata to 
> > delete devices etc.  I am hoping libata-acpi will be straightened out for
> > 2.6.22.
> 
> I dunno what the thread is really about but can't this be dealt within
> acpid?  Finding out the correct scsi host node can be tricky but I think
> it can be done reliably by jumping through some sysfs whoops.  Once
> you're there, telling libata to kill or probe is really easy.

That's actually what I've created dockutils [1] for. What it basically
does is 'echo 1 > /sys/devices/.../delete' on undock, and 'echo "- - -" >
/sys/class/scsi_host/*/scan' on dock to get the bay device back to life on
those ThinkPads where it is needed. Afterwards it does the corresponding
dock/undock request on ibm_acpi. And this works reliably good what I can
see from the feedback I already got. But for this to work, userspace would
actually need an event on docking and preferably would need to do the ACPI
undock itself. Both things are not possible with the generic dock driver
currently. And I don't think it matters much if libata's hotplug
capabilities are improved in this case, userspace just needs some time to
interact with the user in case there is more to do like unmounting
filesystems inside the bay etc...

I don't prefer any solution, whether doing it inside the kernel, or doing
it in userspace. What would be good would be to know what's the 'right'
way to go, or at least what both kernel people and userspace people can
agree on so that we can find a solution across distributions, whatever.
I'm currently just looking how to integrate the generic dock and bay
driver into the openSUSE distribution, and this seems to be quite hard,
especially because of the above mentioned already working solution ;-)

Just my 2 cents,
     Holger

[1] http://en.opensuse.org/Dockutils
