From: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Subject: Re: Lockup when using three or more TX2plus/PDC20375 cards
Date: Wed, 3 Aug 2005 10:16:08 -0400
Message-ID: <fab4e42a05080307162186b325@mail.gmail.com>
References: <VA.00001960.01b93e16@foxhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:41026 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262265AbVHCOQJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Aug 2005 10:16:09 -0400
Received: by wproxy.gmail.com with SMTP id i13so136355wra
        for <linux-ide@vger.kernel.org>; Wed, 03 Aug 2005 07:16:09 -0700 (PDT)
In-Reply-To: <VA.00001960.01b93e16@foxhill.co.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Welcome to the club.  I actually have a PDC20579 with only two ports
and a sata_nv down, and the PDC20579 under md RAID5 stress sometimes
just stops responding entirely.  I've talked with Jim Ramsay and tried
his patches, but nothing make the failure go away.

On 8/2/05, Ian Oliver <lists@foxhill.co.uk> wrote:
> Hi,
> 
> I am using Ubuntu Hoary with the standard 2.6.10 kernel.
> I have 4x Maxtor SATA cards using the PDC20375 (rebranded Promise
> TX2plus) in PCI slots. Each drive is cabled to 2 SATA HDs and these are
> used as two groups of four for software raid using mdadm. Boot drive is
> a non-raid PATA drive.
> 
> When I really hammer the sw raid that's on two of the cards it will
> generate lots of these in the log -
> Jul 25 17:33:42 localhost kernel: ata7: status=0x51 { DriveReady
> SeekComplete Error }
> Jul 25 17:33:42 localhost kernel: ata7: error=0x0c { DriveStatusError }
> 
> then I get the following on the console -
> ata7: command timeout
> and then the whole machine locks solid.
> 
> I can do whatever I like to the raid on the 1st four cards and it seems
> rock solid.
> 
> I hear talk of 3rd and subsequent cards not being initialised by the
> BIOS, and my "lspci -v" results back this up. (Please see
> http://bugzilla.ubuntu.com/show_bug.cgi?id=13046 rather than cluttering
> this list.)
> 
> How can I address this problem? I have just built a 2.6.10 kernel and
> modules (very much a first for me) so I think I can apply patches and
> try things out.
> 
> Note that I think Ubuntu has some patches from later kernels applied to
> their libata to add pass through, but I don't know the status of the
> sata_promise.
> 
> Regards
> 
> Ian
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
