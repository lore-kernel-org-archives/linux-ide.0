From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 17:30:03 -0400
Message-ID: <4478C4DB.3080002@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C36E.8080107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:25042 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964938AbWE0VaN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:30:13 -0400
In-Reply-To: <4478C36E.8080107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jens Axboe wrote:
> ..
>> ata_busy_wait() is _not_ enough for me, what seems to be happening is
>> that prematurely decides that BSY is cleared while it just hasn't been
>> asserted yet.
> ..
> Rebooting to try it here now..

Works here (w/Jens' original placement of the delay)
