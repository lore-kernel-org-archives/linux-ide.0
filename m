From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/4] CHS: LBA28/LBA48 optimization (resend #5)
Date: Tue, 11 Oct 2005 09:12:03 -0400
Message-ID: <434BBA23.3030906@rtr.ca>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com> <434509EF.3040307@pobox.com> <43461B81.1090808@tw.ibm.com> <43463296.3090007@tw.ibm.com> <43491E26.40508@pobox.com> <434B9C86.604@tw.ibm.com> <434BA048.3000905@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:35201 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751134AbVJKNMA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Oct 2005 09:12:00 -0400
In-Reply-To: <434BA048.3000905@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Ah, here it is:

> +static inline int lba_28_ok(u64 block, u32 n_block)
> +{
> +	return (block < ((u64)1 << 28)) && (n_block <= 256);
> +}
> +

That will need to change, so something like this:

return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
