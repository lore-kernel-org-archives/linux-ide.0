From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: possible data corruption on ICH8 or WD raptor
Date: Fri, 1 Aug 2008 23:40:44 +0100
Message-ID: <20080801234044.7617a856@lxorguk.ukuu.org.uk>
References: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs>
	<48929113.4020402@kernel.org>
	<037e01c8f3c2$f81c5330$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54929 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbYHAW55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 18:57:57 -0400
In-Reply-To: <037e01c8f3c2$f81c5330$0400a8c0@dcccs>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Janos Haar <janos.haar@netcenter.hu>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

> The problem only comes on the 4 raptor hdd, and this drive only uses each 
> 6W. (from the documentation).

Are all the drives off the same cable from the PSU - if so you may find
just shuffling some onto different lines is enough.
