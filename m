From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/12] usb: use IRQ watching
Date: Tue, 15 Jun 2010 19:52:40 +0200
Message-ID: <4C17BDE8.9080300@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-13-git-send-email-tj@kernel.org> <20100614214122.GA21064@suse.de> <4C16A48A.2070404@kernel.org> <4C16AAEE.5090204@kernel.org> <AANLkTilG1KAVOe5DcpLEFAJ-37PQJCgVT-jLZhr1e6tC@mail.gmail.com> <4C176206.90305@kernel.org> <AANLkTinVL4UuF70E1dR1vbYYkVRTBDh5su5D9k0h-vVA@mail.gmail.com> <4C17BA0C.4010208@kernel.org> <20100615174742.GA21616@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49968 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab0FORx1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2010 13:53:27 -0400
In-Reply-To: <20100615174742.GA21616@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, khali@linux-fr.org

On 06/15/2010 07:47 PM, Greg KH wrote:
>> It would really be great to have something like that.  I can easily
>> think of several libata events the user should be notified of from the
>> top of my head but currently are buried in dmesg.
> 
> That is what Andi Kleen and others are working on at the moment.  I
> think he's posted to lkml about it, and there are going to be more talks
> about it at the Plumbers conference this year.

Ah, cool.  Yeah, I'll be happy to be a beta user for such feature.

thanks.

-- 
tejun
