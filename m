From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Date: Tue, 9 Jul 2002 13:20:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020709112054.GB9551@suse.de>
References: <20020709102249.GA20870@suse.de> <200207091313.07199.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200207091313.07199.roy@karlsbakk.net>
List-Id: linux-ide@vger.kernel.org
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, Jul 09 2002, Roy Sigurd Karlsbakk wrote:
> hi
> 
> Should I add IDE9[4567] as well, or does these ones include previous IDE 
> pathes?

Well, the whole point of this patch set is _not_ to use the 2.5 ide core
for now. When configuring your kernel, you get the choice of using
2.4-ide or 2.5-ide. If you choose 2.5-ide, then yes you should add those
patches (I guess). If you choose 2.4-ide (which most users of the patch
set would do, why else apply it?!), then it doesn't matter.

-- 
Jens Axboe

