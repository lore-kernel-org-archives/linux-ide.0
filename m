From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 23:21:42 -0500
Message-ID: <4D3E4FD6.2020902@teksavvy.com>
References: <20110125030410.GA24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:19198 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751692Ab1AYEVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 23:21:43 -0500
In-Reply-To: <20110125030410.GA24024@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

On 11-01-24 10:04 PM, Herbert Poetzl wrote:
> 
> I recently bought the WDC WD20EARS-00MVWB0 because it
> was really cheap for a drive with 64 MB cache, and I
> wanted to try out a 4k sector size disk ...
> 
> Now the drive performs quite well, is rather silent
> and doesn't use much power or produce much heat, but
> at first I didn't find anything in Linux indicating
> that this drive would actually use 4k sectors.
> 
> To shorten things, I asked around on IRC, had a chat
> with some other folks, found a jumper description on
> the WD site talking about an 'Advanced Format' jumper
> and finally contacted WD in a lengthy email thread.

My understanding about that jumper is that
you DO NOT WANT THE JUMPER ON.

Without the jumper, sector 0 is 4KB aligned,
as is any sector multiple of 4.

But WITH the jumper, sector 0 is no longer 4KB aligned..
everything shifts by one (or seven) such that sector
63 ends up being the start of a 4KB low-level sector,
instead of the more sensible sector 64.

Right?
