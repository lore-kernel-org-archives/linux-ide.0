From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume
 and actual wakeup
Date: Mon, 05 Jun 2006 21:43:42 +0900
Message-ID: <448426FE.8090801@gmail.com>
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz> <44841AA0.4060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751066AbWFEMnv@vger.kernel.org>
In-Reply-To: <44841AA0.4060404@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Pavel Machek wrote:
>> If you want to know if you RESUME was after normal FREEZE or if it is
>> after reboot, there's better patch floating around to do that.
> 
> Yeap, this is what I'm interested in.  Care to give me a pointer?

And, one more things.  As written in the first mail, for libata, it 
would be nice to know if a device suspend is due to runtime PM event 
(per-device) or system wide suspend.  What do you think about this?  If 
you agree, what method do you recommend to determine that?

Thanks a lot.

-- 
tejun
