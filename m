From: Harri Olin <harri.olin@gmail.com>
Subject: Re: MCP55 disk activity LEDs don't flash
Date: Sun, 07 Dec 2008 17:57:41 +0200
Message-ID: <493BF275.8080903@gmail.com>
References: <493A8767.5030200@seiner.com> <20081206120533.48025219@tuna> <f4527be0812070657q237924cbq7fe48b35e19c0d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:48628 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYLGP5z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 10:57:55 -0500
In-Reply-To: <f4527be0812070657q237924cbq7fe48b35e19c0d6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: =?ISO-8859-1?Q?Dan_No=E9?= <dpn@isomerica.net>, Yan Seiner <yan@seiner.com>, linux-ide@vger.kernel.org

Andrew Lyon wrote:
> I have a similar problem with a supermicro system with sc743tq-865-sq
> chassis + x7dwa-n motherboard, the chassis has a 8 drive hot swap
> backplane but the motherboard only has 6 ports, the 6 drives that are
> connected to the m/b have working led's but the 2 remaining drives
> only flash when the drives spin up, the activity and status lights
> remain off the rest of the time.
>   

Drive activity LED's light up using SATA power connector pin 11. Some 
hard drives support this, others don't.

I don't have any hard information of which drives support and which 
don't but I seem to recall that some WD non-raid-edition drives didn't.

Do you have different drives on the remaining 2 slots?

> I've never figured out how the led's are driven, the backplane does
> have two gpio ports which could be connected to gpio on the
> motherboard, but I have never used them and it seems to work ok as it
> is.
>   

On Supermicro TQ backplanes there is bunch of SGPIO connectors, one for 
4 drives. They are connected to AMI MG9072 chip and are used for 
blinking red error LED's. The integrated (Intel matrix) RAID on some 
Supermicro motherboards should support this, but I have never tested it. 
Also at least some Areca SAS and SATA controllers support it. There is 
also i2c connector but that works only with some Promise contollers. 
Note also that the backplane has to be jumpered correctly for it to work.

-- 
Harri.

