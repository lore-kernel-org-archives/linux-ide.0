From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Sat, 21 Oct 2006 23:04:38 +0200
Message-ID: <453A8B66.8080302@gmx.net>
References: <20061006065816.GA5782@jim.sh> <45263683.408@gmx.net> <45287D85.1050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:1002 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422874AbWJUVEm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2006 17:04:42 -0400
In-Reply-To: <45287D85.1050302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com, David Wang <touch@sis.com>

Hi,

I have tested the patch with separate port_info and a patch only adding
the flag ATA_FLAG_SLAVE_POSS for all controllers.
The result  is allways  the  same.  The second sata disk  is allways
/dev/sdb. libata handles this  correctly.

So i am not sure, that the separate port_info is really necessary. My
assumption is a ATA_FLAG_SLAVE_POSS
is sufficient for a correct handling.

If i am wrong, i will send a patch with separate port_info .

regards,
Uwe
 

Tejun Heo wrote:
> Hi!
>
> Uwe Koziolek wrote:
>> Hi Jim,
>>
>> the sata_sis is running without slave support in the versions from
>> kernel.org. That is ok if you are using
>> a SiS964 and 965L chip. The SiS 965, SiS180 and SiS966 needs a slave
>> support.
>>
>> The attached patch against 2.6.18 should help.
>>
>> feedback, log and output of lspci -vvxxx are welcome.
>
> Can you make separate port_info for controllers which support 4 ports
> and send a properly formatted patch?
>
> Thanks.
>

