From: Saswat Praharaj <saswat@gmail.com>
Subject: read vs write
Date: Mon, 25 Jul 2005 15:44:27 +0530
Message-ID: <d15adc960507250314ec47755@mail.gmail.com>
Reply-To: Saswat Praharaj <saswat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:64831 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261185AbVGYKO2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 06:14:28 -0400
Received: by wproxy.gmail.com with SMTP id i1so956498wra
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2005 03:14:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello Experts,

I am a kernel newbie.

While checking the hard-disk performance I have found that write is
significantly slower than read.

In my setup I am using UDMA 5 mode , and I am using is ST340016A (from
Seagate) and Diamond Max Plus 9 (from Maxtor).

I checked the product manual for ST340016A and found that seek time
for read/write is approximately same.

While, I am able to read at a speed of 55 Mbps , for write operation
the speed decreases to 20Mbps.

I am using linux kernel version 2.4.25 #41 .

Can anyone give me some info on why write is so slow compared to read.

Moreover, I am wondering if I could achieve the 100Mbps read speed as
claimed by different vendors.For me , It should ideally be 100 Mbps as
I am using a 80 conductor cable and UDMA 5.Why then I am getting 58
Mbps max . .

Is it because linux kernel 2.4.25 supports upto ATA-2 standard  ?? 

Well, I am using a 400 MHz amd processor.

I would greatly appreciate if some one could explain the read/write
behaviour and help me find out how can I get 100 Mbps speed .

Thanks for reading my mail.

Regards,
-Saswat
