From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [git patches] IDE update
Date: Tue, 05 Jul 2005 23:36:18 +0200
Message-ID: <42CAFD52.2020106@rainbow-software.org>
References: <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <42CAA075.4040406@rainbow-software.org> <20050705192550.GF30235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub3.nextra.sk ([195.168.1.146]:30733 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261810AbVGEVgY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jul 2005 17:36:24 -0400
In-Reply-To: <20050705192550.GF30235@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>, Al Boldi <a1426z@gawab.com>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, 'Linus Torvalds' <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jul 05 2005, Ondrej Zary wrote:
> 
>>oread is faster than dd, but still not as fast as 2.4. In 2.6.12, HDD 
>>led is blinking, in 2.4 it's solid on during the read.
> 
> 
> Oh, and please do test 2.6 by first setting the deadline scheduler for
> hda. I can see you are using the 'as' scheduler right now.
> 
> # echo deadline > /sys/block/hda/queue/scheduler
> 

No change, still >25 seconds.

-- 
Ondrej Zary
