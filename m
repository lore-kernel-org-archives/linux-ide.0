From: Jan Dittmer <jan@jandittmer.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 11:24:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200210191124.34977.jan@jandittmer.de>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021019091518.GG871@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> But I'm curious about TCQ on your system, since another VIA user
> reported problems. Does it appear to work for you?

Actually that was me, I think. It now seems to work without any corruption on 
2.5.44bk. I don't know what caused it last time. Perhaps it was really my 
harddisk dying - but I never experienced such problems with 2.4.x .
So I guess it's okay now. I'll try re-enable tcq now...

thanks,

jan
