From: Tejun Heo <htejun@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 15:59:32 +0900
Message-ID: <4850C954.60805@gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>	 <485048EC.2080608@gmail.com>	 <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>	 <4850794F.3000200@gmail.com>	 <dd18b0c30806111910j4b127c32rbd546f885731e18c@mail.gmail.com>	 <dd18b0c30806111913gf505c05j479a6a682c2cdd28@mail.gmail.com>	 <4850A2F8.3050404@gmail.com>	 <dd18b0c30806112222k60e411dfs98e4cc7f64938b5b@mail.gmail.com>	 <dd18b0c30806112315x70dee219oa6738de3e22d4939@mail.gmail.com>	 <4850C1AC.4090809@gmail.com> <dd18b0c30806112336ma74115cta1923f7b08dcc2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:20426 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYFLG7i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:59:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3478089wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:59:37 -0700 (PDT)
In-Reply-To: <dd18b0c30806112336ma74115cta1923f7b08dcc2d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Justin Mattock wrote:
> Yeah, take you're time. Maybe it's easier  to have mplayer or which
> ever media player wait for the drive. i.g.
> under OSX, the media player pauses until the drive does it's thing,
> and then resumes.(but this would be for the suspend aspect)
> As for the live distro part I'd have to think as well. Let me know
> what you think.

For apps which know they're accessing cd or dvd (probably using sg
commands), asking for TUR test after resume could be acceptable but apps
getting -EIO on read(2) because of intervening suspend/resume cycle is
just not right.  The problem is that readiness waiting can take quite
some time and under the current architecture, that can make resume take
much longer or block IOs to other devices on the same port.  :-(

-- 
tejun
