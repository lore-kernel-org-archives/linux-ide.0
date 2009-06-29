From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] ide-cd: Improve "weird block size" error message
Date: Mon, 29 Jun 2009 13:19:17 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0906291317520.16384@fbirervta.pbzchgretzou.qr>
References: <200906222101.38586.elendil@planet.nl> <200906222335.06700.bzolnier@gmail.com> <200906230951.24615.elendil@planet.nl> <20090623.035926.155211513.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090623.035926.155211513.davem@davemloft.net>
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Tuesday 2009-06-23 12:59, David Miller wrote:
>> In that case I'd like to propose the following patch. Currently the error
>> can get printed much to frequently when there's a disc in the drive.
>> Example:
>> 
>> Jun 13 18:06:28 gimli kernel: ide-cd: hdd: weird block size 2352
>> Jun 13 18:06:28 gimli kernel: ide-cd: hdd: default to 2kb block size
>> Jun 13 18:06:32 gimli kernel: ide-cd: hdd: weird block size 2352
>> Jun 13 18:06:42 gimli kernel: ide-cd: hdd: default to 2kb block size
>
>Thinking about this a bit.  Let's look at what problem this is
>trying to avoid, as per the commit message:
>
>--------------------
>    ide-cd: fix oops when using growisofs
>    
>    cdrom_read_capacity() will blindly return the capacity from the device
>    without sanity-checking it.  This later causes code in fs/buffer.c to
>    oops.
>    
>    Fix this by checking that the device is telling us sensible things.
>--------------------
>
>Well, for the values Frans's CDROM is giving, this OOPS would not
>take place and the weird sector value is completely harmless.
>
>Since SECTOR_BITS is 9:
>
>(2352 >> 9) == (2048 >> 9) == 4
>
>There is simply no benefit from this warning in this situation.


But 2352 is the block size for CDDA (yes, I reckon that is not quite
relevant for the block layer), so it's not like there would be
garbage bits in the lower 9 bits.

>
>Therefore, any objections to something like this?
>
>ide-cd: Don't warn on bogus block size unless it actually matters.
>
>Frans Pop reported that his CDROM drive reports a blocksize of 2352,
>and this causes new warnings due to commit
>e8e7b9eb11c34ee18bde8b7011af41938d1ad667 ("ide-cd: fix oops when using
>growisofs").
>
>What we're trying to do is make sure that "blocklen >> SECTOR_BITS"
>is something the block layer won't choke on.
>
>And for Frans case "2352 >> SECTOR_BITS" is equal to
>"2048 >> SECTOR_BITS", and thats "4".
