From: Tejun Heo <htejun@gmail.com>
Subject: Re: sda
Date: Tue, 15 Apr 2008 14:58:02 +0900
Message-ID: <480443EA.7030901@gmail.com>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>	 <48016F54.5070405@gmail.com>	 <dd18b0c30804122117hc0cd548v6cbef5d2c0c0ce5e@mail.gmail.com>	 <48041E2A.9000602@gmail.com> <dd18b0c30804142227j7ff1723bp6afabfffa6882f1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:44296 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYDOF6I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 01:58:08 -0400
Received: by wa-out-1112.google.com with SMTP id m16so2911961waf.23
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 22:58:08 -0700 (PDT)
In-Reply-To: <dd18b0c30804142227j7ff1723bp6afabfffa6882f1d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello,

Justin Mattock wrote:
> Yes the media plays just fine.
> Overrall this isn't a huge issue for me, It was something I noticed
> when switching to osx and linux,
> Causing enough attention for me to ask the question on how I can have
> the the dvd react properly upon resume.
> but not enough to loose sleep over.

Yeah, I'd like to see the problem fixed too.  It seems more like a 
problem in the media player tho.  The driver and kernel are (after a bit 
of delay) able to deliver the data at normal speed but the media player 
can't recover from the hiccup for some reason.  I think the best course 
of action is to file a bug report against the distro you're using.  The 
bug will likely find its way toward upstream.

Thanks.

-- 
tejun
