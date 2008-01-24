From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA timeouts on two disks
Date: Fri, 25 Jan 2008 08:19:14 +0900
Message-ID: <47991CF2.2000403@gmail.com>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>	 <18313.65287.290482.369023@harpo.it.uu.se>	 <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>	 <47944E2E.2070300@gmail.com> <3afbacad0801240931w4587d79cj6a84f36320573a9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:32914 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbYAXXTV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 18:19:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so439673rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 15:19:20 -0800 (PST)
In-Reply-To: <3afbacad0801240931w4587d79cj6a84f36320573a9a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim MacBaine <jmacbaine@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hello,

Jim MacBaine wrote:
> A co-worker, to whom I explained my problem, asked me whether I had
> properly grounded my drives. In fact I had not: The drives resided in
> a vibration-absorbing frame through which their exterior had no
> electrical contact with the grounded case. Since I grounded the drives
> two days ago, I got no new errors.  So maybe my problem is solved.

Hmmm... Grounding..... Interesting.

> If not, I will happily try out your suggestion. Would you be so kind
> to explain in a few words, what connecting one drive to a second
> (supposedly good) PSU will show?

It's just a good way to isolate problems.  For example, the motherboard
could be doing something strange on the 12v rail and the PSU could be
too sensitive causing the whole rail to fluctuate slightly leading to
occasional transmission errors.  SATA links are the first to be affected
by those kinds of electrical problems.

> (Is this still on-topic on this list?)

Yeah, sure.

-- 
tejun
