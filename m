From: "Daniela Engert" <dani@ngrt.de>
Subject: Re: sata_sil problem / oops
Date: Thu, 02 Jun 2005 21:50:13 +0200 (CDT)
Message-ID: <200506021950.j52JoAi01072@epz01.nefonline.de>
References: <20050602192327.GA13964@suse.de>
Reply-To: "Daniela Engert" <dani@ngrt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from epz01.nefonline.de ([212.204.66.1]:31935 "EHLO
	epz01.nefonline.de") by vger.kernel.org with ESMTP id S261291AbVFBTuN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Jun 2005 15:50:13 -0400
In-Reply-To: <20050602192327.GA13964@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 2 Jun 2005 21:23:29 +0200, Jens Axboe wrote:

>On Thu, Jun 02 2005, Daniela Engert wrote:

>> My OS/2 driver and the Windows driver write to the following locations:
>> 
>> SiI3112: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45
>> SiI3114: BAR5+0x40, BAR5+0x41, BAR5+0x44, BAR5+0x45,
>> 	 BAR5+0x240, BAR5+0x241, BAR5+0x244, BAR5+0x245
>
>Does the 3112 have two ports and the 3114 four?

Exactly.

Ciao,
  Dani


