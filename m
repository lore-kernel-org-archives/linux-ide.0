From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 4/4] CHS: LBA28/LBA48 optimization (resend #5)
Date: Wed, 12 Oct 2005 13:05:31 +0800
Message-ID: <434C999B.2040001@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com> <434509EF.3040307@pobox.com> <43461B81.1090808@tw.ibm.com> <43463296.3090007@tw.ibm.com> <43491E26.40508@pobox.com> <434B9C86.604@tw.ibm.com> <434BA048.3000905@tw.ibm.com> <434BBA23.3030906@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36825 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932447AbVJLFFi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 01:05:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9C54PUv015268
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:04:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9C56Jtu290094
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2005 23:06:19 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9C55VK1025813
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2005 23:05:31 -0600
In-Reply-To: <434BBA23.3030906@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Mark Lord wrote:

> Ah, here it is:
> 
>> +static inline int lba_28_ok(u64 block, u32 n_block)
>> +{
>> +    return (block < ((u64)1 << 28)) && (n_block <= 256);
>> +}
>> +
> 
> 
> That will need to change, so something like this:
> 
> return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
> -

Thanks for the advice. I didn't think of it.
Will revise and resend the patch.

Albert
 
