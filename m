From: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 11:24:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021019092406.GI871@suse.de>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de> <200210191124.34977.jan@jandittmer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200210191124.34977.jan@jandittmer.de>
To: Jan Dittmer <jan@jandittmer.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Oct 19 2002, Jan Dittmer wrote:
> > But I'm curious about TCQ on your system, since another VIA user
> > reported problems. Does it appear to work for you?
> 
> Actually that was me, I think. It now seems to work without any corruption on 

Oh :)

> 2.5.44bk. I don't know what caused it last time. Perhaps it was really my 
> harddisk dying - but I never experienced such problems with 2.4.x .
> So I guess it's okay now. I'll try re-enable tcq now...

Thanks for testing!

-- 
Jens Axboe
