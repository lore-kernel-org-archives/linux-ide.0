From: Tejun Heo <htejun@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Wed, 10 May 2006 23:59:03 +0900
Message-ID: <4461FFB7.90000@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:14666 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964941AbWEJO7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 10:59:09 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1536467wra
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 07:59:08 -0700 (PDT)
In-Reply-To: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dario Oliva <DOliva@ARCOIDE.COM>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Dario Oliva wrote:
> 
> Attached are some kernel messeges. I ran dmesg several times and

None attached. :)

> appended the output to the attached file, so there may be some
> redudancy. However some of the commands or debug lines do appear to
> repeat themselves. As you requested, I changed "#undef ATA_DEBUG" to
> "#define ATA_DEBUG".
> 
> As far as the device is concerned, is an unreleased product of the
> company I work for. That's why I did not give a name, because we don't
> have an official name yet. But like I said, it is SATA, removalbe ATAPI.
> If you want/need more information let me know.

I asked the model because plexstor list some of their drives as PIO only 
with VIA controllers.  I don't know why.  But VIA + plextor combination 
seems to have some problems and your problem might be a similar one. 
Have you tried the drive with other controllers?

-- 
tejun
