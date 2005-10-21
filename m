From: Mark Lord <liml@rtr.ca>
Subject: Re: Merging ATA passthru
Date: Fri, 21 Oct 2005 17:45:04 -0400
Message-ID: <43596160.3080407@rtr.ca>
References: <43593E0A.4070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751266AbVJUVpN@vger.kernel.org>
In-Reply-To: <43593E0A.4070801@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> Folks,
> 
> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
> the ATA passthru work upstream, once 2.6.14 is released.

Thanks, Jeff!

> Since there are still some reported problems that I haven't had time to 
> track down, I'm going to -- like ATAPI -- introduce a module option that 
> enables passthru.  It will default to off.

With passthru, it would really be much better to just leave it enabled
without any option.  It's NOT on any main code path, and users/distros
have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
trigger any of it.

So it is already "off", unless somebody wants to use it.
This is different from the ATAPI code.

But good to have it finally going upstream where it will get used.

Cheers!
