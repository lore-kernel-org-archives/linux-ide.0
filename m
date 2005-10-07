From: Jon Escombe <lists@dresco.co.uk>
Subject: Re: [RFC] Hard disk protection revisited
Date: Fri, 07 Oct 2005 13:04:35 +0100
Message-ID: <43466453.9070604@dresco.co.uk>
References: <4345B24A.2080104@dresco.co.uk> <20051007100219.GU2889@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932385AbVJGMGR@vger.kernel.org>
In-Reply-To: <20051007100219.GU2889@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, hdaps-devel@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

Jens Axboe wrote:

>I have to nack this one for now, I still want the generic command types
>patch to go in first. We have far too many queue hooks already, adding
>two more for a relatively obscure use such as this one is not a good
>idea.
>
>My suggestion is to maintain this patch out of tree for now, it will be
>a few kernel release iterations before the command type patch is in.
>  
>

That's a fair comment (and not entirely unexpected), I don't have a 
problem with looking after this out of tree for now...

One issue with the generic command approach occured to me while making 
this patch - although it's more likely an issue with my understanding ;)

I'm assuming that it would work like this -- the block layer still has 
the sysfs attribute, and queues the new command for the lower driver to 
pick up. The driver receives the command and does it's custom 
park/freeze work, then calls a common block layer function to setup the 
timer (all good so far). Where it gets hazy (for me) is how the block 
layer starts the queue up again - as this ended up needing to be driver 
specific & I can't see how the block layer would get another command 
down if the queue is stopped?

Regards,
Jon.




______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
