From: Tobias Rittweiler <inkognito.anonym@uni.de>
Subject: Re[3]: [PATCH] 2.4 IDE core for 2.5
Date: Tue, 9 Jul 2002 15:31:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <ageon2$dhh$2@main.gmane.org>
References: <20020709102249.GA20870@suse.de> <01742490.20020709144349@uni.de>
 <20020709125412.GB1940@suse.de>
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020709125412.GB1940@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello Jens,

Tuesday, July 9, 2002, 2:54:12 PM, you wrote:

JA> Try doing something ala

JA> #ifdef CONFIG_IDE_25
JA> #include <linux/ide.h>  /* IDE xlate */
JA> #else
JA> #include <linux/ide24.h>
JA> #endif

JA> instead of including ide.h directly in fs/partitions/msdos.c

Just a minute ago I booted and wanted to take your hint, but before
this I tried `make bzImage' again (no idea why, just for fun) and
it compiled! This results from the fact that I booted the new
kernel with the new IDE core including.

Yes, it works now. Thanks anyway, I'm sure you'll interpret this
happening rightly.

-- 
cheers,
  Tobias

http://freebits.org

