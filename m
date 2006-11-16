From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Testing with 2.6.19-rc5
Date: Thu, 16 Nov 2006 11:21:26 +0000
Message-ID: <f4527be0611160321o118c8f35ic3969dbda40a7358@mail.gmail.com>
References: <f4527be0611150645h7cc2791cub7a2ca753156564f@mail.gmail.com>
	 <20061115110333.4daccb6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20751 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161770AbWKPLV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 06:21:28 -0500
Received: by ug-out-1314.google.com with SMTP id m3so399507ugc
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 03:21:26 -0800 (PST)
In-Reply-To: <20061115110333.4daccb6d.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On 11/15/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 15 Nov 2006 14:45:27 +0000
> "Andrew Lyon" <andrew.lyon@gmail.com> wrote:
>
> > Andrew,
> >
> > You asked me to test if the issues I reported (Re: JMicron 20360/20363
> > AHCI Controller much slower with 2.6.18 / Re: SATA CD/DVDRW Support in
> > 2.6.18? / Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron
> > 20360/20363 2.6.18.1) were still present with 2.6.19-rc5, I tried it
> > today and ran into a very strange problem, the 4 400gb Samsung SATA
> > HDs connected to ata_piix were detected as normal but the raid that
> > they belong to failed to start, the raid system couldnt find any
> > superblock at all.
>
> You mean that the raid works in 2.6.18 but not in 2.6.19-rc5?   Ouch.

Yes, thats exactly what I mean, the disks are detected but the raid
does not start because no superblocks are found.

> What sort of raid setup are you using?

Raid 5, 4 x 400gb Samsung SATA HDs all connected to ata_piix.

> > Is it possible that the addressing of the sectors has changed such
> > that the device data structure does not map to the on disk data in the
> > same way as it did with 2.6.18.x ?
>
> Sounds unlikely.  More likely we're reading junk from the disks.
>
> > unfortunately they drives are not
> > partitioned, just added straight to the raid, otherwise checking the
> > partition table would be a good test.
> >
> > I had a idea about taking a copy of a few kbs of data from each drive
> > using both kernel versions and comparing them,
>
> Good idea.
>
> > but if the raid is
> > started under 2.6.18 its possible the data would change anyway.. so I
> > dont think that would work.
>
> Do you actually need to start the raid under 2.6.18?  Shut the raid down,
> take a copy of the first 32k of each disk, then boto 2.6.19-rc5 and do the
> same?

Actually you are right, I will disable the raid and do the 32k test as
soon as I can, hopefully tonight.

Andy

>
> > Any suggestions? I really want to complete testing of the two issues I
> > reported..
>
> Thanks.
>
