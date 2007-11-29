From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 07:52:04 +0900
Message-ID: <474F4294.9030203@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com> <474EE5F8.1030409@gmail.com> <474F0B11.7000205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:18553 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756974AbXK2WwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 17:52:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1722424rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 14:52:11 -0800 (PST)
In-Reply-To: <474F0B11.7000205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Mark Lord wrote:
> I'm split on this one.  For fast systems (typical notebook/desktop) it's
> almost a non-issue either way.
> 
> But a lot of media boxes will be using this code, and they tend to have
> very low-power, slow-clockrate CPUs in the 200-800Mhz range, and so the
> real-time hit there (from PIO) will have a much more significant impact.
> 
> Using DMA as much as possible on those slower platforms is definitely
> a plus towards avoiding non-jerky, skipped frames, or start-stoppy DVD
> recording.
> 
> Now the most intensive commands are still DMA under the proposed scheme,
> so it's not those that one would be concerned with.  But dropping to PIO
> even for a few uncommon commands will still peg a real-time hit or two
> on a slower media processor.
> 
> So..  ????

One thing I don't understand about this argument is that PIO cycle time
is not determined by CPU power.  It's bound by PCI and ATA bus speed.
If you put a faster CPU on the job, it just ends up wasting the same
amount of time burning up more CPU cycles or am I misjudging power of
those embedded CPUs?

-- 
tejun
