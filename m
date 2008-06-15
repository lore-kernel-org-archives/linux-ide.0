From: "Byron Bradley" <byron.bbradley@gmail.com>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Sun, 15 Jun 2008 11:54:01 +0100
Message-ID: <57e2b00806150354s6096e1a1w13668a68140dd682@mail.gmail.com>
References: <20080512132611.GA15410@deprecation.cyrius.com>
	 <4852A6D0.8030607@rtr.ca> <48547BD9.8050306@gmail.com>
	 <200806151141.52326.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:6344 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYFOKyC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 06:54:02 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3157236rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 03:54:01 -0700 (PDT)
In-Reply-To: <200806151141.52326.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

On Sun, Jun 15, 2008 at 10:41 AM, Frans Pop <elendil@planet.nl> wrote:
> On Sunday 15 June 2008, Tejun Heo wrote:
>> The interesting thing here is that sata_mv can see the disk going off
>> the power, which is kind of cool.  The controller and CPU are watching
>> itself as it goes off the life support and is drifting awaaaaaayyyy.
>>
>> The PSU has switched off and power to the drive was cut.  I don't think
>> anything can go wrong at that point.
>
> What I still find most interesting is that with 2.6.25 the extra
> message(s) do not appear and the poweroff is "clean". And that it affects
> 2 different systems where one seems to live on just a bit longer than the
> other. So it does look as if something _has_ changed.

I'm not sure you can actually rely on that. lb_worm had the same
problem back in December [0].

[0] http://buffalo.nas-central.org/forums/viewtopic.php?f=18&t=4242&p=43161#p43161

Cheers,

-- 
Byron Bradley
