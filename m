From: Tejun Heo <tj@kernel.org>
Subject: Re: VIA SATA id 5372 & Pioneer DVR-215 DVD burner problem
Date: Thu, 02 Oct 2008 10:42:34 +0900
Message-ID: <48E4270A.5030107@kernel.org>
References: <loom.20080902T014408-4@post.gmane.org> <20080903095359.27961778.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33049 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbYJBBon (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 21:44:43 -0400
In-Reply-To: <20080903095359.27961778.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Scott Pitcher <scottpitcher@netspace.net.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>

Hello,

Can you please test the attached patch?  It's on top of the upstream
branch of Jeff's libata-dev tree.

  http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
  git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

If you're unfamiliar with git, just lemme know.  I'll send you a patch
against 2.6.27-rc8.

Thanks.

-- 
tejun
