From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from initio
Date: Wed, 1 Feb 2006 23:29:00 +0100
Message-ID: <20060201222900.GA32598@electric-eye.fr.zoreil.com>
References: <43D646C2.6040104@gmail.com> <58cb370e0601240827n771e660bkb1fb3e8589ce1633@mail.gmail.com> <20060124163333.GE23269@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:25774 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1422987AbWBAWg5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 17:36:57 -0500
Content-Disposition: inline
In-Reply-To: <20060124163333.GE23269@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Yes, patches to those web pages are welcome...

--- a/sata/sata-status.html	2006-01-25 17:50:33.000000000 +0100
+++ b/sata/sata-status.html	2006-02-01 23:25:58.000000000 +0100
@@ -14,7 +14,7 @@ urchinTracker();
 
 <center>
 <h1>Serial ATA (SATA) Linux status report</h1>
-<h2>January 25, 2006</h2>
+<h2>February 1, 2006</h2>
 </center>
 
 <P>
@@ -42,6 +42,7 @@ google_ad_channel ="9598368507";
 <li><a href="#recent_updates">Recent updates</a>
 <li><a href="#hw_support">Hardware support</a>
 	<ul>
+	<li><a href="#inic">Initio INI-1623</a></li>
 	<li><a href="#ich5">Intel ICH "IDE mode"</a>
 	<li><a href="#ahci">AHCI (newer Intel ICH, ULi, others)</a>
 	<li><a href="#tx2">Promise TX2/TX4</a>
@@ -77,7 +78,18 @@ Recent updates have concentrated on bug 
 <hr>
 <h2><a name="hw_support">2. Hardware support</a></h2>
 
-
+<h3><a name="inic">Initio INI-1623</a></h3>
+<p>
+Tejun Heo coordinates the development. See the
+<a href="http://marc.theaimsgroup.com/?l=linux-ide">linux-ide</a> mailing-list
+archive to get in touch with him. The hardware documentation is available:
+<ul>
+<li><a href="http://initio.com/images/products/sata/Initio INIC-1623 Databook v1.3.pdf">INIC-1623 1st generation</a></li>
+<li><a
+href="http://initio.com/pdfs/Initio INIC-1620TA2_1622TA2_1623TA2 Databook v1.4.pdf">INIC-1623TA2 2nd generation</a></li>
+</ul>
+</p>
+<hr />
 <h3><a name="ich5">Intel ICH "IDE" mode</a></h3>
 
 Summary: No TCQ/NCQ. Looks like a PATA controller, but with a few added,
