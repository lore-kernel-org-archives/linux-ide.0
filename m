From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
	libata.h
Date: Fri, 15 Feb 2008 14:46:14 -0800
Message-ID: <1203115574.30938.6.camel@brick>
References: <1203113215.15275.53.camel@brick> <20080215223036.2111edd5@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.246]:42876 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332AbYBOWqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 17:46:18 -0500
Received: by hs-out-0708.google.com with SMTP id 54so606242hsz.5
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 14:46:17 -0800 (PST)
In-Reply-To: <20080215223036.2111edd5@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2008-02-15 at 22:30 +0000, Alan Cox wrote:
> On Fri, 15 Feb 2008 14:06:55 -0800
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Move to using a static inline which will force the same typechecking
> > that min_t/max_t do (in this case, short).  As a bonus, avoid a ton
> > of sparse warnings like:
> > 
> > drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
> > drivers/ata/pata_ali.c:176:14: originally declared here
> > 
> > Due to nesting min_t macro inside max_t macro which both use a __x
> > identifier internally.
> 
> NAK. This is a sparse bug, fix sparse.

Yes, fair enough, but that's not all the patch is about.

1) it's using a max_t and min_t to force the comparisons as shorts, why
not just make it a static inline?

2) the static inline is a little clearer about the intent here.

3) the sparse warnings are entirely secondary (and technically correct
when the macros expand, __x is shadowed)

4) I may be mistaken, but I thought then when something can be written
as a static inline instead of a macro it was preferred. At least I've
seen akpm say so, but I'll let him speak for himself (added to CC:)

Cheers,

Harvey

From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] ata: replace macro with static inline in libata.h

Avoid a metric ton of sparse warnings like:
drivers/ata/pata_ali.c:176:14: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_ali.c:176:14: originally declared here

Due to nesting min_t macro inside max_t macro which both use a __x
identifier internally.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/libata.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..b5590fb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -764,7 +764,14 @@ struct ata_timing {
 	unsigned short udma;		/* t2CYCTYP/2 */
 };
 
-#define FIT(v, vmin, vmax)	max_t(short, min_t(short, v, vmax), vmin)
+static inline short FIT(short v, short vmin, short vmax)
+{
+	if (v >= vmax)
+		return vmax;
+	if (v <= vmin)
+		return vmin;
+	return v;
+}
 
 extern const unsigned long sata_deb_timing_normal[];
 extern const unsigned long sata_deb_timing_hotplug[];
-- 
1.5.4.1.1278.gc75be





