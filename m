From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET] libata: improve ATA ACPI support
Date: Mon, 23 Apr 2007 18:03:31 -0400
Message-ID: <462D2D33.30403@rtr.ca>
References: <11772636651400-git-send-email-htejun@gmail.com> <20070422192500.2e1014fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070422192500.2e1014fd@the-village.bc.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>> * after successfully executing _GTF taskfiles, IDENTIFY page is
>>   reloaded
> 
> Interesting question we should sort out: What is our identify page as
> supplied to the user meant to be ?
> 
> The old IDE one started off as the "identify data at boot" (which is
> useful) and mutated through a million "kind of boot but mangled" and "not
> boot" versions of the identify data, all of which are useless to
> userspace.
> 
> Having the "boot" data (for some definition of boot) is important in
> order to know things like the BIOS view of the disk geometry and HPA (eg
> for partitioning), having the current data is useless as its already
> available via SG_IO.

Agreed.  Userspace can already fetch the real, current IDENTIFY data
just by issuing the appropriate drive command (except for ATAPI,
since Jeff has gone mute on the months old patch to fix it).

Boot-time IDENTIFY data was extremely useful for IDE development.
It showed how the BIOS had set things up (or not).

Cheers
