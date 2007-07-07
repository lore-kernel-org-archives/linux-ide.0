From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Another Maxtor drive with broken NCQ
Date: Sat, 7 Jul 2007 21:29:58 +0100
Message-ID: <20070707212958.4bd39e20@the-village.bc.nu>
References: <468E8DE1.9010405@redhat.com>
	<468E9360.4070504@garzik.org>
	<468E9469.4090007@redhat.com>
	<468FA862.6030701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41910 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753936AbXGGUXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 16:23:42 -0400
In-Reply-To: <468FA862.6030701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 07 Jul 2007 10:51:14 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Chuck Ebbert wrote:
> > On 07/06/2007 03:09 PM, Jeff Garzik wrote:
> >>> {"Maxtor 6B200M0",      "BANC1BM0",     ATA_HORKAGE_NONCQ }
> >>>
> >>> Or should *all* Maxtor 6B200M0 be blacklisted, since there's already
> >>> one of them in the list?
> >> Wanna send that as a patch, with attribution and sign-offs?  :)
> >>
> > 
> > For all revisions, or just that one new one?
> 
> I don't think all 6B200M0 should be blacklisted, but BANC* is probably 
> bad.  I don't think the code can do wildcard matching, so just the one 
> revision is probably the best we can do at the moment.

Regexp is a bit extreme but a simple "anything starting.."  (untested)
would be ok

--- drivers/ata/libata-core.c~	2007-07-07 21:08:15.560015936 +0100
+++ drivers/ata/libata-core.c	2007-07-07 21:08:15.562015632 +0100
@@ -3869,10 +3869,18 @@
 
 	while (ad->model_num) {
 		if (!strcmp(ad->model_num, model_num)) {
+			unsigned char *tp;
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strcmp(ad->model_rev, model_rev))
-				return ad->horkage;
+			t = strchr(ad->model_rev, '*');
+			if (t == NULL) {
+				if (!strcmp(ad->model_rev, model_rev))
+					return ad->horkage;
+			} else {
+				if (!strncmp(ad->model_rev, model_rev,
+					t-model_rev))
+					return ad->horkage;
+			}
 		}
 		ad++;
 	}
