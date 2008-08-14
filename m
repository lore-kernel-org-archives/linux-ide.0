From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH] LBA28/LBA48 off-by-one bug in ata.h
Date: Thu, 14 Aug 2008 17:04:29 -0400
Message-ID: <87f94c370808141404w570104e7re258da1958e6689b@mail.gmail.com>
References: <481C224F.10301@rakugaki.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49099 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYHNVEa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 17:04:30 -0400
Received: by gxk9 with SMTP id 9so2876171gxk.13
        for <linux-ide@vger.kernel.org>; Thu, 14 Aug 2008 14:04:29 -0700 (PDT)
In-Reply-To: <481C224F.10301@rakugaki.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Taisuke Yamada <tai@rakugaki.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Jeff,

I never saw the below acked or nacked.  I don't see it in 2.6.27-rc3-next.

Did you have any thoughts?

Greg

On Sat, May 3, 2008 at 4:29 AM, Taisuke Yamada <tai@rakugaki.org> wrote:
> Hi.
>
> I recently bought 3 HGST P7K500-series 500GB SATA drives and
> had trouble accessing the block right on the LBA28-LBA48 border.
> Here's how it fails (same for all 3 drives):
>
>  # dd if=/dev/sdc bs=512 count=1 skip=268435455 > /dev/null
>  dd: reading `/dev/sdc': Input/output error
>  0+0 records in
>  0+0 records out
>  0 bytes (0 B) copied, 0.288033 seconds, 0.0 kB/s
>  # dmesg
>  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>  ata1.00: BMDMA stat 0x25
>  ata1.00: cmd c8/00:08:f8:ff:ff/00:00:00:00:00/ef tag 0 dma 4096 in
>  res 51/04:08:f8:ff:ff/00:00:00:00:00/ef Emask 0x1 (device error)
>  ata1.00: status: { DRDY ERR }
>  ata1.00: error: { ABRT }
>  ata1.00: configured for UDMA/33
>  ata1: EH complete
>  ...
>
> After some investigations, it turned out this seems to be caused
> by misinterpretation of the ATA specification on LBA28 access.
> Following part is the code in question:
>
>  === include/linux/ata.h ===
>  static inline int lba_28_ok(u64 block, u32 n_block)
>  {
>    /* check the ending block number */
>    return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
>  }
>
> HGST drive (sometimes) fails with LBA28 access of {block = 0xfffffff,
> n_block = 1}, and this behavior seems to be comformant. Other drives,
> including other HGST drives are not that strict, through.
>
> From the ATA specification:
> (http://www.t13.org/Documents/UploadedDocuments/project/d1410r3b-ATA-ATAPI-6.pdf)
>
>  8.15.29  Word (61:60): Total number of user addressable sectors
>  This field contains a value that is one greater than the total number
>  of user addressable sectors (see 6.2). The maximum value that shall
>  be placed in this field is 0FFFFFFFh.
>
> So the driver shouldn't use the value of 0xfffffff for LBA28 request
> as this exceeds maximum user addressable sector. The logical maximum
> value for LBA28 is 0xffffffe.
>
> The obvious fix is to cut "- 1" part, and the patch attached just do
> that. I've been using the patched kernel for about a month now, and
> the same fix is also floating on the net for some time. So I believe
> this fix works reliably.
>
> Just FYI, many Windows/Intel platform users also seems to be struck
> by this, and HGST has issued a note pointing to Intel ICH8/9 driver.
>
>  "28-bit LBA command is being used to access LBAs 29-bits in length"
> http://www.hitachigst.com/hddt/knowtree.nsf/cffe836ed7c12018862565b000530c74/b531b8bce8745fb78825740f00580e23
>
> Also, *BSDs seems to have similar fix included sometime around ~2004,
> through I have not checked out exact portion of the code.
>
> I do not subscribe to the list, so Cc: me if further discussion is
> needed.
>
> Best Regards,
> --
> Taisuke Yamada
>
> --- linux-2.6.24/include/linux/ata.h.orig       2008-05-03 16:08:13.224811900 +0900
> +++ linux-2.6.24/include/linux/ata.h    2008-04-01 20:33:44.460619700 +0900
> @@ -599,7 +599,7 @@ static inline int ata_ok(u8 status)
>  static inline int lba_28_ok(u64 block, u32 n_block)
>  {
>        /* check the ending block number */
> -       return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
> +       return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
>  }
>
>  static inline int lba_48_ok(u64 block, u32 n_block)
>
>



-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
