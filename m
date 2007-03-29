From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-acpi: summary, problems, questions and proposal
Date: Thu, 29 Mar 2007 12:45:49 +0900
Message-ID: <460B366D.1070901@gmail.com>
References: <460A197A.9000708@gmail.com> <20070328175712.GA10293@srcf.ucam.org> <460B196B.5040306@gmail.com> <20070329020517.GA18249@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070329020517.GA18249@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Randy.Dunlap y" <rdunlap@xenotime.net>, trenn@suse.de, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, forrest.zhao@gmail.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
>> * You'll end up doing _STM/_GTM on ahci controller on some BIOSen - 1. 
>> it can be dangerous 2. you might get partial or incorrect mapping - 
>> think about ICH8-split-to-two-PCI-fn-in-piix-mode case.
> 
> So far I haven't seen any DSDTs that include _GTM and _STM methods for 
> controllers that come up flagged as ahci, though I'm perfectly willing 
> to believe that they're out there...

My ICH8 board seems to.  I'll further look into it and post dsl files.

>> I think PM functions in libata-eh is better place and you also need to 
>> do _GTF after _GTM during resume.
> 
> Well, "need" - I haven't actually found hardware that seems upset about 
> the missing _GTF call :)

_GTF does the password unlocking and device configuration part of _STM.
 ACPI itself might not whine because no other ACPI method depends on
_GTF being executed but functionally it's the most important piece.

Now I think about it, _GTF is eventually done during device revalidation
but that needs to be removed, so we'll need to add it in the resume path.

> But you're right, it ought to be done. Can you 
> point me at the right bits of the libata-eh code? I was trying to work 
> through it earlier, but keeping track of the conditional paths is a bit 
> tricky.

There is a big suspend/resume rewrite patch pending and the
suspend/resume code will look quiet different (simpler) after it.

I think the correct place for _STM/_GTF would be right after
ata_eh_revalidate_and_attach().  As libata allows device hotplugging
while suspended, we probably need to skip _STM/_GTF if the attached
device isn't the one we've seen during suspending.

Another problem is that _GTF might alter device size (number of blocks).
 Currently libata uses device size as one of the metrics to determine
whether the device is the same one it saw last time during revalidation.
 This is pretty good safeguard as IIRC in some rare cases BIOS not only
cuts sectors at the end of the disk but also offsets all the blocks (was
this even standard?  it can't be done using overlay or hpa.  some vendor
extension maybe?).  So, if the different disk size is due to offset and
you continue to operate on the disk as before, you're seriously screwed.

We need to make sure that the device is the same one that we saw during
suspend before doing _STM/_GTF and before _GTF the disk size might
differ.  Recent HPA handling Alan posted should be considered here too.
 Also, HPA programming might interact with _GTF.

>>> I think this is just a matter of making sure that the sata and pata 
>>> handle matching code matches reality now :)
>> Currently 1/2 of libata-acpi code is dealing with the above.  I'm trying 
>> to figure out why it needs to be that complex.
> 
> I wrote a patch at one point that simplified this to an extent 
> (http://lkml.org/lkml/2005/12/7/425), but it got somewhat bogged down in 
> discussion about where the right place to do the binding was. Personally 
> I'd prefer to handle this in a similar way to PCI - that is, register 
> the ata bus with ACPI and then find handles as and when new ata devices 
> are added to that bus. This has the advantage that it's easy to tie ACPI 
> events to specific ata devices, which could then be integrated with the 
> bay and dock drivers.

Yeap, that would be great.  The problem is that libata isn't struct
device'd (yet).  As libata needs sysfs representation anyway, we might
go all the way and implement ATA bus and all.  Duplication between SCSI
and ATA nodes is worrying but I guess we can figure out something.

Thanks.

-- 
tejun
