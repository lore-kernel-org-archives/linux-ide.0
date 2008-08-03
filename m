From: Tejun Heo <tj@kernel.org>
Subject: Re: smartctl -a output on crazy-unloading drives
Date: Mon, 04 Aug 2008 07:46:11 +0900
Message-ID: <48963533.6000900@kernel.org>
References: <4892D1F9.5060106@kernel.org> <3db1ec7f0808030833oa729172u5555235a64b2e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35827 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbYHCWqo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 18:46:44 -0400
In-Reply-To: <3db1ec7f0808030833oa729172u5555235a64b2e4f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ivan N. Zlatev" <contact@i-nz.net>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Ivan N. Zlatev wrote:
> On Fri, Aug 1, 2008 at 12:06 PM, Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> As the $SUBJ says, please post the result of "smartctl -a" on the
>> affected drives for documentation and verification.
>>
> 
> Attached. It should be noted that this machine has been running with
> enforced disabled powersaving (by me) pretty much from day 1.

Can you please test how much the load cycle count increases on the
default setting under light and idle load?

Thanks.

-- 
tejun
