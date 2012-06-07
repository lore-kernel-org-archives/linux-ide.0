From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit
 operation
Date: Thu, 07 Jun 2012 14:59:03 -0700
Message-ID: <1339106343.14838.20.camel@joe2Laptop>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr>
	 <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr>
	 <20120607.144616.2224976714259476349.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120607.144616.2224976714259476349.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Julia.Lawall@lip6.fr, kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, julia@diku.dk
List-Id: linux-ide@vger.kernel.org

On Thu, 2012-06-07 at 14:46 -0700, David Miller wrote:
> the
> risk %99.999 of the time is purely to introduce regressions rather
> than make forward progress.

 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b54f50c..41d4586 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3404,7 +3404,7 @@ M:	"David S. Miller" <davem@davemloft.net>
 L:	linux-ide@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ide/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git
-S:	Maintained
+S:	Watchdogged - Patch at your own peril
 F:	Documentation/ide/
 F:	drivers/ide/
 F:	include/linux/ide.h
