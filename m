From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Mon, 23 Apr 2007 17:00:20 +0900
Message-ID: <462C6794.7000506@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>	<11772636662936-git-send-email-htejun@gmail.com>	<20070422185351.12adf7d8@the-village.bc.nu>	<462BA35C.5040702@gmail.com> <20070422191449.726e0fb4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070422191449.726e0fb4@the-village.bc.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> You can end up with _SDD methods for SFF format controllers (or what we
> think of as SFF format controllers) when we don't have the knowledge to
> drive them in their full super-whizzo method (eg Marvell)
> 
>> The ACPI spec says the layout is dependent on controller interface and I
>>  can see reasons why we need to follow that but not the other way
>> around.  Do you have counter-examples?
> 
> The first problem is the words "the spec". 
> 
> Agreed that STM/GTM are not safe except when expected (and not always safe
> when they are) but that ought to be ok as we then set all the modes
> properly ourselves afterwards.

I agree that there are cases where we drive a controller in different
way than how the BIOS configured it and as a result we can end up with
unmatching ACPI nodes, but I think that it's safer to ignore unmatched
ACPI nodes than to do what seems likely without really knowing what's
going on.

There just isn't a generic way to determine which node matches which
device.  The first two ports might map to the first IDE channel or port
1 and 3 (ata_piix).  Or each port might map to a separate IDE channel
with slave spot disabled.  Even if we support 'best effort' matching, it
is something that only the LLD knows how it should be done and whether
it's safe or not.  IMHO, we're better off just ignoring ATA ACPI
hierarchy if it doesn't match the expectation of the driver.

-- 
tejun
