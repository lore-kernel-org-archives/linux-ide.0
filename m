From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 09:22:37 -0600
Message-ID: <311601c9050529082248cb4c63@mail.gmail.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com>
	 <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com>
	 <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com>
	 <4299CD31.8020805@rtr.ca> <4299D08E.2020706@dtbb.net>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:40630 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261340AbVE2PWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 11:22:39 -0400
Received: by rproxy.gmail.com with SMTP id i8so988700rne
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 08:22:37 -0700 (PDT)
In-Reply-To: <4299D08E.2020706@dtbb.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tyler <pml@dtbb.net>
Cc: linux-ide@vger.kernel.org

Today's 7200 RPM IDE drives are in the ~70-80 ops/sec range for
full-stroke random reads or writes (assuming cache off for writes).

NCQ can usually turn 70-80 into 120-140 ops/sec, because of a decrease
in average seek distance and the near-elimination of rotational
latency.

If the array and filesystem is setup/tuned properly, these ops/sec
performance increases should translate directly into array performance
increases.

--eric


On 5/29/05, Tyler <pml@dtbb.net> wrote:
> How effective can NCQ be in a RAID5/RAID6 environment? If at all?
> 
> I wouldn't think it would be.. but maybe i'm not seeing the forest for
> the trees..
> 
> Regards,
> Tyler.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
