From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 9 Feb 2009 22:25:19 -0500
Message-ID: <87f94c370902091925g15bd433dlfe021431acbaaaa8@mail.gmail.com>
References: <498F42B6.8030607@tlinx.org>
	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
	 <4990AC91.8010104@tlinx.org>
	 <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com>
	 <4990C70E.1010707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:39894 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZBJDZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 22:25:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so146715yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2009 19:25:19 -0800 (PST)
In-Reply-To: <4990C70E.1010707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linda Walsh <suse@tlinx.org>, linux-ide@vger.kernel.org

On Mon, Feb 9, 2009 at 7:15 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Greg Freemyer wrote:
>
>> I'm hearing of people saying a 2 disk mirror (raid-1) is not safe
>> enough.  Go with either a 3 disk mirror or to raid-6.  Even with
>> raid-6 I personally would not let it have too many spindles. (Whatever
>> too many means?)
>
> IMO, RAID-1 was never safe.  With RAID-1, one must rely solely on "knowing"
> which RAID component is bad.  With a completely dead drive, this is obvious;
> with slowly creeping bad sectors, far less obvious.
>
> Plus, the biggest crime, in my opinion, is the lack of checksumming or any
> other method of actually verifying your data.
>
> I've been waiting for years for someone to write RAID-1f...  RAID-1 with a
> hash function that writes checksums in a special metadata area (just like
> the other pre-existing RAID metadata...  a RAID partition is really a just
> simple filesystem anyway).
>
> That way you _know_ with 100% certainty that your data is OK (or not), even
> if you only have a single drive.
>
>        Jeff

Jeff,

I guess you know the scsi standard is in the process of getting
expanded such that each sector can optionally have a well known hash.
And that the hash can be provided by the kernel as part of the data
write.  In turn it can be read as part of the sector on a data read.

Thus it will be possible to have true end-to-end reliability in a
single disk environment.  Who knows when hardware will start to show
up.  If anyone on this list has any influence on the T13 (ata) spec
people, I think it would be a great addition to the ATA world as well
as for the scsi world.

You can google for "SCSI DIF/DIX extensions"

The linux block layer, dm, and mdraid are all gaining support.  Maybe
you can figure out an efficient way to leverage that infrastructure
and implement raid-1f via libata and normal drives!!!

Greg



-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
