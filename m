From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Thu, 15 Mar 2007 11:08:55 +0900
Message-ID: <45F8AAB7.50101@gmail.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <200703141442.09754.bzolnier@gmail.com> <45F7FC3C.1000203@gmail.com> <45F83EA5.6080505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:29503 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbXCOCJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 22:09:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so145289uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 19:09:12 -0700 (PDT)
In-Reply-To: <45F83EA5.6080505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> Yeap, agreed but I think getting more info on the libata HSM violation
>> can help diagnosing ide problem too.  Anyways, Stanislav, can you bisect
>> as Bartlomiej requested?
>>
> 
> Tejun, do you have a Zip100 (ATAPI) drive to play with there?

Nope.  Do you happen to have a spare one?

-- 
tejun
