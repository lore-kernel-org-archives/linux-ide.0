From: Tyler <pml@dtbb.net>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 07:24:14 -0700
Message-ID: <4299D08E.2020706@dtbb.net>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <4299CD31.8020805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound05.telus.net ([199.185.220.224]:27781 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S261323AbVE2OY1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 10:24:27 -0400
Received: from [192.168.0.28] (really [142.179.55.145])
          by priv-edtnes40.telusplanet.net
          (InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
          id <20050529142425.CEOG24124.priv-edtnes40.telusplanet.net@[192.168.0.28]>
          for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 08:24:25 -0600
In-Reply-To: <4299CD31.8020805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord wrote:

> My basic hdparm timing test shouldn't show much of a difference
> with NCQ tests, becase hdparm just does a single request at a time,
> and waits for the results before issuing another.  Now, kernel read-ahead
> may result in some command overlap and a slight throughput increase, 
> but..
>
> Something like dbench and/or bonnie++ are more appropriate here.
>
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
How effective can NCQ be in a RAID5/RAID6 environment? If at all?

I wouldn't think it would be.. but maybe i'm not seeing the forest for 
the trees..

Regards,
Tyler.
