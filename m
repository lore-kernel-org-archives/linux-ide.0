From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: UDMA5
Date: Mon, 19 Sep 2005 17:16:55 +0200
Message-ID: <58cb370e05091908167d941bee@mail.gmail.com>
References: <011401c5b2b2$becb3b40$1f01a8c0@Ric>
	 <007301c5b38d$78f3c750$1f01a8c0@Ric> <431F9236.1040801@yahoo.de>
	 <000a01c5b445$f9570520$1f01a8c0@Ric> <431FF0EA.2090006@yahoo.de>
	 <00a601c5b469$3a3cdc40$1f01a8c0@Ric> <43205F0C.10607@yahoo.de>
	 <01da01c5bcfb$3b69cd90$1f01a8c0@Ric> <432E89E8.5090409@yahoo.de>
	 <000a01c5bd2b$cd933ff0$1f01a8c0@Ric>
Reply-To: bzolnier@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.193]:40718 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932458AbVISPQ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Sep 2005 11:16:56 -0400
Received: by nproxy.gmail.com with SMTP id x37so346174nfc
        for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2005 08:16:55 -0700 (PDT)
In-Reply-To: <000a01c5bd2b$cd933ff0$1f01a8c0@Ric>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Riccardo Castellani <r.castellani@usl6.toscana.it>
Cc: Stefan <gentoopower@yahoo.de>, linux-ide@vger.kernel.org

On 9/19/05, Riccardo Castellani <r.castellani@usl6.toscana.it> wrote:
> I run Maxtor MaxPower tool and HD test is ok.
> I didn't see any settings to change UDMA mode.
> I tried to run Knoppix live CD into machine and I had the same result: UDMA
> 2*
> I put this disk into another hardware and It worked in UDMA 6 !!!
> What do you think ?

>>>> Linux version 2.6.12-1.1376_FC3 (bhcompile@tweety.build.redhat.com)
>>>> (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 Fri Aug 26 23:27:26
>>>> EDT 2005

Try with *vanilla* kernel 2.6.13 or 2.6.14-rc1.
