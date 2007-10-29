From: Tejun Heo <htejun@gmail.com>
Subject: Re: western digital WD1500ADFD: spurious completions during NCQ
Date: Mon, 29 Oct 2007 15:10:43 +0900
Message-ID: <47257963.3070203@gmail.com>
References: <1192651110.6103.61.camel@thog>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:28359 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbXJ2GKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 02:10:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1976225wah
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 23:10:52 -0700 (PDT)
In-Reply-To: <1192651110.6103.61.camel@thog>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garrett <jeff@jgarrett.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jeff Garrett wrote:
> Several threads that suggest this message is related to poor NCQ
> support, but I did not see any for this drive.  It's a Western Digital
> WD1500ADFD-00NLR1.  Is this the same thing, and should this drive be
> blacklisted?

How reproducible is the problem?

-- 
tejun
