From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 10:12:32 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <407E35E0.3080902@vision.ee>
References: <200404150236.05894.kos@supportwizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tristate.vision.ee ([194.204.30.144]:14276 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264294AbUDOHMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2004 03:12:34 -0400
In-Reply-To: <200404150236.05894.kos@supportwizard.com>
List-Id: linux-ide@vger.kernel.org
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Konstantin Sobolev wrote:

>Hi,
>
>/dev/hde:
> Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
> Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec
>
>for sata_sil:
>
>/dev/sda:
> Timing buffer-cache reads:   1412 MB in  2.00 seconds = 705.05 MB/sec
> Timing buffered disk reads:   84 MB in  3.06 seconds =  27.43 MB/sec
>
>So my old IDE HDD appears to be considerably faster. Expected results were 
>55-70MB/s.
>  
>
With same hard drive connected to 3ware S-ATA controller I got 
40-50MB/sec with hdparm on 2.6.4 and 2.6.5. Then
tried to hdparm -a 8192 /dev/sda, and got this:

/dev/sda:
 Timing buffer-cache reads:   2056 MB in  2.00 seconds = 1027.13 MB/sec
 Timing buffered disk reads:  266 MB in  3.00 seconds =  88.53 MB/sec

So you may try that switch, maybe helps.

Lenar
