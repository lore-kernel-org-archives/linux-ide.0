From: Tejun Heo <tj@kernel.org>
Subject: Re: [Bug 163753] Strange ATA HD configuration
Date: Sun, 16 Nov 2008 14:54:17 +0900
Message-ID: <491FB589.9060604@kernel.org>
References: <008c01c944ea$5d600660$8c00000a@aageneral.ro> <20081112184821.3bd8d0db@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50517 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYKPFyW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 00:54:22 -0500
In-Reply-To: <20081112184821.3bd8d0db@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian POPA <adrianp@aageneral.ro>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzic@pobox.com, Lionel.Bouton@inet6.fr, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Wed, 12 Nov 2008 19:16:09 +0200
> "Adrian POPA" <adrianp@aageneral.ro> wrote:
> 
>> Hi
>> I have reported this bug quite a while but it was marked as Won't fix
>> However, I have a patch that you can test and which I am using since then.
>> Is no big deal and maybe it can be included in new builds. All builds (last
>> 2.6.22-15.40) 
> 
> The cable detection code has been entirely rewritten since 2.6.22

Yeah, 2.6.22 feels like a life time before at this point.  Adrian, can
you please test 2.6.27.6 and report whether the problems are fixed?

Thanks.

-- 
tejun
