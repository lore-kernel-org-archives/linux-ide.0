From: Tejun Heo <tj@kernel.org>
Subject: Re: SonyDVD Writer errors on boot - gets disabled finally
Date: Fri, 29 Aug 2008 16:36:11 +0200
Message-ID: <48B8095B.6070909@kernel.org>
References: <1ebb7e770807111919u47bef978m702a043267eabd65@mail.gmail.com> <1ebb7e770807111921x2fbfb68fge108adbd066531@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42910 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbYH2OhU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 10:37:20 -0400
In-Reply-To: <1ebb7e770807111921x2fbfb68fge108adbd066531@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vaibhav Kalia <tonytons@gmail.com>
Cc: linux-ide@vger.kernel.org

Vaibhav Kalia wrote:
> hi
> i am facing this problem on my OpenSuse11, Ubuntu 8 installation on my
> system (however the same system with windows xp works fine)
> I am attaching a boot.msg and pasting the part of error here!
> The hardware is:
> One HDD IDE 80gb
> One SATA 300GB
> One SATA 250GB
> Sony IDE DVD Writer
> 
> Sometimes it works fine.. but on an average out of 10 boots,7 times it
> generates an exception.. and 3 times works fine...

Does kernel parameter "libata.force=2.00:udma25" makes any difference?
If it doesn't work, how about "libata.force=2.00:pio4"?

-- 
tejun
