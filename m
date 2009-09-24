From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: disk speed regression kernel 2.6.29 and after
Date: Thu, 24 Sep 2009 21:12:30 +0200
Message-ID: <200909242112.30247.bzolnier@gmail.com>
References: <4ABA0FDA.9090707@sbcglobal.net> <200909241934.27472.bzolnier@gmail.com> <200909242011.20032.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:50937 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbZIXTLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2009 15:11:50 -0400
In-Reply-To: <200909242011.20032.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: whansard@sbcglobal.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

On Thursday 24 September 2009 20:11:18 Frans Pop wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Regarding additional pursue of the root cause, I think that it is not
> > worth the effort currently since there were no other reports about
> > similar problems and libata is a better solution on most modern systems
> > anyway. 
> 
> I'm surprised at this, especially if the commit Will bisected it to [1] is 
> the culprit. That is a change in generic ide code and could thus very well 
> affect other users too.
> 
> This is a clear regression and IMHO, if it is confirmed that that commit is 
> the cause of the regression, it should be fixed. And if not, it could 
> still be worthwhile to track down which commit is the cause.

If somebody would like to do it please go ahead.

Unfortunately I have absolutely no time to work on IDE anymore as I have
moved on other projects so unless the issue have no known solution/workaround
(this one has such) I'm rather reluctant to pick it up as there is a plenty
of more higher-prio kernel wide issues (including things like mm regressions)
to fix.

> As for the lack of other reports, that could very well simply be because:
> 1) there are not that many users of IDE drivers anymore
> 2) most users don't really consciously watch their disk speed

or more likely:

3) the issue is highly configuration dependent and not worth the hassle
   given the known solution/workaround

> As long as the IDE code is in mainline, I don't see why regressions should 
> be ignored. Adding the ide list and David to CC for other opinions.

BTW Please always Cc: David first on all IDE issues as he is the main IDE
slave now and the transition period is long over.
