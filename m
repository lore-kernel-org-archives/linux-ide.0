From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 13:53:10 +0300
Message-ID: <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
References: <200808261045.33241.elendil@planet.nl>
	 <c70ff3ad0808271029u7f53f5ffkd44eacd996da5cb2@mail.gmail.com>
	 <200808281125.14012.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:49578 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbYH1KxM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 06:53:12 -0400
Received: by py-out-1112.google.com with SMTP id p76so188971pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 03:53:10 -0700 (PDT)
In-Reply-To: <200808281125.14012.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thu, Aug 28, 2008 at 12:25 PM, Frans Pop <elendil@planet.nl> wrote:
> On Wednesday 27 August 2008, saeed bishara wrote:
>> Frans, does the LED stay "on" even when there is no disk activity?
>
> Yes, it does.
>
> On Wednesday 27 August 2008, saeed bishara wrote:
>> > I'm being told that there's a standard LED control bit on Orion, but
>> > hopefully Saeed can comment.  If it's a QNAP specific problem, I can
>> > talk to my contacts at QNAP.
>>
>> bit 0 of 0x8002c controls the active LED, 1 makes it blink slower
>> (more user friendly).
>> I checked 2.6.26 on rd5182 and both LEDs work fine. it's probably QNAP
>> specific problem.
>> Frans, can you please try the patch at
>> http://www.spinics.net/lists/linux-ide/msg25093.html
>
> That patch does not seem to make any difference.
>
>> if it still doesn't work please check the value of the register at
>> 0xf1010004 (MPPs control).
>
> $ sudo ./bin/devmem2 0xf1010004
> /dev/mem opened.
> Memory mapped at address 0x4001f000.
> Value at address 0xF1010004 (0x4001f004): 0x55550000
thanks for the check, the register seems all right.
can you try setting bit 0 of the 0xf108002c then run some io?
which disk you have there? is there any chance that you can replace it
with different model that support NCQ?
saeed
