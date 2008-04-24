From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Thu, 24 Apr 2008 13:20:27 +0900
Message-ID: <48100A8B.4000102@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240557.42428.volker.armin.hemmann@tu-clausthal.de> <48100609.6000508@gmail.com> <200804240615.23463.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:57593 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbYDXEUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 00:20:39 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2303680wff.4
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 21:20:36 -0700 (PDT)
In-Reply-To: <200804240615.23463.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> emm, even without the double slashes I get the same message:
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
> upstream:upstream
> fatal: Not a git repository
> 
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> fatal: Not a git repository

Hmm... strange.

 > git --version
git version 1.5.2.4
 > git fetch -v 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
upstream:upstream
* refs/heads/upstream: same as branch 'upstream' of 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
   commit: 48feb3c

-- 
tejun
