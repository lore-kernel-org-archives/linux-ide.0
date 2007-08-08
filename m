From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: SATA open bugs
Date: Wed, 8 Aug 2007 15:31:47 -0700
Message-ID: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:21277 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbXHHWbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 18:31:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so153857nze
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 15:31:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Hi Tejun, Alan, Jeff,

This is open bug list for SATA subsystem. It has more items than other
subsystems, but mainly because this is such a hot technology now and
so much work is being done in this area. Needless to say It is very
well maintained and exemplary for some other areas that are not that
lucky...
Andrew and myself did some initial cleaning and updates but we really
need your participation and help with the rest.
Some of open bugs are not actually on this list, only the ones that
has been quiet for a while or never been looked at.
Older bugs are probably not really bugs anymore, since SATA has
changed so much but you can probably clean up this list with good
guesses about things being fixed or fixed already, or simply too cold
to keep open.

Thanks,
--Natalie

http://bugzilla.kernel.org/show_bug.cgi?id=7693
http://bugzilla.kernel.org/show_bug.cgi?id=8738 adaptec and sata bad interaction
http://bugzilla.kernel.org/show_bug.cgi?id=8563 - waiting on alan
http://bugzilla.kernel.org/show_bug.cgi?id=8441 - patch review
http://bugzilla.kernel.org/show_bug.cgi?id=8649
http://bugzilla.kernel.org/show_bug.cgi?id=8649
http://bugzilla.kernel.org/show_bug.cgi?id=8424 - patch review
http://bugzilla.kernel.org/show_bug.cgi?id=8410 - patch status from tejun
http://bugzilla.kernel.org/show_bug.cgi?id=8331 - waiting on reporter
http://bugzilla.kernel.org/show_bug.cgi?id=8281
http://bugzilla.kernel.org/show_bug.cgi?id=8223 small fixup, low
priority tejun is out of time
http://bugzilla.kernel.org/show_bug.cgi?id=7997
http://bugzilla.kernel.org/show_bug.cgi?id=7869
http://bugzilla.kernel.org/show_bug.cgi?id=7811 - regression
http://bugzilla.kernel.org/show_bug.cgi?id=7805 tejun is pinging
pktcdvd maintainer (?)
http://bugzilla.kernel.org/show_bug.cgi?id=7599
http://bugzilla.kernel.org/show_bug.cgi?id=7547 tejun is asking " and Jens
http://bugzilla.kernel.org/show_bug.cgi?id=7545 cold
http://bugzilla.kernel.org/show_bug.cgi?id=7507
http://bugzilla.kernel.org/show_bug.cgi?id=7501
http://bugzilla.kernel.org/show_bug.cgi?id=7500
http://bugzilla.kernel.org/show_bug.cgi?id=7489 status?
http://bugzilla.kernel.org/show_bug.cgi?id=7411 status?
http://bugzilla.kernel.org/show_bug.cgi?id=7241 waiting on reporter
http://bugzilla.kernel.org/show_bug.cgi?id=7119 cold fixed?
http://bugzilla.kernel.org/show_bug.cgi?id=7029 reporter is trying to get the hw
http://bugzilla.kernel.org/show_bug.cgi?id=6891 - old sata report
http://bugzilla.kernel.org/show_bug.cgi?id=6890 - old kernel, needs retesting
http://bugzilla.kernel.org/show_bug.cgi?id=6665 - old kernel
http://bugzilla.kernel.org/show_bug.cgi?id=6594 - cold
http://bugzilla.kernel.org/show_bug.cgi?id=6592 - pinged
http://bugzilla.kernel.org/show_bug.cgi?id=6587
http://bugzilla.kernel.org/show_bug.cgi?id=6516 - waiting on reporter
http://bugzilla.kernel.org/show_bug.cgi?id=6253 - cold? waiting on reporter
http://bugzilla.kernel.org/show_bug.cgi?id=6207 - cold?
http://bugzilla.kernel.org/show_bug.cgi?id=5863 - cold
http://bugzilla.kernel.org/show_bug.cgi?id=5798 - cold
http://bugzilla.kernel.org/show_bug.cgi?id=4968 - cold
http://bugzilla.kernel.org/show_bug.cgi?id=4238 pinged
http://bugzilla.kernel.org/show_bug.cgi?id=3993 pinged
http://bugzilla.kernel.org/show_bug.cgi?id=3725 pinged
http://bugzilla.kernel.org/show_bug.cgi?id=3352 cold? waiting on reporter
http://bugzilla.kernel.org/show_bug.cgi?id=2893 pinged
