From: Eric Mudama <edmudama@gmail.com>
Subject: Re: sata_promise performance observations
Date: Mon, 25 Oct 2004 11:55:28 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <311601c904102510555d7c0810@mail.gmail.com>
References: <417A1826.5010502@wasp.net.au>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:61124 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261233AbUJYRzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 13:55:32 -0400
Received: by rproxy.gmail.com with SMTP id 77so457460rnk
        for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 10:55:28 -0700 (PDT)
In-Reply-To: <417A1826.5010502@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

arbitration between the multiple PCI cards?  A single card that
doesn't have to compete for PCI resources would, in theory, be
faster...

(Don't know much about this chunk of hardware, 'tis only a guess)


On Sat, 23 Oct 2004 12:36:54 +0400, Brad Campbell <brad@wasp.net.au> wrote:
> G'day all,
> 
> Interesting observation with 3 SATA150TX4 cards and 10 Maxtor Maxline-II 250GB SATA drives.
> 
> If I run a concurrent dd if=/dev/sda > /dev/null and dd if=/dev/sdb > /dev/null I get the expected
> 115MB/s transfer rates in vmstat.
> 
> If I do a dd if=/dev/sda > /dev/null and dd if=/dev/sde > /dev/null I get about 80MB/s
> 
> sda, sde & sdi I get
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> 
>   3  0  22540   2560 463908   5320    0    0 85294    16 1102   761 11 88  0  1
>   3  1  22540   1480 464852   5320    0    0 86493    25  987   512 13 86  0  0
>   2  2  22540   2176 464304   5268    0    0 86774    18 1091   721 12 87  0  1
>   2  2  22540   1488 464860   5368    0    0 85562    18  921   416 13 87  0  0
> 
> When streaming from drives not on the same controller, I lose about 30mb/s transfer rate. In fact,
> it seems to max out at about 86MB/s no matter what combination of drives I use if I stream from more
> than one controller.
> 
> However, if I use sda, sbb & sdc I get
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> 
>   0  3  22512   1768 464448   5304    0    0 121661    18 1257   566  9 59  0 32
>   0  3  22512   1536 464696   5316    0    0 122903    14 1262   578 10 59  0 31
>   0  3  22512   2112 464228   5268    0    0 121655    14 1255   578  9 60  0 32
> 
> How bizzare. I have latency set to 32 on all controllers, but I have tried as low as 8 and as high
> as 128 to no avail.
> 
> I have readahead set to 4096 on all devices.
> 
> Anyone have any ideas?
> 
> Not that this is an issue for me (I'm only using it as a fileserver over GB eth so its not like
> 100MB/s is actually required, just an interesting observation)
> 
> Regards,
> Brad
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
