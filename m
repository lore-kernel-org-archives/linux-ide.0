From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_sil680: remove duplicate pcim_enable_device
Date: Sat, 30 Aug 2008 13:09:01 +0200
Message-ID: <48B92A4D.3050801@kernel.org>
References: <20080829153628.GA20130@dhcp-210.hsv.redhat.com> <20080829165024.6d2ff573@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49143 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbYH3LLD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 07:11:03 -0400
In-Reply-To: <20080829165024.6d2ff573@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Milburn <dmilburn@redhat.com>, jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 29 Aug 2008 10:36:28 -0500
> David Milburn <dmilburn@redhat.com> wrote:
> 
>> Remove duplicate call to pcim_enable_device in sil680_init_one.
>>
>> Signed-off-by: David Milburn <dmilburn@redhat.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> Doh.. ;)

Doh... was that me?  Going through the log... Yay, it was me in the
commit f08048e94564d009b19038cfbdd800aa83e79c7f.  Lucky me.  I was
supposed to move enabling above but apparently forgot to killing the
original one.  Heh... anyways.  Thanks for spotting this.

Embarrassingly-Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
